require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
    # Include Devise helpers in rails_hepler.rb:
    # include Devise::Test::ControllerHelpers, :type => :controller
    include Devise::Test::ControllerHelpers
    
    it 'responde com sucesso' do
        get :index
        expect(response).to have_http_status(:success)
        expect(response).to have_http_status(200)
        # puts response.inspect

        # Rails 5.1+, incluindo Rails 8) o matcher be_success foi removido
        # expect(response).to be_success
    end

    it 'responde a show c/ 302 (not authenticated)' do
        customer = create(:customer)
        get :show, params: { id: customer.id }
        expect(response).to have_http_status(302)

        # Failure/Error: get :show, params: { id: customer.id }     
        #  Devise::MissingWarden:
        #    Devise could not find the `Warden::Proxy` instance on your request environment.
        #    Make sure that your application is loading Devise and Warden as expected and that the `Warden::Manager` middleware is present in your middleware stack.
        #    If you are seeing this on one of your tests, ensure that your tests are either executing the Rails middleware stack or that your tests are using the `Devise::Test::ControllerHelpers` module to inject the `request.env['warden']` object for you.
    end

    it 'responde a show c/ 200 (authenticated)' do
        member = create(:member)
        customer = create(:customer)
        # member.confirm   # Devise method to confirm a user

        sign_in member     

        get :show, params: { id: customer.id }
        expect(response).to have_http_status(:success)

    end

    it 'Renderiza o template :show' do
        member = create(:member)
        customer = create(:customer)
        # member.confirm   # Devise method to confirm a user

        sign_in member     

        get :show, params: { id: customer.id }
        expect(response).to render_template(:show)

        # NoMethodError:
        #  assert_template has been extracted to a gem. To continue using it,
        #        add `gem "rails-controller-testing"` to your Gemfile.
    end
end
