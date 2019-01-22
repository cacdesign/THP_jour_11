# ================================
# 		    	REQUIRE
# ================================

require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'json'
require 'pry'
require 'google_drive'
require 'csv'



# ================================
# 		   SCRAPPER CLASS
# ================================

class Scrapper


# --------------------------------
#  initialisation de l'instance
# --------------------------------

	def initialize
		@my_array = []
	end



# --------------------------------
#  METHODE PERMETTANT DE RECUPERER LE MAIL DE LA MAIRIE A PARTIR DE L'URL DE LA MAIRIE
# --------------------------------

	def get_townhall_email(townhall_url) 

	doc = Nokogiri::HTML(open(townhall_url))

	    # J'utilise le xpath (position absolue du mail dans le tableau, 4eme ligne, 2ème colonne)en espérant qu'il soit le même sur chaque page de mairie
	    # Une méthode plus sur consisterait à récupérer le mail en regex dans le tableau
	    mail = doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text

	return mail
	end


# --------------------------------
#  METHODE PERMETTANT DE RECUPERER UN TABLEAU AVEC DES COUPLES DE HASH NOM > MAIRIE => LIEN PAGE MAIRIE
# --------------------------------

	def get_townhall_urls

	  
	    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	    
	    #Je me place sur le a.lientxt
	      a = doc.css('tr//a.lientxt')
	    
	    #Je prends pour chaque colonne a, les href
	       a.length.times do |i|
	       #4.times do |i|
	          url_suffix = a[i]['href'].delete_prefix(".")
	          url_town = "http://annuaire-des-mairies.com#{url_suffix}"


	    #Je lance la méthode pour récupérer les mails 
	          mail_town = get_townhall_email(url_town)
	   
	    #Je récupère les noms des mairies
	          name_town = a[i].text 
	        
	    #Je mets tout ça dans un hash = { "ville_1" => "email_1" }
	          my_hash = {name_town => mail_town}
	          puts my_hash

	    #Je mets tout mes hash dans un array
	          @my_array << my_hash

	        end

	        #Je renvoie mon tableau
	return @my_array

	end


# --------------------------------
#  METHODE PERMETTANT D'EXPORTER LES DONNÉES VERS UN FICHIER JSON
# --------------------------------


	def save_as_json

		File.open("db/input.json","w") do |f|
	  	f.write(@my_array.to_json)

	  	end


	end


# --------------------------------
#  METHODE PERMETTANT D'EXPORTER LES DONNÉES VERS UN FICHIER SPREADSHEET https://docs.google.com/spreadsheets/d/1u-FaTOI9rnoBOMPbH_eGkFuFGoGVEWDfzZgUFonWKkA/edit#gid=0
# --------------------------------


	def save_as_spreadsheet

		session = GoogleDrive::Session.from_config("config.json")
	  	
		ws = session.spreadsheet_by_key("1u-FaTOI9rnoBOMPbH_eGkFuFGoGVEWDfzZgUFonWKkA").worksheets[0]	

		i = 1
		
		@my_array.each do |hash|
  
    			hash.each do |town, mail|
    			ws[i, 1] = town
    			ws[i, 2] = mail
    			i +=1
    			end
  			
		end

		ws.save

	end


# --------------------------------
#  METHODE PERMETTANT D'EXPORTER LES DONNÉES VERS UN FICHIER JSON
# --------------------------------


	def save_as_csv

			csv = File.open("db/input.csv","w")
				@my_array.each do |hash|
					hash.each do |town, mail|
		  				csv.puts ("#{town},#{mail}")
		  			end
		  		end

	end


	  	
	
	
end 
