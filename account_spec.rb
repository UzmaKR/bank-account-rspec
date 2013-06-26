require "rspec"

require_relative "account"

describe Account do

  let(:acct_number) {"1234567890"}
  let(:wrong_acct_number) {"12345678"}
  let(:account) { Account.new(acct_number) }

  describe "#initialize" do
    context "with valid input" do
      it "creates a new Account with right account number" do
        expect(account.acct_number).to eq("******7890")
        expect(account.transactions).to eq([0])
      end
    end

    context "with invalid input" do
      it "does not create a new Account" do
        expect { Account.new(wrong_acct_number) }.to raise_error(InvalidAccountNumberError)
      end
    end
  end

  describe "#transactions" do
    it "gets an array of transactions" do
      account.deposit!(100)
      account.withdraw!(20)
      expect(account.transactions).to eq([0,100,-20])
    end
  end

  describe "#balance" do
    context "new account should have zero balance" do
      it "has a balance of zero" do
        expect(account.balance).to eq(0)
      end
    end 

    context "account with several transactions" do
      it "has the right net account balance" do
        account.deposit!(500)
        account.withdraw!(50)
        expect(account.balance).to eq(450)
      end
    end 
  end

  describe "#account_number" do
    it "has commented out all numbers except last 4" do
      expect(account.acct_number).to eq("******7890")
    end
  end

  describe "deposit!" do
    it "returns the current balance" do
      account.deposit!(20).should_not be_nil
      account.deposit!(50).should be(70)
    end

    it "raises error if amount is negative" do
      expect { account.deposit!(-20) }.to raise_error(NegativeDepositError) 
    end

  end

  describe "#withdraw!" do
    it "returns current balance" do 
      account.deposit!(50)
      account.withdraw!(10)
      expect(account.balance).to eq(40)
    end
  end
end
