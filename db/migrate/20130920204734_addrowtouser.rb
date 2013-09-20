class Addrowtouser < ActiveRecord::Migration
  def change
		add_column :users, :photo, :string, :default => " "
  end
end
