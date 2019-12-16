class PlayersDetect

  def do( service , spreadsheet_id )
    @players = []

    sheet_data = service.get_spreadsheet spreadsheet_id
    sheets_copy = sheet_data.sheets.clone

    sheets_copy.shift( 2 )

    sheets_copy.each do |sheet|
      break if sheet.properties.title == 'Data'

      name = sheet.properties.title
      @players << name
    end

    @players
  end

end