require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'é válido com description, price and category' do
    product = create(:product)
    expect(product).to be_valid
  end

  # it "é inválido sem a descrição" do
  #   product = build(:product, description: nil) # build -> só na memória, não use create 
  #   product.valid?
  #   expect(product.errors[:description]).to include("não pode ficar em branco")
  # end

  # it { should validate_presence_of(:description) }
  # it { is_expected.to validate_presence_of(:description) }

  # it "é inválido sem o price" do
  #   product = build(:product, price: nil) # build -> só na memória, não use create 
  #   product.valid?
  #   expect(product.errors[:price]).to include("não pode ficar em branco")
  # end

  # it { should validate_presence_of(:price) }

  # it "é inválido sem a category" do
  #   product = build(:product, category: nil) # build -> só na memória, não use create 
  #   product.valid?
  #   expect(product.errors[:category]).to include("não pode ficar em branco")
  # end

  # it { should validate_presence_of(:category) }

  context "Validações" do
    it { is_expected.to validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:category) }    
  end


  

  # belong_to
  # it { should belong_to(:category)}
  # it { is_expected.to belong_to(:category)}

  context "Associaçoes" do
    it { is_expected.to belong_to(:category)}
  end


  # it 'retorna a descrição completa do produto' do
  #   product = create(:product)
  #   expect(product.full_description).to eq("#{product.description} - #{product.price}")
  # end

  context "Métodos de Instancia" do
    it '#full_description' do
      product = create(:product)
      expect(product.full_description).to eq("#{product.description} - #{product.price}")
    end
  end


end
