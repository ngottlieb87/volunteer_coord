class Volunteer
  attr_reader :name, :project_id

  def initialize(attributes)
    @name = attributes[:name]
    @project_id = attributes[:project_id]
  end

  def ==(another_volunteer)
    self.name.==(another_volunteer.name).&(self.project_id.==(another_volunteer.project_id))
  end

  def self.all
    volunteers = DB.exec("SELECT * FROM volunteers;")
    all_volunteers = []
    volunteers.each do |volunteer|
      name = volunteer["name"]
      project_id = volunteer["project_id"].to_i
      all_volunteers.push(Project.new({:name => name, :project_id=> project_id}))
    end
    all_volunteers
  end

end
