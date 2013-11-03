class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.boolean :is_going

      t.timestamps
    end
  end
end
