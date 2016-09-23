# This migration comes from spree_tags (originally 20160921210134)
class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :spree_identities do |t|
      t.belongs_to :tag, index: true, foreign_key: true
      t.belongs_to :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
