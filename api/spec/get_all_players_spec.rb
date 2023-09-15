describe "Get All Players" do
  context "busca de jogadores" do
    before(:all) do
      @base_api = BaseApi.new
      @resultado = @base_api.consulta_chave("players", "?page=0&per_page=25")
    end

    it "verifica o código de status da requisição GET" do
      expect(@resultado.code).to eq(200)
    end

    it "verifica a estrutura e os tipos de dados dos jogadores" do
      parsed_response = JSON.parse(@resultado.body)
      dados = parsed_response["data"]
      metadados = parsed_response["meta"]

      expect(parsed_response).to include("data", "meta")

      dados.each do |player|
        expect(player.keys).to include("id", "first_name", "last_name", "position", "team")
        expect(player["id"]).to be_an(Integer)
        expect(player["first_name"]).to be_a(String)
        expect(player["last_name"]).to be_a(String)
        expect(player["position"]).to be_a(String)
        expect(player["team"]).to be_a(Hash)
      end

      expect(metadados.keys).to include("total_pages", "current_page", "next_page", "per_page", "total_count")
      expect(metadados.values).to all(be_an(Integer))
    end

    it "deve retornar um erro de chave API inválida" do
      allow_any_instance_of(BaseApi).to receive(:consulta_sem_chave).and_return(
        OpenStruct.new(
          code: 401,
          body: { "message" => "Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info." }.to_json,
        )
      )

      @resultado = @base_api.consulta_sem_chave("players", "?page=0&per_page=25")
      parsed_response = JSON.parse(@resultado.body)

      expect(@resultado.code).to eq(401)
      expect(parsed_response).to include("message")
      expect(parsed_response["message"]).to eq("Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info.")
    end
  end
end
