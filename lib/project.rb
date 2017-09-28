class Project
  attr_reader :title, :id

  def initialize(attributes)
    @title = attributes[:title]
    @id = attributes[:id]
  end


  def self.all
    projects = DB.exec("SELECT * FROM projects;")
    all_projects = []
    projects.each do |project|
      title = project["title"]
      id = project["id"].to_i
      all_projects.push(Project.new({:title=> title, :id=> id}))
    end
    all_projects
  end

  def ==(another_project)
    self.title.==(another_project.title).&(self.id.==(another_project.id))
  end

  def self.find(id)
    Project.all.each do |project|
      if project.id.==(id)
        return project
      end
    end
    return nil
  end

  def volunteers
    project_volunteers= []
    volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{self.id()};")
    volunteers.each do |volunteer|
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id").to_i()
      id = volunteer["id"]
      project_volunteers.push(Volunteer.new({:name => name, :id => id ,:project_id => project_id}))
    end
    project_volunteers
  end

  def update(attributes)
    @title = attributes.fetch(:title)
    @id= self.id()
    DB.exec("UPDATE projects SET (title) = ('#{@title}') WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{self.id()};")
    DB.exec("DELETE FROM volunteers WHERE project_id = #{self.id()};")
  end

  def save
    @id= DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;").first.fetch("id").to_i()
  end
end
