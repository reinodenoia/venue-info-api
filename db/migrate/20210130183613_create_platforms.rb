class CreatePlatforms < ActiveRecord::Migration[6.0]
  def change
    create_table :platforms do |t|
      t.string  :name
      t.text    :fields
      t.integer :category_range, array: true, default: [1000, 1200]
      t.string  :hours_format

      t.timestamps
    end
  end
end
