class AddDeviseTokenAuthToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string, :null => false
    add_column :users, :uid, :string, :null => false, :default => "" 
    add_column :users, :tokens, :text
    add_index :users, [:uid, :provider], :unique => true
  end
end
