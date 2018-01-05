require 'roo'

# Method to import Taxons & Taxonomies 
def import_taxonomies(row)
    row.map do |key, value|
        query = nil
        taxonomy_name = key.to_s.gsub('sub_', '')
        taxonomy = Spree::Taxonomy.find_or_create_by!(name: taxonomy_name.titleize)

        if key.to_s.include? 'sub_'
            taxon = Spree::Taxon.find_by_name(taxonomy.name)
            query = { name: row[taxonomy_name.to_sym].to_s.titleize,
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

def import_image(url, product)
    image = product.images.new
    image.attachment = open(url)
    image.save!
end

def import_spreadsheet(rows, capture_headers = false)
    rows.each_with_index(name: 'Product Name', 
                sku: 'sku', 
                price: 'everyday_price', 
                upc: 'upc',
                description: 'long_description',
                brand: 'Brand Name', 
                category: 'Product Category Name', 
                sub_category: 'Sub Category Name',
                image_url: 'ImageURL') do |row, index|

        unless capture_headers
            next if index == 0
        end
    
        p row

        query = { name: row[:name].titleize,
                  sku: row[:sku],
                  price: row[:price], 
                  upc: row[:upc],
                  description: row[:description],
                  shipping_category: Spree::ShippingCategory.find_or_create_by!(name: 'Default'),
                  available_on: DateTime.now }
    
        taxons = row.slice(:brand, :category, :sub_category)
        import_taxonomies(taxons)
    
        product = Spree::Product.find_by(name: query[:name])
        if product.present?
            product.assign_attributes(query)
            product.update!(query) if product.changed?
        else
            product = Spree::Product.create!(query)
        end

        if row.image_url.present?
            import_image(row.image_url, product)
        end

        taxons.map do |key, value|
            taxon = Spree::Taxon.find_by_name(value.titleize)
            taxon.products << product unless taxon.products.include? product
        end
    end
end

def import_csv(csv_file)
    quote_chars = %w(" | ~ ^ & * ")

    begin
        csv = Roo::Spreadsheet.open(csv_file, csv_options: { quote_char: quote_chars.shift, col_sep: "\t" })

        csv.each_with_pagename do |name, sheet|
            p "Importing sheet: '" + name + "'..."
    
            import_spreadsheet(sheet)
        end    
    rescue CSV::MalformedCSVError
        p "Import failed: Incorrect quote character, retrying with '" + quote_chars.first + "'..."

        quote_chars.empty? ? raise : retry 
    end
end