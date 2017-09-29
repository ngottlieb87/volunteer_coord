class Volunteer
  attr_reader :name,:project_id, :id


  def initialize(attributes)
    @name = attributes[:name]
    @project_id = attributes[:project_id]
    @id = attributes[:id]
  end

  def ==(another_volunteer)
    self.name.==(another_volunteer.name).&(self.project_id.==(another_volunteer.project_id))
  end

  def self.all
    volunteers = DB.exec("SELECT * FROM volunteers;")
    all_volunteers = []
    volunteers.each do |volunteer|
      name = volunteer["name"]
      @project_id = volunteer["project_id"].to_i
      id = volunteer["id"].to_i
      all_volunteers.push(Volunteer.new({:name => name, :id => id, :project_id => @project_id}))
    end
    all_volunteers
  end

  def self.find(id)
    found_volunteer = nil
    Volunteer.all().each do |volunteer|
      if volunteer.id().==(id)
        found_volunteer = volunteer
      end
    end
    found_volunteer
  end

  def projects
    volunteer_proj = []
    projects = DB.exec("SELECT * FROM projects WHERE id = #{self.project_id};")
    projects.each do |project|
      title = project["title"]
      @id = project["id"].to_i
      volunteer_proj.push(Project.new({:title => title, id: @id}))
    end
    volunteer_proj
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def update(attributes)
    @name = attributes.fetch(:name)
    @id = self.id
    DB.exec("UPDATE volunteers SET name = '#{name}' WHERE id = #{@id};")
  end

end
