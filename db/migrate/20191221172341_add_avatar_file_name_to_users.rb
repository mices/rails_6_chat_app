class AddAvatarFileNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :avatar_file_name, :string
  end
end
