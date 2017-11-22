class AddImagesToSiteRule < ActiveRecord::Migration
  def change
    add_column :site_rules, :images, :text
  end
end
