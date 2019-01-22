#permet de se placer directement dans le lib/app. Mettre directement require + 'exemple'
.unshift File.expand_path('./../lib/app', __FILE__)
require 'scrapper'
 
#exemples de méthodes
describe 'Mon programme de scrapping Crypto fonctionne-t-il ?' do
it 'Le programme doit me retourner un array' do
expect(crypto_scrapper.is_a?Array).to eq(true)
end
