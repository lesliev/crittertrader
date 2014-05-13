class CreateCritters < ActiveRecord::Migration
  def change
    create_table :critters do |t|
      t.string :token
      t.string :data_hash
      t.text :data

      t.timestamps
    end

    add_index :critters, :token, unique: true
    add_index :critters, :data_hash, unique: true
  end
end
