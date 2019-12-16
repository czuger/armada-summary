class PlayersDetect

  FILENAME = 'data/players.yaml'

  def initialize( google_spreadsheet = nil )
    @gs = google_spreadsheet
  end

  def repair( player )
    @players[ player ]
  end

  def save
    File.open( FILENAME, 'w' ){ |f| f.write @players.to_yaml }
  end

  def load
    @players = YAML.load_file( FILENAME )
    self
  end

  def update
    empire_players = @gs.range( 'Team Status!A7:A9' ).values.flatten
    empire_reparation_value = @gs.range( 'Team Status!D8' ).values.flatten.first.to_i

    reb_players = @gs.range( 'Team Status!H7:H9' ).values.flatten
    reb_reparation_value = @gs.range( 'Team Status!F8' ).values.flatten.first.to_i

    @players = Hash[ empire_players.map{ |e| [ e, empire_reparation_value ] } ]
                 .merge( Hash[ reb_players.map{ |e| [ e, reb_reparation_value ] } ] )
  end

  def each
    @players.each{ |player, _| yield player }
  end

end