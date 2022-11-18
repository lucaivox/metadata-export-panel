class ExportsController < ApplicationController

	skip_before_action :authenticate_user!, only: %i[homepage]
  skip_before_action :verify_authenticity_token


  ALBUMS_PER_PAGE = 50

	def exports

    @per = (params[:per] || 20).to_i

		@page = (params[:page] || 1).to_i
		
    response = RestClient.get("https://cms.intervox.de/v2/partners/albums?per=#{@per}&page=#{@page}&token=P9QymiMmSP5uR3Kptm7dCSuW")
			
		json = JSON.parse response

    @lastpage = (json["meta"]["total_count"].to_f/@per).ceil
	
		@all_albums = json
	end


  def albumRequest(directory_name)
    response = RestClient.get("https://cms.intervox.de/v2/partners/albums/#{directory_name}/inactive?token=P9QymiMmSP5uR3Kptm7dCSuW")
    json = JSON.parse response

    @single_album = json
  end

  def trackRequest(track_id)

    response = RestClient.get("https://cms.intervox.de/v2/partners/tracks/#{track_id}?token=P9QymiMmSP5uR3Kptm7dCSuW")
    json = JSON.parse response

    @single_track = json
  end

  def download
  end

  def test

    @test = params[:query]

  end



end
