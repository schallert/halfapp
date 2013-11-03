class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.boolean :isGoing

      t.timestamps
    end
  end
end
