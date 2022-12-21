class ExportMetadata

	def initialize(albumInput)
		@album = albumInput
	end


  def cms_format #cms_format
    document_rows = []

    trackIDsArray = []
    
    @album.tracks.each_with_index do |track, index|
      trackIDsArray << track.id
    end

    #here I call the array that contains all tracks data from class in file "single_track_request"
    array_of_tracks_data = SingleTrackRequest.new("").allTracksRequest(trackIDsArray)
    
    array_of_tracks_data.each_with_index do |track, index|

      row_array_values = []

      #push label code
      row_array_values << @album.label_code

      #push album label
      row_array_values << @album.labels[0].name

      #push album_code
      row_array_values << @album.directory_name

      #push album_name
      row_array_values << @album.name

      #push album_ean_nr
      row_array_values << @album.ean

      #---start tracks section
      # instanciate object track to access to it like an object with methods called like the values of json
      # track_data = trackRequest(track_from_album.id)

      #push track Title
      row_array_values << track.name.html_safe

      #push track_filename
      row_array_values << track.filename

      #push track_description
      row_array_values << track.description["en"]


      document_rows << row_array_values

    end #end each track in album

    return document_rows
    
  end
end
