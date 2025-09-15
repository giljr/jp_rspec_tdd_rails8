require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  # Include Devise test helpers
  include Devise::Test::ControllerHelpers

  describe "GET #index" do
    it "responde com sucesso" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    let(:customer) { create(:customer) }

    context "quando não autenticado" do
      it "redireciona para login (302)" do
        get :show, params: { id: customer.id }
        expect(response).to have_http_status(302)
      end
    end

    context "quando autenticado" do
      let(:member) { create(:member) }

      before do
        # Confirm user if Devise confirmable is enabled
        # member.confirm
        sign_in member
      end

      it "responde com sucesso (200)" do
        get :show, params: { id: customer.id }
        expect(response).to have_http_status(:success)
      end

      it "renderiza o template :show" do
        get :show, params: { id: customer.id }
        expect(response).to render_template(:show)
      end
    end
  end
end
