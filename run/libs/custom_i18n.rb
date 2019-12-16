require 'i18n'

I18n.load_path = Dir['../locale/*.yml']
I18n.config.available_locales = [ :en, :fr ]
I18n.backend.load_translations

def add_fr_translation( translation )
  tr = YAML.load_file( LOCALE_FILE )

  tr[ 'fr' ] ||= {}

  tr[ 'fr' ][ translation ] = translation
  File.open( LOCALE_FILE, 'w' ){ |f| f.write( tr.to_yaml ) }
end