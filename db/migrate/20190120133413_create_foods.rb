class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :name
      t.float :carbs
      t.float :fibers
      t.float :proteins
      t.float :lipids
      t.integer :cal
      t.string :imgUrl

      t.timestamps
    end
  end
end
