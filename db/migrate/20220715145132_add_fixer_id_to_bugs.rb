class AddFixerIdToBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :fixer_id, :integer
  end
end
