#require gems
['sinatra','haml','letsfreckle','pry','dotenv'].each{|file| require file}

#require models
['employee', 'time_report', 'time_entry'].each{|file| require_relative './models/' + file }

#load environmental variables and Configure Freckle
Dotenv.load
LetsFreckle.configure do
  account_host ENV['host']
  username ENV['username']
  token ENV['token']
end


##intitialize variables
start_date = "2014-11-10"
end_date = "2014-11-14"

report = TimeReport.new(start_date: start_date, end_date: end_date)

##Ping Freckle and add each record to report
LetsFreckle::Entry.find(from: start_date, to: end_date).each do |entry|

  #Cnsolidated certain projects
  ["McKesson", "Vermonster"].each do|consolidated_project_name|
    if entry.project.name.include? consolidated_project_name
      entry.project.name = consolidated_project_name
    end
  end

  # create time entry object
  time_entry = TimeEntry.new(project: entry.project.name, name: entry.user_name, minutes: entry.minutes)

  #Create list of projects in report
  report.add_project time_entry.project

  # get employee record from report
  employee = report.fetch_employee entry.user_name

  #create new employee if not inlcuded in report
  unless employee
    employee = Employee.new(name: entry.user_name)
    report.add_employee employee
  end

  #add time report to employee record
  employee.add_time_entry time_entry

end

get '/' do
  @report = report
  erb :index
end

set :views, File.dirname(__FILE__) + '/views'
