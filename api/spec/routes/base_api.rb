require "httparty"

class BaseApi
  include HTTParty
  base_uri "https://free-nba.p.rapidapi.com"
end
