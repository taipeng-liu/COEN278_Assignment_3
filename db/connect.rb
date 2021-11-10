require 'sinatra'
require 'rubygems'
require 'active_record'

if development?
    ActiveRecord::Base.establish_connection(
        :adapter  => "mysql2",
        :host     => "127.0.0.1",
        :port     => "3306",
        :username => "taipeng",
        :password => "coen380",
        :database => "coen278"
    )
else
    ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
end
