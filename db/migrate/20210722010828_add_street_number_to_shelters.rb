class AddStreetNumberToShelters < ActiveRecord::Migration[5.2]
  def change
    add_column :shelters, :street_number, :string
  end
end
