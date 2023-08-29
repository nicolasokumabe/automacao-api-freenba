require "httparty"

class Teams
  include HTTParty
  base_uri "https://free-nba.p.rapidapi.com"

  def id_ok_key(id)
    return self.class.get(
             "/teams#{id}",
             headers: {
               "X-RapidAPI-Key" => "e3e081630bmshc4460801824c974p1adcf4jsne9790c18a76b",
             },
           )
  end

  def id_no_key(id)
    return self.class.get(
             "/teams#{id}",
           )
  end
end
