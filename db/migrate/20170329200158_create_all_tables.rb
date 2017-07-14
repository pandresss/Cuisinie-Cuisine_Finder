class CreateAllTables < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
        t.string :name
        t.string :address
        t.string :img_url
        t.string :cost
        t.string :menu
        t.string :lat
        t.string :lon
        t.string :restaurant_id
        t.string :user_rating
        t.timestamps
    end

    create_table :comments do |t|
        t.string :author
        t.string :content
        t.belongs_to :user, index: true
        t.belongs_to :restaurant, index: true
        t.timestamps
    end

    create_table :cuisines do |t|
      t.string  :name
      t.string  :value
      t.timestamps
    end

    create_table :restaurants_users do |t|
        t.belongs_to :user, index: true
        t.belongs_to :restaurant, index: true
      t.timestamps
    end

  end
end
