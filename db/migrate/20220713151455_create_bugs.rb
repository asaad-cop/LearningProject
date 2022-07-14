class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title
      t.text :description
      t.string :screenshot
      t.date :deadline
      t.integer :bug_type, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
