require 'csv'

namespace :brothers do
  desc "import brothers info into the database"
  task :import => :environment do
    path = File.join(Rails.root, "lib", "tasks", "brothers.csv")
    CSV.foreach(path) do |row|
      first_name = row[0]
      last_name = row[1]
      name = first_name + " " + last_name
      phone_number = GlobalPhone.normalize(row[3])
      Brother.create!(
        :name => name,
        :phone_number => phone_number)
    end
  end

end
