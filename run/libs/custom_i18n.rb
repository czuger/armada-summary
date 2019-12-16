require 'i18n'

LOCALE_FR_FILE = '../locale/fr.yml'

I18n.load_path = Dir['../locale/*.yml']
I18n.config.available_locales = [ :en, :fr ]
I18n.backend.load_translations

def add_fr_translation( translation )
  tr = YAML.load_file( LOCALE_FR_FILE )

  tr[ 'fr' ] ||= {}
  tr[ 'fr' ][ :expansions ] ||= {}
  tr[ 'fr' ][ :expansions ][ translation ] = translation

  File.open( LOCALE_FR_FILE, 'w' ){ |f| f.write( tr.to_yaml ) }
end