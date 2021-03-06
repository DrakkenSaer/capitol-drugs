# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# Note: If a preference is set here it will be stored within the cache & database upon initialization.
#       Just removing an entry from this initializer will not make the preference value go away.
#       Instead you must either set a new value or remove entry, clear cache, and remove database entry.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false
  country = Spree::Country.find_by_name('United States') if ActiveRecord::Base.connection.data_source_exists? 'countries'
  config.default_country_id = country.id if country.present?
end

Spree.user_class = "Spree::User"

Spree::PermittedAttributes.user_attributes << :firstname
Spree::PermittedAttributes.user_attributes << :lastname
Spree::PermittedAttributes.user_attributes << [bill_address_attributes: [:id, :firstname, :lastname, :address1, :address2, :city, :zipcode, :phone, :state_name, :alternative_phone, :company, :state_id, :country_id, :created_at, :updated_at]]
Spree::PermittedAttributes.user_attributes << [ship_address_attributes: [:id, :firstname, :lastname, :address1, :address2, :city, :zipcode, :phone, :state_name, :alternative_phone, :company, :state_id, :country_id, :created_at, :updated_at]]
