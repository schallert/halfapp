class Response < ActiveRecord::Base
  belongs_to :brother

  def guests_formatted
    if guests and guests > 0
      "+" + guests.to_s
    else
      ""
    end
  end

  def self.total_count
    sum = 0
    Response.all.each do |res|
      sum += 1
      sum += res.guests if res.guests
    end
    sum
  end
end
