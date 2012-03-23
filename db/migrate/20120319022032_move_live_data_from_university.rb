class MoveLiveDataFromUniversity < ActiveRecord::Migration
=begin
  def up
    execute 'insert into users(id, first_name, last_name, email) (select id, first_name, last_name, email from university.users where 1)'
  end

  def down
    execute 'truncate table users'
  end
=end
end
