require 'pp'
require 'yaml'

data = YAML.load_file( '../data/data.yaml' )

def process_ships( data )
  ship_array = []
  data.each do |ship_data|

    ship = {}
    ship[ :name ] = ship_data.shift.gsub( "\n", ' ' )
    next if ship[ :name ] == ''

    ship[ :veteran ] = ship_data.pop
    ship[ :scarred ] = ship_data.pop
    ship[ :flagship ] = ship_data.pop
    ship[ :cost ] = ship_data.pop
    ship[ :upgrades ] = []

    until ship_data.empty?
      data = ship_data.shift

      next unless data
      next if data == ''
      ship[ :upgrades ] << data.gsub( "\n", ' ' )
    end

    ship_array << ship
  end
  ship_array
end

data.each do |k, v|
  v[ :ships ] = process_ships( v[ :ships ] )
end

pp data