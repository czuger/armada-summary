class PlayersDetect

  def initialize( google_spreadsheet )
    @players = []

    sheet_data = google_spreadsheet.service.get_spreadsheet google_spreadsheet.spreadsheet_id
    sheets_copy = sheet_data.sheets.clone

    sheets_copy.shift( 2 )

    sheets_copy.each do |sheet|
      break if sheet.properties.title == 'Data'

      name = sheet.properties.title
      @players << name
    end
  end

  def each
    @players.each{ |player| yield player }
  end

end