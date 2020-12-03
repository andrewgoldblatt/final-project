class CreateClubMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :club_members do |t|
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :year
      t.integer :phone_number
      t.integer :rentals_count

      t.timestamps
    end
  end
end
