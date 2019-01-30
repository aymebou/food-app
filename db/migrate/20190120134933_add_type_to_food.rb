class AddTypeToFood < ActiveRecord::Migration[5.2]
  def change
     add_reference :foods, :type, index: true, foreign_key: true
  end
end
