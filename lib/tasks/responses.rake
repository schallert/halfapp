namespace :responses do
  desc "Remove all current responses"
  task :reset => :environment do
    Response.delete_all
  end
end
