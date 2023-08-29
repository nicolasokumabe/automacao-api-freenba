require_relative "routes/teams"

describe "Get Teams" do
  examples_ok_key = [
    {
      title: "busca de times com a chave",
      id_ok_key: "?page=0&per_page=25",
      code: 200,
      error: "",
    },
    {
      title: "id de time existente com a chave",
      id_ok_key: "/1",
      code: 200,
      error: "",
    },
    {
      title: "id de time inexistente com a chave",
      id_ok_key: "/0",
      code: 404,
      error: "",
    },
    {
      title: "sem o id de time com a chave",
      id_ok_key: "/",
      code: 200,
      error: "",
    },
  ]

  examples_ok_key.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        # sleep 1
        @result = Teams.new.id_ok_key(e[:id_ok_key])
      end

      it "valida status code" do
        expect(@result.code).to eql e[:code]
      end
    end
  end

  examples_no_key = [
    {
      title: "busca de times sem a chave",
      id_no_key: "?page=0&per_page=25",
      code: 401,
      error: "Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info.",
    },
    {
      title: "id de time existente sem a chave",
      id_no_key: "/1",
      code: 401,
      error: "Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info.",
    },
    {
      title: "id de time inexistente sem a chave",
      id_no_key: "/0",
      code: 401,
      error: "Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info.",
    },
    {
      title: "sem o id de time sem a chave",
      id_no_key: "/",
      code: 401,
      error: "Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info.",
    },
  ]

  examples_no_key.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        sleep 2.8
        @result = Teams.new.id_no_key(e[:id_no_key])
      end

      it "valida status code" do
        expect(@result.code).to eql e[:code]
      end

      it "valida chave API" do
        expect(@result.parsed_response["message"]).to eql e[:error]
      end
    end
  end
end
