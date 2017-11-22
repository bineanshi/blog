class ChangeRuleValueToSiteRule < ActiveRecord::Migration
  def change
  		change_column :site_rules, :rule_value ,:text
  end
end