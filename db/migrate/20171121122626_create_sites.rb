class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :site_name
      t.string :search_url
      t.string :main_url

      t.timestamps
    end
    add_index :sites, :site_name
    add_index :sites, :search_url
    add_index :sites, :main_url
  end
end
