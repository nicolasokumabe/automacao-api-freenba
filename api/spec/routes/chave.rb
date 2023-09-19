require_relative "base_api"
require_relative "env"

class Chave < BaseApi
  def id_ok_key(rotas, id)
    return self.class.get(
             "/#{rotas}/#{id}",
             headers: {
               "X-RapidAPI-Key" => API_KEY,
             },
           )
  end

  def id_no_key(rotas, id)
    return self.class.get(
             "/#{rotas}/#{id}",
           )
  end
end
