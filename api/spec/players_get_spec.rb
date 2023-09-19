describe "Get Players" do
  examples_ok_key = Helpers::get_fixture("jogadores_ok_key")

  examples_ok_key.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Chave.new.id_ok_key("players", e[:id_ok_key])
      end

      it "valida status code" do
        expect(@result.code).to eql e[:code]
      end
    end
  end

  examples_no_key = Helpers::get_fixture("jogadores_no_key")

  examples_no_key.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        sleep 2.8
        @result = Chave.new.id_no_key("players", e[:id_no_key])
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
