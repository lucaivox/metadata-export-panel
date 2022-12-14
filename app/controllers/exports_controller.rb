class ExportsController < ApplicationController

  require 'csv'
  
	skip_before_action :authenticate_user!, only: %i[homepage]

  INTERVOX_API_TOKEN = "XPAFG9jx18cqubDXSKc3oHG5"

	def exports


    # test export with threads
    # @testTrack = []
    # @testTrack << SingleTrackRequest.new("").allTracksRequest(["6262",6263,6261])
    # @testTrack << ExportMetadata.new(SingleAlbumRequest.new("ivox400").albumRequest).cms_format

    # threads = []
    # threads << Thread.new { @testTrack << TrackRequest.new(6257).trackRequest.filename }
    # threads.each(&:join)


  
    if params[:exports]
      @testAlbums = params[:exports]
    end
        

    # How many albums displaied per page
    @per = (params[:per] || 20).to_i
    # Page number for pagination
		@page = (params[:page] || 1).to_i
    # Get value for filtering album directory names
    @albumCodeFilter = params[:album_directory_name]

    # Activate page button
    @active20 = ""
    @active50 = ""
    @active100 = ""

    if @per == 20
      @active20 = "checked"
    end
    if @per == 50
      @active50 = "checked"
    end
    if @per == 100
      @active100 = "checked"
    end

    # Parameters for displaying only filtered albums
    if params[:exports] && params[:exports]["album_directory_name"]
      @albumCodeFilter = (params[:exports]["album_directory_name"])
    end

    #parameters variable
    @testone = exports_path(page: @page + 1, per: @per, album_directory_name: @directoryNameFilter)



    # Get available albums via intervox API
    response = RestClient.get("https://cms.intervox.de/v2/partners/albums?per=#{@per}&page=#{@page}&token=XPAFG9jx18cqubDXSKc3oHG5&directory_name=#{@albumCodeFilter}")
		json = JSON.parse response

    # Find last page number for pagination
    @lastpage = (json["meta"]["total_count"].to_f/@per).ceil

    # Pass the albums to view via this variable to build table
		@all_albums = json


    
    # here the requested albums string from view of selected albums in table    
    if params[:exports] && params[:exports]["requested_albums"] && params[:exports]["export_type"]

      @requested_albums = params[:exports]["requested_albums"]
      @export_type = params[:exports]["export_type"]

      @requested_albums_string = params[:exports]["requested_albums"]
      @requested_albums_array = @requested_albums_string.split(',')

      #here how to deal with the single albums as an instance of an object
      # @single_album_response = albumRequest(@requested_albums_string).name

      #here how to convert comma separated string in array
      # @single_album_response = @requested_albums.split(',')

      #create variable to collect all requested albums data exported
      @all_requested_response_array = []
      @export_results =[]

      #loop through all requested albums
      @requested_albums_array.each_with_index do |album_from_array, index|

        ActionCable.server.broadcast 'ExportsChannel',
          { album: album_from_array,
            loader: true,
            current: index,
            total: @requested_albums_array.length
          }


        #make a request for one album. Albums can be used as object with methods call like the json attributes e.g. name, track_list
        @single_album_response = SingleAlbumRequest.new(album_from_array).albumRequest
        # @testTrack = SingleTrackRequest.new(350456).trackRequest.filename
        # @single_album_response = albumRequest(album_from_array)    

        #insert case to start export type
        case @export_type 
        when "cms_format"
          @row_array_headers = ["album_label_code","album_label","album_code","album_name","album_ean_nr","track_title","track_filename","description"]
          @export_results = ExportMetadata.new(@single_album_response).cms_format

        when "cms_track_collecting_numbers"
          @export_results = cms_track_collecting_numbers(@single_album_response)

        when "adrev"
          # @export_results = cms_format(@single_album_response)
        
        end


        @all_requested_response_array << @export_results
        # @all_requested_response_array = @all_requested_response_array | @export_results

      end #end @requested_albums_array.each_with_index
    end #end if params[:exports] && params[:exports]["requested_albums"]
    
    #send info that exports are done and hide loader
    ActionCable.server.broadcast 'ExportsChannel',
    { 
      loader: false,
    }
	end #end def exports



  def cms_track_collecting_numbers(album)
    row_array_headers = ["track_filename"]
    document_rows = []
    document_rows << row_array_headers
    
    album.tracks.each_with_index do |track_from_album, index|
      row_array_values = []

      #---start tracks section
      # instanciate object track to access to it like an object with methods called like the values of json
      track_data = TrackRequest.new(track_from_album.id).trackRequest

      #push track_filename
      row_array_values << track_data.filename


      document_rows << row_array_values

    end #end each track in album

    return document_rows
  end


  def download
  end


end
