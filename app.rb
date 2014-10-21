['sinatra','haml','letsfreckle','pry','dotenv'].each{|file| require file}

#load environmental variables and Configure Freckle
Dotenv.load
LetsFreckle.configure do
  account_host ENV['host']
  username ENV['username']
  token ENV['token']
end

time_report = {}
#Search for entries from a specific start date and tags
LetsFreckle::Entry.find(from: "2014-10-12", to: "2014-10-18").each do |entry|
  time_report[entry.user_name] = {} if time_report[entry.user_name] = nil
  time_report["project_name"] = entry.project.name
  time_report["entry_time"] = entry.minutes / 60
end
binding.pry
get '/' do
  p project
end
