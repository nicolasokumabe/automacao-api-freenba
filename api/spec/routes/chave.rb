require_relative "base_api"

class Chave < BaseApi
  def id_ok_key(rotas, id)
    return self.class.get(
             "/#{rotas}#{id}",
             headers: {
               "X-RapidAPI-Key" => "e3e081630bmshc4460801824c974p1adcf4jsne9790c18a76b",
             },
           )
  end

  def id_no_key(rotas, id)
    return self.class.get(
             "/#{rotas}#{id}",
           )
  end
end
