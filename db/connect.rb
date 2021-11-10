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
    # ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
    db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')

    ActiveRecord::Base.establish_connection(
      :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
    )

end
