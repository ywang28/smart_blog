class AddUserNameToTags < ActiveRecord::Migration
  def change
    add_column :tags, :user_name, :string
  end
end
