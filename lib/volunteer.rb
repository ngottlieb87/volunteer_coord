class Volunteer
  attr_reader :name,:project_id, :id


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
    found_volunteer = nil
    Volunteer.all().each do |volunteer|
      if volunteer.id().==(id)
        found_volunteer = volunteer
      end
    end
    found_volunteer
  end

  def save()
    result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def update(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    DB.exec("UPDATE volunteers SET name = '#{name}' WHERE id = #{@id};")
  end

end
