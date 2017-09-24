class Volunteer
  attr_reader :name, :project_id, :id

  def initialize(attributes)
    @name = attributes[:name]
    @project_id = attributes[:project_id]
    @id= attributes[:id]
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
      id = volunteer["id"].to_i
      all_volunteers.push(Volunteer.new({:name => name, :id => nil, :project_id => project_id}))
    end
    all_volunteers
  end


  def self.find(id)
    volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};")
    name = volunteer.first.fetch("name")
    project_id = volunteer.first.fetch("project_id").to_i
    Volunteer.new({:name => name, :project_id => project_id, :id => id })
  end

  def save
    @id= DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;").first.fetch("id").to_i
  end

end
