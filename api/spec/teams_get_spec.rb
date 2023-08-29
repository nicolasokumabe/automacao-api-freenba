require_relative "routes/teams"

describe "Get All Teams" do
  context "busca de times com a chave" do
    before(:all) do
      sleep 2.4
      @result = Teams.new.id_ok_key("?page=0")
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end
  end

  context "busca de times sem a chave" do
    before(:all) do
      sleep 2.4
      @result = Teams.new.id_no_key("?page=0")
    end

    it "valida status code" do
      expect(@result.code).to eql 401
    end

    it "valida chave API" do
      expect(@result.parsed_response["message"]).to eql "Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info."
    end
  end
end

describe "Get Specific Team" do
  context "id de time existente com a chave" do
    before(:all) do
      sleep 2.4
      @result = Teams.new.id_ok_key("/1")
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end
  end

  context "id de time existente sem a chave" do
    before(:all) do
      @result = Teams.new.id_no_key("/1")
    end

    it "valida status code" do
      expect(@result.code).to eql 401
    end

    it "valida chave API" do
      expect(@result.parsed_response["message"]).to eql "Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info."
    end
  end

  context "id de time inexistente com a chave" do
    before(:all) do
      sleep 2.4
      @result = Teams.new.id_ok_key("/0")
    end

    it "valida status code" do
      expect(@result.code).to eql 404
    end
  end

  context "id de time inexistente sem a chave" do
    before(:all) do
      @result = Teams.new.id_no_key("/0")
    end

    it "valida status code" do
      expect(@result.code).to eql 401
    end

    it "valida chave API" do
      expect(@result.parsed_response["message"]).to eql "Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info."
    end
  end

  context "sem o id de time com a chave" do
    before(:all) do
      sleep 2.4
      @result = Teams.new.id_ok_key("/")
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end
  end

  context "sem o id de time sem a chave" do
    before(:all) do
      @result = Teams.new.id_no_key("/")
    end

    it "valida status code" do
      expect(@result.code).to eql 401
    end

    it "valida chave API" do
      expect(@result.parsed_response["message"]).to eql "Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info."
    end
  end
end
