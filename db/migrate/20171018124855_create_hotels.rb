class CreateHotels < ActiveRecord::Migration[5.1]
  def change
    create_table :hotels do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :hotel_name
      t.string :description
      t.integer :price
      t.json :images
      t.string :country
      t.string :city
      t.integer :rating
      t.timestamps
    end
  end
end
