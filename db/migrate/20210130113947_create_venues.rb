class CreateVenues < ActiveRecord::Migration[6.0]
  def change
    create_table :venues do |t|
      t.string  :name
      t.string  :address
      t.string  :additional_address
      t.float   :lat
      t.float   :lng
      t.integer :category
      t.boolean :closed 
      t.string  :hours, array: true, default: []
      t.string  :website
      t.string  :phone

      t.timestamps
    end
  end
end
