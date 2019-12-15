require 'pp'
require 'yaml'

data = YAML.load_file( '../data/data.yaml' )

def process_squadrons( data )
  squadron_array = []
  data.each do |squadron_data|

    squadron = {}
    squadron[ :name ] = squadron_data.shift.gsub( "\n", ' ' )
    next if squadron[ :name ] == ''

    squadron[ :veteran ] = squadron_data.pop
    squadron[ :scarred ] = squadron_data.pop
    squadron[ :cost ] = squadron_data.pop.to_i

    squadron_array << squadron
  end
  squadron_array
end

def process_ships( data )
  ship_array = []
  data.each do |ship_data|

    ship = {}
    ship[ :name ] = ship_data.shift.gsub( "\n", ' ' )
    next if ship[ :name ] == ''

    ship[ :ship_cost ] = ship[ :name ].match( /.*\((\d+)\)/ )[1].to_i

    ship[ :veteran ] = ship_data.pop
    ship[ :scarred ] = ship_data.pop
    ship[ :flagship ] = ship_data.pop
    ship[ :cost ] = ship_data.pop.to_i
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
  v[ :squadrons ] = process_ships( v[ :squadrons ] )
end


File.open( '../data/processed_data.yaml', 'w' ){ |f| f.write( data.to_yaml ) }