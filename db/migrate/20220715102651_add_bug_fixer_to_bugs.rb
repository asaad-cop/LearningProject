class AddBugFixerToBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :bug_fixer, :integer, foreign_key: true
  end
end
