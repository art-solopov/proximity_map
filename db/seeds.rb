# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'yaml'

sdata = YAML::load(open('moscow.yaml')).sample(50)
sdata.each_with_index do |e, i|
  bld = Building.create(e)
  bld.id = i + 1
end

