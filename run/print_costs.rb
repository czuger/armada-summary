require 'yaml'
require 'pp'
require_relative 'libs/players_detect'
require_relative 'libs/custom_i18n'
require_relative 'libs/options'

data = YAML.load_file( 'data/processed_data.yaml' )
players = PlayersDetect.new.load

data.each do |player, fleet|
  puts '*' * 40
  puts player
  puts '*' * 40

  fleet_cost = fleet[:ships].map{ |ship| ( ship[ :ship_cost ] / 2.0 ).ceil if ship[ :scarred ] }.compact.inject( &:+ )
  squadron_cost = fleet[:squadrons].map{ |ship| ( ship[ :cost ] / 2.0 ).ceil if ship[ :scarred ] }.compact.inject( &:+ )
  total = fleet_cost + squadron_cost

  repair = players.repair player

  remain = total - repair

  puts "#{I18n.t( 'costs.fleet_repair' ) } : #{fleet_cost}"
  puts "#{I18n.t( 'costs.squad_repair' ) } : #{squadron_cost}"
  puts "#{I18n.t( 'costs.total_repair' ) } : #{total} (#{fleet_cost} + #{squadron_cost})"
  puts "#{I18n.t( 'costs.repair_shipyards' ) } : #{repair}"
  puts "#{I18n.t( 'costs.bill' ) } : #{remain} (#{total} - #{repair})"
  puts
end