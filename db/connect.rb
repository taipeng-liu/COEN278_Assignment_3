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
    db = URI.parse(ENV['DATABASE_URL'] || 'postgres://sbzdghhblejlkq:1675b8dbbd2a835a81223cc37d4f6d79fe87cdb822acfb8d9b63de8b89729c20@ec2-54-160-35-196.compute-1.amazonaws.com:5432/d89tp9v0hnrfqo')

    ActiveRecord::Base.establish_connection(
      :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
    )

end
