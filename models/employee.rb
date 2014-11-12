class Employee
  attr_accessor :name, :projects

  def initialize args={}
    @name = args[:name]
    @projects = Hash.new(0)
  end

  def add_time_entry entry
    @projects[entry.project]+= entry.hours
  end
end
