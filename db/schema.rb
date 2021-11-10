require 'sinatra'
require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

ActiveRecord::Migration.create_table :users do |t|
    t.string :name
    t.string :password
    t.integer :win
    t.integer :loss
end