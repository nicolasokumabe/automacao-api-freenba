describe "Get Specific Player" do
  context "busca de um jogador específico" do
    before(:all) do
      @base_api = BaseApi.new
      @jogador_id = rand(1..3092)
    end

    it "deve retornar o código de status 200 para o jogador específico" do
      resultado = @base_api.consulta_chave("players", @jogador_id)
      expect(resultado.code).to eq(200)
    end

    it "deve retornar os detalhes de um jogador específico" do
      resultado = @base_api.consulta_chave("players", @jogador_id)
      parsed_response = JSON.parse(resultado.body)
      expect(parsed_response).to include(
        "id", "first_name", "last_name", "position", "team"
      )
    end

    it "deve retornar um ID de jogador válido" do
      resultado = @base_api.consulta_chave("players", @jogador_id)
      parsed_response = JSON.parse(resultado.body)
      expect(parsed_response["id"]).to eq(@jogador_id)
    end

    it "deve retornar um nome válido para o jogador" do
      resultado = @base_api.consulta_chave("players", @jogador_id)
      parsed_response = JSON.parse(resultado.body)
      expect(parsed_response["first_name"]).to be_a(String)
      expect(parsed_response["last_name"]).to be_a(String)
    end

    it "deve retornar uma posição válida para o jogador" do
      resultado = @base_api.consulta_chave("players", @jogador_id)
      parsed_response = JSON.parse(resultado.body)
      expect(parsed_response["position"]).to be_a(String)
    end

    it "deve retornar uma altura válida para o jogador" do
      resultado = @base_api.consulta_chave("players", @jogador_id)
      parsed_response = JSON.parse(resultado.body)
      expect(parsed_response["height_feet"]).to be_an(Integer).or(be_nil)
      expect(parsed_response["height_inches"]).to be_an(Integer).or(be_nil)
    end

    it "deve retornar um peso válido para o jogador" do
      resultado = @base_api.consulta_chave("players", @jogador_id)
      parsed_response = JSON.parse(resultado.body)
      expect(parsed_response["weight_pounds"]).to be_an(Integer).or(be_nil)
    end

    it "deve retornar informações válidas do time do jogador" do
      resultado = @base_api.consulta_chave("players", @jogador_id)
      parsed_response = JSON.parse(resultado.body)
      time = parsed_response["team"]
      expect(time).to include(
        "id", "abbreviation", "city", "conference", "division",
        "full_name", "name"
      )
    end

    it "busca de jogador com ID inválido" do
      ids_invalidos = ["*", "aaa", "!", "@", "$", "&", "+", "-", "0", "3093"]
      ids_invalidos.each do |id_invalido|
        resultado = @base_api.consulta_chave("players", id_invalido)
        expect(resultado.code).to eq(404)
      end
    end

    it "deve retornar uma mensagem de erro de chave API inválida" do
      resultado = @base_api.consulta_sem_chave("players", @jogador_id)
      parsed_response = JSON.parse(resultado.body)
      expect(resultado.code).to eq(401)
      expect(parsed_response).to include("message")
      expect(parsed_response["message"]).to eq("Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info.")
    end

    it "busca de jogador com ID inválido sem chave" do
      allow_any_instance_of(BaseApi).to receive(:consulta_sem_chave).and_return(
        OpenStruct.new(
          code: 401,
          body: { "message" => "Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info." }.to_json,
        )
      )
      resultado = @base_api.consulta_sem_chave("players", @jogador_id)
      parsed_response = JSON.parse(resultado.body)
      expect(resultado.code).to eq(401)
      expect(parsed_response).to include("message")
      expect(parsed_response["message"]).to eq("Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info.")
    end
  end
end
