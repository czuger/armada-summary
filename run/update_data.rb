require_relative 'libs/players_detect'
require_relative 'libs/google_spreadsheet'
require 'pp'
require 'yaml'

data = {}
gs = GoogleSpreadsheet.new
players = PlayersDetect.new( gs )
players.update
players.save

players.each do |player|
  response = gs.range "#{player}!B6:Z17"
  data[ player ] = { ships: response.values }

  response = gs.range "#{player}!B21:G44"
  data[ player ][ :squadrons ] = response.values
end

File.open( 'data/data.yaml', 'w' ){ |f| f.write( data.to_yaml ) }