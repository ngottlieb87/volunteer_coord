require ('sinatra')
require ('sinatra/reloader')
also_reload ('lib/**/*.rb')
require ('./lib/project')
require ('./lib/volunteer')
require ('pry')
require ('capybara')
require('pg')

DB = PG.connect({:dbname => 'volunteer_tracker'})

get('/') do
  @projects_list= Project.all()
  @volunteers = Volunteer.all()
  erb(:index)
end

post('/') do
  title = params["title"]
  new_project= Project.new({:title => title, :id =>nil})
  new_project.save
  @projects_list = Project.all()
  erb(:index)
end

get('/project/:id/volunteer') do
  @project = Project.find(params["id"].to_i())
  erb(:volunteers)
end

post('/project/:id/volunteer') do
  name = params.fetch("name")
  project_id = params.fetch("project_id").to_i
  volunteer = Volunteer.new({:name => name, :project_id => project_id})
  volunteer.save
  @volunteer = Project.find(project_id)
  @project = Project.find(params["id"].to_i())
  erb(:volunteers)
end

get('/project/:id/update') do
  @project_edit= Project.find(params.fetch("id").to_i())
  erb(:details)
end

get('/project/:id/') do
  @project_edit= Project.find(params.fetch("id").to_i())
  erb(:edit_project)
end


get('/project/:id/edit') do
  @project_edit= Project.find(params.fetch("id").to_i())
  erb(:edit_project)
end

patch('/project/:id') do
  title = params.fetch("title")
  @project_edit= Project.find(params.fetch("id").to_i())
  @project_edit.update({:title => title})
  @projects_list = Project.all()
  erb(:index)
end

delete('/project/:id') do
  @project_edit = Project.find(params.fetch("id").to_i())
  @project_edit.delete
  @projects_list = Project.all()
  erb(:index)
end
