class LinkDomainUsers < ActiveRecord::Migration
  def change
  create_table :domains_users do |t|
      t.integer :domain_id
      t.integer :user_id
      end
  end
end
