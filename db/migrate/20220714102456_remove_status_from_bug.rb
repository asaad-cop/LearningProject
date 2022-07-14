class RemoveStatusFromBug < ActiveRecord::Migration[5.2]
  def change
    remove_column :bugs, :status, :integer
  end
end
