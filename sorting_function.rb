xls = Roo::Spreadsheet.open('t.xls')
sheet = xls.sheet(0)
product_sheet_hash_array = sheet.each(name: 'Name/Item_Size/Form', sku: 'CDI_Sku', price: 'Everyday_Price', upc: 'UPC_Code')

# Create Taxons
sheet.each_with_index(brand: 'Brand', categories: 'Category', sub_category: 'Sub_Category') do |hash, index|
    next if index == 0
    hash.map do |key, value|
        puts hash, key, value

        query = nil
        if key.to_s == 'sub_category'
            category = Spree::Taxon.find_by(name: 'Categories')
            query = { name: hash[:categories].to_s.titleize, parent_id: category.id, taxonomy_id: category.taxonomy_id }
        else
            query = { name: key.to_s.titleize }
        end

        parent = Spree::Taxon.find_or_create_by!(query)
        Spree::Taxon.find_or_create_by!(name: value.to_s.titleize, 
                                        parent_id: parent.id, 
                                        taxonomy_id: parent.taxonomy_id) unless value.to_s.titleize == parent.name
    end
end

