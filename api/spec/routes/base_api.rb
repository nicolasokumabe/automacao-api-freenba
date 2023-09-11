require "httparty"
require "dotenv/load"

class BaseApi
  include HTTParty
  base_uri "https://free-nba.p.rapidapi.com"
end
