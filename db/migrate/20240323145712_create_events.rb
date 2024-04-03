class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :note
      t.string :type
      t.integer :parent_id
      t.integer :position

      t.timestamps
    end
  end
end
