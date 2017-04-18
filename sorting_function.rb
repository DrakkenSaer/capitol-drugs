xls = Roo::Spreadsheet.open('t.xls')
sheet = xls.sheet(0)
product_sheet_hash_array = sheet.each(name: 'Name/Item_Size/Form', sku: 'CDI_Sku', price: 'Everyday_Price', upc: 'UPC_Code')

# Create Taxons
sheet.each_with_index(brand: 'Brand', category: 'Category', sub_category: 'Sub_Category') do |hash, index|
    next if index == 0
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
