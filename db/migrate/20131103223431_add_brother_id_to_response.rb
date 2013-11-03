class AddBrotherIdToResponse < ActiveRecord::Migration
  def change
    add_column :responses, :brother_id, :integer
  end
end
