class Response < ActiveRecord::Base
  belongs_to :brother

  def self.total_count
    sum = 0
    Response.all.each do |res|
      sum += 1
      sum += res.guests
    end
    sum
  end
end
