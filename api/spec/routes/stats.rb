require "httparty"

class Stats
  include HTTParty
  base_uri "https://free-nba.p.rapidapi.com"

  def id_ok_key
    return self.class.get(
             "/stats",
             headers: {
               "X-RapidAPI-Key" => "e3e081630bmshc4460801824c974p1adcf4jsne9790c18a76b",
             },
           )
  end

  def id_no_key
    return self.class.get(
             "/stats",
           )
  end
end
