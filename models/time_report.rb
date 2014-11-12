class TimeReport
  attr_accessor :start_date, :end_date
  attr_reader :employees, :projects

  def initialize args={}
    @start_date = args[:start_date]
    @end_date = args[:end_date]
    @employees = Set.new
    @projects = Set.new
  end

  def fetch_employee new_employee_name
    @employees.select {|e| e.name == new_employee_name}[0]
  end

  def add_project project
    @projects << project
  end

  def add_employee employee
    @employees << employee
  end
end
