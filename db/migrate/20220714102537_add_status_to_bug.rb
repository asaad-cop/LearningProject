class AddStatusToBug < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :status, :integer, default: 0
  end
end
