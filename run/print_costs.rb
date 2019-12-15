require 'yaml'
require 'i18n'
require 'pp'

data = YAML.load_file( '../data/processed_data.yaml' )
admirals = YAML.load_file( '../data/admirals.yaml' )

repairs = { 'Empire' => 35, 'Reb' => 40 }

data.each do |player, fleet|
  puts '*' * 40
  puts player
  puts '*' * 40

  fleet_cost = fleet[:ships].map{ |ship| ( ship[ :ship_cost ] / 2.0 ).ceil if ship[ :scarred ] }.compact.inject( &:+ )
  squadron_cost = fleet[:squadrons].map{ |ship| ( ship[ :cost ] / 2.0 ).ceil if ship[ :scarred ] }.compact.inject( &:+ )
  total = fleet_cost + squadron_cost

  repair = repairs[ admirals[ player ][ 'side' ] ]

  remain = total - repair

  puts "Réparation flotte : #{fleet_cost}"
  puts "Réparation escadrons : #{squadron_cost}"
  puts "Réparation total : #{total} (#{fleet_cost} + #{squadron_cost})"
  puts "Chantiers de réparation : #{repair}"
  puts "Reste a payer : #{remain} (#{total} - #{repair})"
  puts
end