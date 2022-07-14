class RemoveBugTypeFromBug < ActiveRecord::Migration[5.2]
  def change
    remove_column :bugs, :bug_type, :integer
  end
end
