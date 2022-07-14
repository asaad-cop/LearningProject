class AddBugTypeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bug_type, :string
  end
end
