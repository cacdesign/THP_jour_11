require 'json'
require 'csv'


#remplace tous les require 'gem'. Bien penser à faire un bundle install pour les installer
require 'bundler'
Bundler.require


 
#permet de se placer directement dans le lib/app. Mettre directement require + exemple
$:.unshift File.expand_path('./../lib/app', __FILE__)
require 'scrapper'

$:.unshift File.expand_path('./../lib/views', __FILE__)
require 'index'

puts Index.new.perform

 
=begin

# JSON
array = Scrapper.new
array.get_townhall_urls
array.save_as_json




# SPREADSHEET

array = Scrapper.new
array.get_townhall_urls
array.save_as_spreadsheet



# CSV

array = Scrapper.new
array.get_townhall_urls
array.save_as_csv




# Pour reprendre un CSV
puts CSV.read("db/input.csv")
puts CSV.parse("db/input.csv", headers: true)
puts table[0]["id"]

=end


