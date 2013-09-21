class Addrowtouser < ActiveRecord::Migration
  def change
		add_column :users, :photo, :string, :default => " "
		add_column :users, :is_active, :boolean, :default => true
  end
end
