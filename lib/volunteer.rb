class Volunteer
  attr_reader :name, :id, :project_id

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
      all_volunteers.push(Volunteer.new({:name => name,:id => nil, :project_id=> project_id}))
    end
    all_volunteers
  end

  def self.find(id)
    Volunteer.all.each do |volunteer|
      if volunteer.id.==(id)
        return volunteer
      end
    end
    return nil
  end

  def save
    DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', '#{@project_id}') RETURNING id;")
  end

end
