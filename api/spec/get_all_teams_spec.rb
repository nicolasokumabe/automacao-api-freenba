describe "Get All Teams" do
  context "busca de times" do
    before(:all) do
      @base_api = BaseApi.new
      @resposta = @base_api.consulta_chave("teams", "?page=0")
      @dados_teams = JSON.parse(@resposta.body)["data"]
      @meta_data = JSON.parse(@resposta.body)["meta"]
    end

    it "deve retornar um código de status 200" do
      expect(@resposta.code).to eq(200)
    end

    it "deve retornar uma lista de equipes da NBA" do
      expect(@dados_teams).to be_an(Array)
      expect(@dados_teams).not_to be_empty
    end

    it "cada equipe deve ter informações válidas" do
      @dados_teams.each do |team|
        expect(team).to include(
          "id", "abbreviation", "city", "conference", "division",
          "full_name", "name"
        )
      end
    end

    it "deve retornar informações da primeira página" do
      expect(@meta_data["current_page"]).to eq(1)
      expect(@meta_data["total_pages"]).to be >= 1
    end

    it "deve retornar informações sobre a próxima página" do
      expect(@meta_data["next_page"]).to be >= 2
    end

    it "deve retornar o número correto de equipes por página" do
      expect(@dados_teams.count).to eq(@meta_data["per_page"])
    end

    it "deve retornar o número total correto de equipes" do
      expect(@meta_data["total_count"]).to be >= @dados_teams.count
    end
  end
end
