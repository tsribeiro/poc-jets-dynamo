
describe Account, type: :model do

    before(:each) do
        uuid = UUID.new
        @client_id = uuid.generate
        @account = Account.new({client_id: @client_id, name: "Thiago"})
    end

    it "Account must be saved" do
        @account.save
        expect(UUID.validate(@account.id)).to_not be_nil
    end

    it "Must have the account saved" do
        @account.save
        account = Account.find({id: @account.id, client_id: @client_id})
        expect(account).to_not be_nil
    end

    it "Must replace the account saved" do
        @account.save
        @account.update({name: "Thiago Ribeiro"})
        account = Account.find({id: @account.id, client_id: @client_id})

        expect(account.attrs[:id]).to eq(@account.id)
        expect(account.attrs[:client_id]).to eq(@client_id)
        expect(account.attrs[:name]).to eq("Thiago Ribeiro")
    end

    it "Must add new field to account saved" do
        @account.save
        @account.update("last_name": "Ribeiro")
        account = Account.find({id: @account.id, client_id: @client_id})

        expect(account.attrs[:id]).to eq(@account.id)
        expect(account.attrs[:client_id]).to eq(@client_id)
        expect(account.attrs[:last_name]).to eq("Ribeiro")
    end

    it "Must remove to account saved" do
        @account.save
        account = Account.find({id: @account.id, client_id: @client_id})
        account.destroy
        account = Account.find({id: @account.id, client_id: @client_id})

        expect(account).to be_nil
        
    end

    it "Must recover all saved accounts" do
        @account.save
        accounts = Account.all(@client_id)

        expect(accounts).to_not be_nil
        
    end

    after(:each) do
        Account.delete({id: @account.id, client_id: @client_id})
    end

end