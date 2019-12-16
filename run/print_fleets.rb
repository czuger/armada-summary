require 'yaml'
require 'pp'
require_relative 'libs/custom_i18n'
require_relative 'libs/options'

data = YAML.load_file( 'data/processed_data.yaml' )

p I18n.locale

data.each do |player, fleet|
  puts '*' * 150
  puts player
  puts '*' * 150

  fleet[:ships].sort_by {|ship| [ ship[ :flagship ], ship[ :scarred ], ship[ :veteran ] ].join( '' ) }.reverse.each do |ship|

    title = ( ship[ :title ] ? " (#{ship[ :title ]})" : '' )
    admiral = ( ship[ :flagship ] ? I18n.t( 'fleet.adm' ) : '' )
    ship_print = [ ship[ :name ] + title + admiral ]
    ship_print << (ship[ :scarred ] ? "#{I18n.t( 'fleet.scarred' )} ( #{ '%02d' % ( ship[ :ship_cost ] / 2.0 ).ceil } )" : '')
    ship_print << (ship[ :veteran ] ? I18n.t( 'fleet.veteran' ) : '')

    if I18n.locale == :fr
      ship[ :upgrades ].each do |upgrade|
        add_fr_translation( upgrade ) unless I18n.exists?(upgrade, :fr )
      end
    end

    ship_print << ship[ :upgrades ].map{ |upgrade| ( I18n.locale == :fr ? I18n.t( "expansions.#{upgrade}" ) : upgrade ) }.join( ', ' )

    printf "%-43s%-14s%-8s%s\n" % ship_print
  end

  puts '-' * 150

  fleet[:squadrons].sort_by {|ship| [ ship[ :scarred ], ship[ :veteran ], ship[ :name ] ].join( '' ) }.reverse.each do |ship|
    ship_print = [ ship[ :name ] + ( ship[ :title ] ? " (#{ship[ :title ]})" : '' ) ]
    ship_print << (ship[ :scarred ] ? "Avarié ( #{ '%02d' % ( ship[ :cost ] / 2.0 ).ceil } )" : '')
    ship_print << (ship[ :veteran ] ? I18n.t( 'fleet.veteran' ) : '')

    ship_print << (ship[ :unique ] ? I18n.t( 'fleet.unique' )  : '')
    ship_print << (ship[ :unique ] ? ship[ :unique_name ] : '')

    printf "%-43s%-14s%-8s%-7s%-20s\n" % ship_print
  end
  puts
end