require 'active_record'

class Movie < ActiveRecord::Base
  db_path = ::File.expand_path('../../db/development.sqlite3',__FILE__)
  establish_connection(adapter: 'sqlite3', database: db_path)
end
