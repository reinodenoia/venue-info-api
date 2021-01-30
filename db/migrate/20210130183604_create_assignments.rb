class CreateAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :assignments do |t|
      t.integer :venue_id
      t.integer :platform_id
      t.string  :api_key

      t.timestamps
    end
  end
end
