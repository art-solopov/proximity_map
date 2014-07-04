class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longtitude

      t.timestamps
    end
  end
end
