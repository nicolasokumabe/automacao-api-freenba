require_relative "routes/games"

describe "Get All Games" do
  context "busca de jogos com a chave" do
    before(:all) do
      sleep 2.4
      @result = Games.new.id_ok_key("?page=0&per_page=25")
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end
  end

  context "busca de jogos sem a chave" do
    before(:all) do
      sleep 2.4
      @result = Games.new.id_no_key("?page=0&per_page=25")
    end

    it "valida status code" do
      expect(@result.code).to eql 401
    end

    it "valida chave API" do
      expect(@result.parsed_response["message"]).to eql "Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info."
    end
  end
end

describe "Get Specific Game" do
  context "id de jogo existente com a chave" do
    before(:all) do
      sleep 2.4
      @result = Games.new.id_ok_key("/1")
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end
  end

  context "id de jogo existente sem a chave" do
    before(:all) do
      @result = Games.new.id_no_key("/1")
    end

    it "valida status code" do
      expect(@result.code).to eql 401
    end

    it "valida chave API" do
      expect(@result.parsed_response["message"]).to eql "Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info."
    end
  end

  context "id de jogo inexistente com a chave" do
    before(:all) do
      sleep 2.4
      @result = Games.new.id_ok_key("/0")
    end

    it "valida status code" do
      expect(@result.code).to eql 404
    end
  end

  context "id de jogo inexistente sem a chave" do
    before(:all) do
      @result = Games.new.id_no_key("/0")
    end

    it "valida status code" do
      expect(@result.code).to eql 401
    end

    it "valida chave API" do
      expect(@result.parsed_response["message"]).to eql "Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info."
    end
  end

  context "sem o id de jogo com a chave" do
    before(:all) do
      sleep 2.4
      @result = Games.new.id_ok_key("/")
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end
  end

  context "sem o id de jogo sem a chave" do
    before(:all) do
      @result = Games.new.id_no_key("/")
    end

    it "valida status code" do
      expect(@result.code).to eql 401
    end

    it "valida chave API" do
      expect(@result.parsed_response["message"]).to eql "Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info."
    end
  end
end
