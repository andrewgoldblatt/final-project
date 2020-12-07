class CreateRentals < ActiveRecord::Migration[6.0]
  def change
    create_table :rentals do |t|
      t.integer :gear_id
      t.date :check_out_date
      t.date :return_date
      t.integer :member_id
      t.string :checkout_note

      t.timestamps
    end
  end
end
