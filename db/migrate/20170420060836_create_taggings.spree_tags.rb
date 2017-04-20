# This migration comes from spree_tags (originally 20170419204821)
class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :spree_taggings do |t|
      t.belongs_to :taggable, index: true, polymorphic: true
      t.belongs_to :tag, index: true

      t.timestamps null: false
    end
  end
end
