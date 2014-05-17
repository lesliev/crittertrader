class AddFieldsToCritter < ActiveRecord::Migration
  def change
    add_column :critters, :critterding_version, :string
    add_column :critters, :environment_hash, :string
  end
end
