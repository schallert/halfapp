class AddGuestsToResponse < ActiveRecord::Migration
  def change
    add_column :responses, :guests, :integer
  end
end
