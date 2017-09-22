class Volunteer
  attr_reader :name, :project_id

  def initialize(attributes)
    @name = attributes[:name]
    @project_id = attributes[:project_id]
  end

  def ==(another_volunteer)
    self.name.==(another_volunteer.name).&(self.project_id.==(another_volunteer.project_id))
  end

end
