class CreateBrothers < ActiveRecord::Migration
  def change
    create_table :brothers do |t|
      t.string :name
      t.string :phoneNumber

      t.timestamps
    end
  end
end
