class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :gender, :string
    add_column :users, :gender_preference, :string
    add_column :users, :age, :integer
  end
end
