class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.integer :people_number
      t.datetime :start_date
      t.datetime :end_date
      t.integer :price
      t.bigint :total_price

      t.timestamps
    end
  end
end
