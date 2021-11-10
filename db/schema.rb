require_relative 'connect'

ActiveRecord::Migration.create_table :users do |t|
    t.string :name
    t.string :password
    t.integer :win
    t.integer :loss
end