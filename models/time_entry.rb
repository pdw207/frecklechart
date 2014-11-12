class TimeEntry
  attr_accessor :hours, :project, :name

  def initialize args={}
    @name= args[:name]
    @project = args[:project]
    @hours = args[:minutes].to_f / 60
  end

  def hours
    @hours.round(2)
  end
end
