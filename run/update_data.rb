require_relative 'libs/players_detect'
require_relative 'libs/google_spreadsheet'
require 'pp'
require 'yaml'

data = {}
gs = GoogleSpreadsheet.new
players = PlayersDetect.new( gs )

players.each do |sheet|
  response = gs.range "#{sheet}!B6:Z17"
  data[ sheet ] = { ships: response.values }

  response = gs.range "#{sheet}!B21:G44"
  data[ sheet ][ :squadrons ] = response.values
end

File.open( 'data/data.yaml', 'w' ){ |f| f.write( data.to_yaml ) }