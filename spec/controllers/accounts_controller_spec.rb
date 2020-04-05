describe AccountsController, type: :controller do

    before(:each) do
        @client_id = "a000aaf0-59ad-0138-53bd-2c87a333df7f"
        @account = Account.new({client_id: @client_id, name: "Thiago", last_name: "Ribeiro"})
    end

    it "Account must be saved" do

        post '/accounts', 
        {  
            name: "Thiago", 
            last_name: "Ribeiro" 
        }

        expect(response.status).to eq 201
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['id']).to_not be_empty
        Account.delete({id: parsed_response['id'], client_id: @client_id})
    end

    it "Must have the account saved" do
        @account.save
        get '/accounts/:id', id: @account.id
        expect(response.status).to eq 200

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['id']).to eq @account.id
    end

    it "Must replace the account saved" do
        @account.save
        patch "/accounts/".concat(@account.id), params: { name: "Matheus" }
        account = Account.find({id: @account.id, client_id: @client_id})

        expect(account.attrs[:id]).to eq(@account.id)
        expect(account.attrs[:client_id]).to eq(@client_id)
        expect(account.attrs[:name]).to eq("Matheus")
        expect(account.attrs[:last_name]).to eq("Ribeiro")
    end

    it "Must recover all saved accounts" do
        @account.save
        get '/accounts'
        expect(response.status).to eq 200

        pp JSON.parse(response.body)
    end

    it "Must remove to account saved" do
        @account.save
        delete "/accounts/".concat(@account.id)
        account = Account.find({id: @account.id, client_id: @client_id})

        expect(account).to be_nil
        
    end

    after(:each) do
        Account.delete({id: @account.id, client_id: @client_id}) if @account.id
    end
end
