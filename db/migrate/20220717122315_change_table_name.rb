class ChangeTableName < ActiveRecord::Migration[5.2]
  def change
    rename_table :users_projects, :projects_users
  end
end
