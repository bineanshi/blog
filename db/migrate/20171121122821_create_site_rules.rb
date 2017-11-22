class CreateSiteRules < ActiveRecord::Migration
  def change
    create_table :site_rules do |t|
      t.integer :site_id
      t.string :site_name
      t.string :rule_name
      t.text :rule_value
      t.text :links
      t.timestamps
    end
    add_index :site_rules, :site_id
    add_index :site_rules, :site_name
    add_index :site_rules, :rule_name
  end
end
