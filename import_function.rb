# Method to import Taxons & Taxonomies 
def import_taxonomies(hash)
    hash.map do |key, value|
        query = nil
        taxonomy_name = key.to_s.gsub('sub_', '')
        taxonomy = Spree::Taxonomy.find_or_create_by!(name: taxonomy_name.titleize)

        if key.to_s.include? 'sub_'
            taxon = Spree::Taxon.find_by_name(taxonomy.name)
            query = { name: hash[taxonomy_name.to_sym].to_s.titleize,
                      parent_id: taxon.id,
                      taxonomy_id: taxonomy.id }
        else
            query = { name: taxonomy.name }
        end

        parent = Spree::Taxon.find_or_create_by!(query)
        Spree::Taxon.find_or_create_by!(name: value.to_s.titleize, 
                                        parent_id: parent.id, 
                                        taxonomy_id: parent.taxonomy_id) unless value.to_s.titleize == parent.name
    end
end

def import_spreadsheet(sheet)
    sheet.each_with_index(name: 'Name/Item_Size/Form', 
                            sku: 'CDI_Sku', 
                            price: 'Everyday_Price', 
                            upc: 'UPC_Code',
                            brand: 'Brand', 
                            category: 'Category', 
                            sub_category: 'Sub_Category') do |hash, index|
    
        next if index == 0
    
        query = { name: hash[:name].titleize,
                  sku: hash[:sku],
                  price: hash[:price], 
                  shipping_category: Spree::ShippingCategory.find_or_create_by!(name: 'Default') }
    
        taxons = hash.slice(:brand, :category, :sub_category)
        import_taxonomies(taxons)
    
        product = Spree::Product.find_by(name: query[:name])
        if product.present?
            product.assign_attributes(query)
            product.update!(query) if product.changed?
        else
            product = Spree::Product.create!(query)
        end
    
        taxons.map do |key, value|
            taxon = Spree::Taxon.find_by_name(value.titleize)
            taxon.products << product unless taxon.products.include? product
        end
    end
end