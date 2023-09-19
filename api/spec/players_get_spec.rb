describe "Get Players" do
  examples_ok_key = Helpers::get_fixture("jogadores_ok_key")

  examples_ok_key.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = BaseApi.new.consulta_chave("players", e[:consulta_chave])
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
        @result = BaseApi.new.consulta_sem_chave("players", e[:consulta_sem_chave])
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
