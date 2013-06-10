class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.string :artist
      t.integer :year
      t.integer :user_id

      t.timestamps
    end
  end
end
