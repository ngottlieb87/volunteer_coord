class Project
  attr_reader :title, :id

  def initialize(attributes)
    @title = attributes[:title]
    @id = attributes[:id]
  end


  def self.all
    project_titles = DB.exec("SELECT * FROM projects;")
    titles = []
    projects_titles.each do |title|
      title = title["title"]
      id = title["id"].to_i
      titles.push(Title.new({:title=> title, :id=> id}))
    end
    titles
  end

  def ==(another_project)
    self.title.==(another_project.title).&(self.id.==(another_project.id))
  end

  def save
    result= DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first.fetch("id").to_i()
  end
end
