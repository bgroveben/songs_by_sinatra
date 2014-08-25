require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'
require 'sass'
require 'sqlite3'
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

class Song
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :lyrics, Text
  property :length, Integer
  property :released_on, Date

end

DataMapper.finalize
