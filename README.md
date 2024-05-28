# Read Me!

## Hello 301 Academic Skills Centre, we hope our code can be useful to you - thank you so much for being great clients! - Team 04, Software Hut 2024

## The System

The site runs using a programming language called Ruby and its web development framework Rails, although there are more languages used. The directory has been laid out in a way that is hopefully easy to navigate, to make it easier to find files (although if you are struggling see below). As well as this, we have written some RSpec unit tests to test individual components of the site. They can be ran using the command:
```bundle exec rspec *``` from the app directory.  

## Quick Navigation
Need to change something? If you need to work on...

- The way the users send data to / from the app? head to *app/controllers*
- The styling of the site - without editing the layout of the site itself? head to *app/packs/styles*
- The layout and elements of the site? head to *app/packs/views*
- The scripting of the site (or the HTML of prompt builder)? head to *app/packs/scripts*
- The RSpec tests we wrote? head to *app/spec*

## A Note On the .keep Files...
In each directory, you will notice a .keep file. This is a file containing a description of every file we have added and what it does. Unfortunately, Rails sometimes interprets the .md files we would usually use as code, so this is our workaround! The information is still all present inside

## Common Problems
### Database
Our database is not shared - all information is stored locally. So if you need to add some information to the database, please add content to `db/seeds.rb` and run `rails db:seed`. Similarly, your local modifications to the database will not be shared. Only ActiveRecord information is shared, so please run `rails db:migrate` after someone else has modified the database to ensure that your database structure is up to date.

If an error occurs when you migrate your database, it may be that your database structure conflicts with ActiveRecord operations. You can execute the following command to reload the database, but this will also clear all the contents of your database.
```
rails db:drop
rails db:create
rails db:migrate
```

### Admin Page
The admin manage page now needs the permissions of the manager, so you need to add a new command line to db/seeds.rb file to increase the permissions of your account.
Add the following code line into the db:seeds then run rails db:seeds.
```
manager = User.new(email: "'???'@sheffield.ac.uk",is_manager: true)
manager.get_info_from_ldap 
manager.save
```
change the '???' to your univercity email address(without '')

### manage page
/prompts/api