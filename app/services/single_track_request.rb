class SingleTrackRequest

	INTERVOX_API_TOKEN = "XPAFG9jx18cqubDXSKc3oHG5"
    # https://cms.intervox.de/v2/partners/tracks/1236?token=XPAFG9jx18cqubDXSKc3oHG5

    def initialize(track_id)
		@track_id = track_id
	end

	def trackRequest

			response = RestClient.get("https://cms.intervox.de/v2/partners/tracks/#{@track_id}?token=#{INTERVOX_API_TOKEN}")
			json = JSON.parse response
	
			track = JSON.parse(response, object_class: OpenStruct)
	
			return track.track
	end

	def allTracksRequest(arrayTracksID) #this requires an array as input with tracks ID to request

		arrayTracks = []

		whileTest = true

		i=0
        while whileTest do 
            
						if i < arrayTracksID.length
							threads = []
							if arrayTracksID[i]
								threads << Thread.new { arrayTracks << SingleTrackRequest.new(arrayTracksID[i]).trackRequest }
							end
							if arrayTracksID[i+1]
								threads << Thread.new { arrayTracks << SingleTrackRequest.new(arrayTracksID[i+1]).trackRequest }
							end
							if arrayTracksID[i+2]
								threads << Thread.new { arrayTracks << SingleTrackRequest.new(arrayTracksID[i+2]).trackRequest }
							end
							if arrayTracksID[i+3]
								threads << Thread.new { arrayTracks << SingleTrackRequest.new(arrayTracksID[i+3]).trackRequest }
							end

							threads.each(&:join)

							i = i + 4
						else
							return arrayTracks
						end
        end

        return arrayTracks
	end
end
