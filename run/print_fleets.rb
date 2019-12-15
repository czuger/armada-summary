require 'yaml'
require 'i18n'
require 'pp'

I18n.load_path = Dir['../locale/*.yml']
I18n.config.available_locales = :fr
I18n.locale = :fr
I18n.backend.load_translations

def add_fr_translation( translation )
  tr = YAML.load_file( '../locale/fr.yml' )

  tr[ 'fr' ] ||= {}

  tr[ 'fr' ][ translation ] = translation
  File.open( '../locale/fr.yml', 'w' ){ |f| f.write( tr.to_yaml ) }
end

data = YAML.load_file( '../data/processed_data.yaml' )

data.each do |player, fleet|
  puts '*' * 150
  puts player
  puts '*' * 150

  fleet[:ships].sort_by {|ship| [ ship[ :flagship ], ship[ :scarred ], ship[ :veteran ] ].join( '' ) }.reverse.each do |ship|

    title = ( ship[ :title ] ? " (#{ship[ :title ]})" : '' )
    amiral = ( ship[ :flagship ] ? ' <Adm>' : '' )
    ship_print = [ ship[ :name ] + title + amiral ]
    ship_print << (ship[ :scarred ] ? "Avarié ( #{ '%02d' % ( ship[ :ship_cost ] / 2.0 ).ceil } )" : '')
    ship_print << (ship[ :veteran ] ? 'Vétéran' : '')

    ship[ :upgrades ].each do |upgrade|
      add_fr_translation( upgrade ) unless I18n.exists?(upgrade, :fr )
    end

    ship_print << ship[ :upgrades ].map{ |upgrade| I18n.t( upgrade ) }.join( ', ' )

    printf "%-43s%-14s%-8s%s\n" % ship_print
  end

  puts '-' * 150

  fleet[:squadrons].sort_by {|ship| [ ship[ :scarred ], ship[ :veteran ], ship[ :name ] ].join( '' ) }.reverse.each do |ship|
    ship_print = [ ship[ :name ] + ( ship[ :title ] ? " (#{ship[ :title ]})" : '' ) ]
    ship_print << (ship[ :scarred ] ? "Avarié ( #{ '%02d' % ( ship[ :cost ] / 2.0 ).ceil } )" : '')
    ship_print << (ship[ :veteran ] ? 'Vétéran' : '')

    ship_print << (ship[ :unique ] ? 'Unique' : '')
    ship_print << (ship[ :unique ] ? ship[ :unique_name ] : '')

    printf "%-43s%-14s%-8s%-7s%-20s\n" % ship_print
  end
  puts
end