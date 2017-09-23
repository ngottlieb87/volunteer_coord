# GreenWave Volunteer

#### _Add, delete, update volunteers and projects_

#### By _**Noah Gottlieb**_

## Description

_This webpage will let a volunteer event coordinator update projects, add volunteers to projects and delete projects all together. Deleting projects will also delete any volunteers associated with that project._

### Setup (IMPORTANT: This application require a local postgres server to be running)
1. Clone the project and run `bundle`.
2. run `psql` in a terminal to create the db structure.
3. run `CREATE DATABASE volunteer_tracker`.
4. `CREATE TABLE projects(id serial PRIMARY KEY, title varchar);'
5. run `CREATE table volunteers (id serial primary key,  name varchar, project_id int);
6. To run the specs you need to: `CREATE DATABASE volunteer_tracker_test WITH TEMPLATE volunteer_tracker;`
7. In separate terminal tab/window start up the app by running `ruby app.rb'.


## Known Bugs

* _No Bugs Recorded_

## Specs

| Behavior |  Input | Output |
| ------------- |:-------------:| -----:|
| Receives a project title and displays it in a list to the top of the page | "Potluck in the park" | "Potluck in the park" |
| Can add multiple projects to be displayed | "Trash Pick Up"| "Trash Pick Up" |
| | | "Trash Pick Up" |
| Click on project and takes you to a new page where you will be able to add volunteers for the project |  "Tommy, Samantha, Dorothy" | "Tommy, Samantha, Dorothy"|
| update project name | Potluck in the Park | Trash pick up => Potluck in the park |
|delete project and its volunteers | delete button | *project removed from list*|

## Support and contact details

_For support you can reach me at:_
_nogpdx@gmail.com_

## Technologies Used

_HTML, CSS, Bootstrap, Sinatra, Ruby, Postgres, Psql_

### License

Copyright (c) 2017 **_Noah Gottlieb_**
