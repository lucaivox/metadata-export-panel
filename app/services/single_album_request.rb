class SingleAlbumRequest

	INTERVOX_API_TOKEN = "XPAFG9jx18cqubDXSKc3oHG5"


	def initialize(directory_name)
		@album_directory_name = directory_name
	end

	def albumRequest
		response = RestClient::Request.new({
			method: :get,
			url: "https://cms.intervox.de/v2/partners/albums/#{@album_directory_name}/inactive?token=#{INTERVOX_API_TOKEN}"
		}).execute do |response, request, result|

			case response.code
				when 400
					fail "Response error: #{response.to_str} received."
				when 200
					response
				else
					redirect_to :exports_path, notice: "Invalid response #{response.to_str} received for request #{@album_directory_name}"
					# fail "Invalid response #{response.to_str} received for request #{@album_directory_name}"
			end
		end
		
		
		json = JSON.parse response

		album = JSON.parse(response, object_class: OpenStruct)

		return album.album
	end

end




# response = RestClient::Request.new({
# 	method: :post,
# 	url: 'https://xyz,
# 	user: 'someone',
# 	password: 'mybirthday',
# 	payload: { post_this: 'some value', post_that: 'other value' },
# 	headers: { :accept => :json, content_type: :json }
# }).execute do |response, request, result|
# 	case response.code
# 	when 400
# 		[ :error, parse_json(response.to_str) ]
# 	when 200
# 		[ :success, parse_json(response.to_str) ]
# 	else
# 		fail "Invalid response #{response.to_str} received."
# 	end
# end

# def albumRequest
# 	response = RestClient.get("https://cms.intervox.de/v2/partners/albums/#{@album_directory_name}/inactive?token=#{INTERVOX_API_TOKEN}")
# 	json = JSON.parse response

# 	album = JSON.parse(response, object_class: OpenStruct)

# 	return album.album
# end