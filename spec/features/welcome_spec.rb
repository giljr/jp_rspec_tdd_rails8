require 'rails_helper'

RSpec.feature "Welcome", type: :feature do
  scenario "Mostra a mensagem de boas vindas" do
    visit(root_path)
    expect(page).to have_content('Bem-vindo')
  end

  scenario "Verificar o link de Cadastro de Cliente" do
    visit(root_path)
    expect(find('ul li')).to have_link('Cadastro de Clientes')
    # expect(page).to have_selector('ul li a')
    # expect(page).to have_link('Cadastro de Clientes')
  end
    
end
