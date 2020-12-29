class Api
  XBOX_URL = "https://xbl.io/api/v2/"
  XBOX_API_KEY = Dotenv.load["XBOX_API_KEY"]
  # search_query    = '/?search='

  def self.xbox_url
    XBOX_URL
  end

  # Api.const_get(:XBOX_API_KEY) # in console

  def self.get_endpoint(endpoint, sort = false)
    new_url = URL + endpoint
    self.call_api(new_url)
  end

  def self.search_endpoint(endpoint, search_term)
    # TODO use search term and endpoint
    search_url = URL + endpoint + "/?search=" + search_term
    self.call_api(search_url)
  end

  def self.get_gameclips
    # res["gameClips"][0]["gameClipUris"][0]["uri"]
    res = self.call_api_x_auth(XBOX_URL + "dvr/gameclips/")
    game_clips = res["gameClips"]

    game_clips.map do |clip, i|
      # clip_url =
      {
        xuid: clip["xuid"],
        gameClipId: clip["gameClipId"],
        clip: clip["gameClipUris"][0]["uri"],

      }
    end
    # binding.pry
  end

  def self.call_api_x_auth(url)
    HTTParty.get(url,
                 headers: {
                   "X-Authorization" => XBOX_API_KEY,
                   "Content-Type" => "application/json",
                 })
  end
end
