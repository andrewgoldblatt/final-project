class CreateGears < ActiveRecord::Migration[6.0]
  def change
    create_table :gears do |t|
      t.string :photo
      t.string :name
      t.string :condition
      t.string :size

      t.timestamps
    end
  end
end
