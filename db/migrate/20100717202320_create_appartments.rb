class CreateAppartments < ActiveRecord::Migration
  def self.up
    create_table :appartments do |t|
      t.string :title
      t.string :price
      t.string :bd
      t.string :ba
      t.string :sqft
      t.string :posted_at
      t.integer :request_id

      t.timestamps
    end
  end

  def self.down
    drop_table :appartments
  end
end
