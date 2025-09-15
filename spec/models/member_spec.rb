require 'rails_helper'

RSpec.describe Member, type: :model do
  describe "validações" do
    it "é válido com email e senha" do
      member = Member.new(
        email: "teste@example.com",
        password: "password123",
        password_confirmation: "password123"
      )
      expect(member).to be_valid
    end

    it "é inválido sem email" do
      member = Member.new(password: "password123", password_confirmation: "password123")
      expect(member).not_to be_valid
      expect(member.errors[:email]).to include("não pode ficar em branco")
    end

    it "é inválido sem senha" do
      member = Member.new(email: "teste@example.com")
      expect(member).not_to be_valid
      expect(member.errors[:password]).to include("não pode ficar em branco")
    end
  end
end
