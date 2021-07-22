class AddStreetNameToShelters < ActiveRecord::Migration[5.2]
  def change
    add_column :shelters, :street_name, :string
  end
end
