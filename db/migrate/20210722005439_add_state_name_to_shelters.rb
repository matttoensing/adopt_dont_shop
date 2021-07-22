class AddStateNameToShelters < ActiveRecord::Migration[5.2]
  def change
    add_column :shelters, :state_name, :string
  end
end
