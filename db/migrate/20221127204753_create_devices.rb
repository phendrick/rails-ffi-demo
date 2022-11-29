class CreateDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :devices do |t|
      t.string :identifier
      t.string :name
      t.integer :classification

      t.timestamps
    end
  end
end
