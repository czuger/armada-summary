require 'pp'
require 'yaml'

data = YAML.load_file( 'data/data.yaml' )

def process_squadrons( data )
  squadron_array = []
  data.each do |squadron_data|

    squadron = {}
    squadron[ :name ] = squadron_data.shift.gsub( "\n", ' ' )
    next if squadron[ :name ] == ''

    match = squadron[ :name ].match( /([^(]+)\(([^)0-9]*)[^\*]+(\*?)/ )

    squadron[ :name ] = match[ 1 ].strip

    squadron[ :veteran ] = squadron_data.pop == 'Yes'
    squadron[ :scarred ] = squadron_data.pop == 'Yes'
    squadron[ :cost ] = squadron_data.pop.to_i

    squadron[ :unique ] = ( match[ 3 ] == '*' )
    squadron[ :unique_name ] = match[ 2 ] if squadron[ :unique ]


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

    match = ship[ :name ].match( /(.*)\((\d+)\)/ )

    ship[ :name ] = match[ 1 ].strip
    ship[ :ship_cost ] = match[ 2 ].to_i

    title = ship_data.shift.match( /([^(]+)/ )
    ship[ :title ] = title[ 1 ].gsub( "\n", ' ' ).strip if title

    ship_data.pop
    ship[ :veteran ] = ship_data.pop == 'Yes'
    ship[ :scarred ] = ship_data.pop == 'Yes'
    ship[ :flagship ] = ship_data.pop == 'Yes'
    ship[ :cost ] = ship_data.pop.to_i
    ship[ :upgrades ] = []

    until ship_data.empty?
      data = ship_data.shift

      next unless data
      next if data == ''

      ship[ :upgrades ] << data.gsub( "\n", ' ' ).match( /(.*)\(/ )[ 1 ].strip
    end

    ship_array << ship
  end
  ship_array
end

data.each do |k, v|
  v[ :ships ] = process_ships( v[ :ships ] )
  v[ :squadrons ] = process_squadrons( v[ :squadrons ] )
end

File.open( 'data/processed_data.yaml', 'w' ){ |f| f.write( data.to_yaml ) }