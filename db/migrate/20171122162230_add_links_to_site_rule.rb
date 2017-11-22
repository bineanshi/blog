class AddLinksToSiteRule < ActiveRecord::Migration
  def change
    add_column :site_rules, :links, :text
  end
end
