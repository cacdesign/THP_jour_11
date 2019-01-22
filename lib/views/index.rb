$:.unshift File.expand_path('./../lib/app', __FILE__)
require 'scrapper'


class Index


	def choice

		puts "=============================================================="
		puts "    *****  Bienvenue dans notre super Scrapper  *****"  
		puts "=============================================================="
		puts ""
		puts "=============================================================="
		puts "Veuillez choisir le format d'export des données à scrapper :"
		puts " > 1 - format JSON"
		puts " > 2 - format Google Spreadsheet"
		puts " > 3 - format CSV"
		puts "=============================================================="
		print "> "

		# Je récupère le choix

		choice = gets.chomp.to_i

		return choice

	end




	def get_data(choice)

		# Je crée une nouvelle instance Scrapper

		instance = Scrapper.new

		# Je récupère la liste des hashs dans un tableau 

		instance.get_townhall_urls

		# En fonction du choix, je convertis en : 

			if choice == 1 then # JSON

				instance.save_as_json

			elsif choice == 2 then # SPREADSHEET

				instance.save_as_spreadsheet

			elsif choice == 3 then # CSV

				instance.save_as_csv

			end

	end




	def perform

		get_data(choice)

	end


end