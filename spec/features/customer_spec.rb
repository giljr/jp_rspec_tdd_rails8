require 'rails_helper'
require 'faker'

RSpec.feature "Customers", type: :feature do
  include Warden::Test::Helpers

  scenario 'Verifica link Cadastro de Cliente' do
    visit(root_path)
    expect(page).to have_link('Cadastro de Clientes')
  end

  scenario 'Verifica link de Novo Cliente' do
    visit(root_path)
    click_on('Cadastro de Clientes')
    expect(page).to have_content('Listando Clientes')
    expect(page).to have_link('Novo Cliente')

  end

  scenario 'Verifica formulário de Novo Cliente' do
    # devise
    member = create(:member)

    login_as(member, scope: :member) # Warden helper
    
    visit(customers_path)
    click_on('Novo Cliente')
    expect(page).to have_content('Novo Cliente')
    # verifica se os campos do formulário existem
    # expect(page).to have_field('Nome')
  end
   
   # CREATE - CRIAR CLIENTE
  scenario 'Cadastra um cliente válido' do
    # devise
    member = create(:member)

    login_as(member, scope: :member) # Warden helper

    visit(new_customer_path)

    customer_name = Faker::Name.name

    fill_in('customer_name', with: customer_name)
    # fill_in('Nome',	with: customer_name)
  
    fill_in('customer_email', with: Faker::Internet.email)
    # fill_in('Email', with: Faker::Internet.email)

    fill_in('customer_phone', with: Faker::PhoneNumber.cell_phone)
    # fill_in('customer_phone', with: Faker::PhoneNumber.phone_number)
    # fill_in('Telefone', with: Faker::PhoneNumber)

    attach_file('Foto do Perfil', "#{Rails.root}/spec/fixtures/avatar.png")

    # Fumante? label exist?
    expect(page).to have_content('Fumante?')
    # Choose a radio button by label
    choose('smoker_s') # same as "Sim"
    # choose('smoker_n') # same as "Não"

    # Submit the form
    click_on('Criar Cliente')

    expect(page).to have_content('Cliente cadastrado com sucesso!')

    expect(Customer.last.name).to eq(customer_name)
  end

  # SAD PATH
  scenario 'Não cadastra um cliente inválido' do
    # devise
    member = create(:member)

    login_as(member, scope: :member) # Warden helper

    visit(new_customer_path)
    click_on('Criar Cliente')
    expect(page).to have_content('não pode ficar em branco')
  end


  # READ - MOSTRAR CLIENTE
  scenario 'Mostra um cliente' do
    # devise
    member = create(:member)

    login_as(member, scope: :member) # Warden helper

    customer = create(:customer)
    # customer = Customer.create!(
    #   name: Faker::Name.name,
    #   email: Faker::Internet.email,
    #   phone: Faker::PhoneNumber.cell_phone,
    #   smoker: ['S', 'N'].sample,
    #   avatar: "#{Rails.root}/spec/fixtures/avatar.png"
    # )

    visit(customer_path(customer.id))
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.phone)
  end
  
  # SHOW - Mostranda a lista de clientes
  scenario 'Testando a index' do
    customer_1 = create(:customer)
    # customer_1 = Customer.create!(
    #   name: Faker::Name.name,
    #   email: Faker::Internet.email,
    #   phone: Faker::PhoneNumber.cell_phone,
    #   smoker: ['S', 'N'].sample,
    #   avatar: "#{Rails.root}/spec/fixtures/avatar.png"
    # )
    
    customer_2 = create(:customer)
    # customer_2 = Customer.create!(
    #   name: Faker::Name.name,
    #   email: Faker::Internet.email,
    #   phone: Faker::PhoneNumber.cell_phone,
    #   smoker: ['S', 'N'].sample,
    #   avatar: "#{Rails.root}/spec/fixtures/avatar.png"
    # )

    visit(customers_path)
    expect(page).to have_content(customer_1.name).and have_content(customer_2.name)
  end

  # UPDATE
  scenario 'Atualiza um cliente' do
    # Cria um cliente inicial
    customer = create(:customer)
    # customer = Customer.create!(
    #   name: Faker::Name.name,
    #   email: Faker::Internet.email,
    #   phone: Faker::PhoneNumber.cell_phone,
    #   smoker: 'S', # valor inicial compatível com form
    #   gender: 'male',
    #   avatar: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/avatar.png", "image/png")
    # )

    # devise
    member = create(:member)

    login_as(member, scope: :member) # Warden helper

    # Novo valor para atualização
    updated_name = Faker::Name.name

    # Visita a página de edição
    visit(edit_customer_path(customer.id))

    # Preenche o campo Nome
    fill_in('Nome', with: updated_name)

    # # Escolhe radio button de Fumante aleatoriamente
    # choose('smoker_s') # same as "Sim"
    # # choose('smoker_n') # same as "Não"

    # Atualiza o cliente
    click_on 'Atualizar Cliente'

    # Verifica se a atualização foi bem sucedida
    expect(page).to have_content('Cliente atualizado com sucesso!')
    expect(page).to have_content(updated_name)
  end

  scenario 'Clica no link Mostrar da Index' do
    # devise
    member = create(:member)

    login_as(member, scope: :member) # Warden helper

    # Cria um cliente inicial
    create(:customer)
    # Customer.create!(
    #   name: Faker::Name.name,
    #   email: Faker::Internet.email,
    #   phone: Faker::PhoneNumber.cell_phone,
    #   smoker: 'S', # valor inicial compatível com form
    #   gender: 'male',
    #   avatar: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/avatar.png", "image/png")
    # )

    visit(customers_path)
    find(:xpath, "/html/body/table/tbody/tr[1]/td[2]/a").click
    expect(page).to have_content("Mostrando Cliente")

  end

    scenario 'Clica no link Editar da Index' do
    # devise
    member = create(:member)

    login_as(member, scope: :member) # Warden helper

      # Cria um cliente inicial
      create(:customer)
      # Customer.create!(
      #   name: Faker::Name.name,
      #   email: Faker::Internet.email,
      #   phone: Faker::PhoneNumber.cell_phone,
      #   smoker: 'S', # valor inicial compatível com form
      #   gender: 'male',
      #   avatar: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/avatar.png", "image/png")
      # )

      visit(customers_path)
      find(:xpath, "/html/body/table/tbody/tr[1]/td[3]/a").click
      expect(page).to have_content("Editando Cliente")

    end
  
  # Destroy
  scenario 'Apaga um cliente', js: true do
    # devise
    member = create(:member)

    login_as(member, scope: :member) # Warden helper

    # Cria um cliente inicial
    customer = create(:customer)
    # customer = Customer.create!(
    #   name: Faker::Name.name,
    #   email: Faker::Internet.email,
    #   phone: Faker::PhoneNumber.cell_phone,
    #   smoker: 'S',
    #   gender: 'male',
    #   avatar: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/avatar.png", "image/png")
    # )

    visit(customers_path)
    # include Gemfile (& js:true):
    #  gem "selenium-webdriver"
    #  gem "webdrivers" # needed for js "Deseja Realmente excluir?"
    # Usa accept_confirm para simular o clique e confirmar
    accept_confirm do
      click_link "delete_customer_#{customer.id}"
    end

    expect(page).to have_content('Cliente excluído com sucesso!')
    expect(page).not_to have_content(customer.name)
  end

  # devise use (, type: :controller)
  #  include Devise::Test::ControllerHelpers


  include Warden::Test::Helpers

  # -----------------------
  # Controller spec
  # -----------------------
  # RSpec.describe CustomersController, type: :controller do
  #   include Devise::Test::ControllerHelpers

  #   describe 'GET #show' do
  #     it 'responde com 200 OK', :devise do
  #       customer = create(:customer)

  #       get :show, params: { id: customer.id }

  #       expect(response).to have_http_status(200)
  #     end
  #   end
  # end
  
  # devise use (, type: :feature, type: :feature ) 
  # -----------------------
  # Feature spec
  # -----------------------
  # RSpec.feature 'Customers', type: :feature do
    include Warden::Test::Helpers

    scenario 'responde com 200 OK e mostra nome do cliente', :devise do
      customer = create(:customer)
      member   = create(:member) # ou :user, dependendo do seu Devise

      login_as(member, scope: :member)
      visit customer_path(customer)

      expect(page.status_code).to eq(200)
      expect(page).to have_content(customer.name)
    end
  # end

  #   Diferenças principais:

  # Controller spec
  # → usa get :show, params: {...}
  # → valida response diretamente.
  # → rápido, sem Capybara.

  # Feature spec
  # → usa visit customer_path(customer)
  # → precisa autenticar via login_as (Warden).
  # → valida conteúdo real da página (have_content).

   
end

