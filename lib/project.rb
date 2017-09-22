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


  def save
    @id= DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;").first.fetch("id").to_i()
  end
end
