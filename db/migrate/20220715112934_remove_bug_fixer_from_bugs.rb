class RemoveBugFixerFromBugs < ActiveRecord::Migration[5.2]
  def change
    remove_column :bugs, :bug_fixer, :integer
  end
end
