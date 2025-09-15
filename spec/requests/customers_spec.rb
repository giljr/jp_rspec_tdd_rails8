require 'rails_helper'

# Call: bin/rspec spec/requests/customers_spec.rb
RSpec.describe "Customers", type: :request do  
    it 'responde com sucesso' do
        get '/customers'
        expect(response).to have_http_status(:success)
        expect(response).to have_http_status(200)
  
        # Call: bin/rspec spec/controllers/customers_controller_spec.rb       

        # In a "controller spec", you call:
        #   get :index
        #   because you are directly invoking the controller action.

        # But in a "request spec" (type: :request), you’re testing the full HTTP request/response cycle, so you must call it with a path/URL, not a symbol:
        #   get "/customers"
    end
end

