### 🐜️ Rails + RSpec + Devise: Um Fluxo Prático de TDD

#### 1. New App

```bash
rails new tdd_app - T
```

#### 2. Gem file - Add rspec e capybara

```bash
 bundle install
```

#### 3. Rspec

```bash
  rails g rspec:install
```

#### 4. spec_helper.rb: -> =begin =end (uncomment)

#### 5. DB

```bash
rails db:create:all
```

#### 6. group :development, :test do

```bash
group :development, :test do

  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers" # needed for js "Deseja Realmente eexcluir?"
  gem "rspec-rails"
  gem "faker"
  gem "factory_bot_rails"

  # Spring speed up dev up by keeping your app running in the backgroud
  gem "spring"
  gem "spring-watcher-listen"
  gem "spring-commands-rspec"

  # https://github.com/thoughtbot/shoulda-matchers
  gem "shoulda-matchers", "~> 6.0"

  # to renderize template in test
  gem "rails-controller-testing"

end
```

separate:

```bash
group :development do

   # Use console on exceptions pages [https://github.com/rails/web-console]
   gem "web-console"

end
```

```bash
bundle exec spring binstub rspec
```

#### 7. config/application.rb

```bash
config.generators do |g|
      g.test_framework :rspec,
                       fixtures: false,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       request_specs: true,
                       controller_specs: false,
                       system_specs: true
    end
```

#### 8. Rspec

```bash
bin/rspec
```

#### 9. Feature Spec

```bash
rails g rspec:feature welcome
```

#### 10. it => scenario 1

tdd_app/spec/features/welcome_spec.rb:

```
scenario "Mostra a mensagem de boas vindas" do
    visit(root_path)
    expect(page).to have_content('Bem-vindo')
end
```

Steps "baby-steps":

```
-> route: root "welcome#index"
-> controller: "rails g controller welcome"
-> def index
-> template - views/welcome/index.html.erb
-> crie a mensagem
-> pass !!!!
```

#### 11. Form 1 - [TODO: 3 forms] - Receive variable @customer

```bash
rails g model customer name email smoker phone avatar
rails db:migratte
```

```bash
scenario "Verificar o link de Cadastro de Cliente" do
  visit(root_path)
  expect(find('ul li')).to have_link('Cadastro de Clientes')
  # expect(page).to have_selector('ul li a')
  # expect(page).to have_link('Cadastro de Clientes')
end
```

#### 12. navigation from page 1 to 2 to 3

```bash
rails g rspec:feature customer
```

#### 13. features/customer_spec.rb

```bash
1. scenario 'Verifica link Cadastro de Cliente'
2. scenario 'Verifica link de Novo Cliente'
3. scenario 'Verifica formulário de Novo Cliente'
```

Steps "baby-steps" again!
use this to descover the routes:

```bash
rails routes
```

or

```bash
bin/dev
/rails/info/routes
```

#### 14. CRUD

Inside rspec use fill_in from capybara
use Faker Lib

```bash
gem "faker"
```

#### 15. Model - index, create, new, edit, show, updae, destroy

```
rails g model customer name email smoker phone avatar
```

#### 16. Activate i18n (https://guides.rubyonrails.org/i18n.html)

```bash
gem 'rails-i18n'
```

Go to `config/application.rb`:

```
# Mapping tables and fields to your language
config.i18n.default_locale = :'pt-BR'
```

#### 17. Map to be i18n independent

https://www.rubydoc.info/gems/capybara/Capybara%2FNode%2FActions:fill_in

```
# model_field syntax:
fill_in('customer_email', with: Faker::Internet.email)
```

#### 18. radio

```
# Fumante? label exist?
expect(page).to have_content('Fumante?')
# Choose a radio button by label
choose('smoker_s') # same as "Sim"
```

Index:

```
<div>
 <%= f.label :smoker, "Fumante?" %><br>
 <%= f.radio_button :smoker, 'S', id: 'smoker_s' %>
 <%= f.label :smoker_s, 'Sim' %>
</div>
```

#### 19. Deal w/ Redirecting

```
<% if flash[:notice] %>
<% end %>
```

#### 20. Testing MODELS

```
rails g model category description:string
rails g model product description:string, price:decimal, category:references
```

Case rspec not installed:

```
rails g rspec:model product
rails g rspec:model category
```

#### 21. First specs for Models

```
1. When instantiated with valid attributes, the model should be valid.

2. Validations should be tested (by negating some attributes).

3. Class and instance methods should execute correctly.
```

#### 22. Use shoulda Matchers - simple one-liner Tests for Rails

https://github.com/thoughtbot/shoulda-matchers

```
 gem "shoulda-matchers", "~> 6.0"
```

#### 23. Testing CONTROLLERS

What does the controller do?

```
1. Receives requests (with or without authentication)

2. Manipulates the model

3. Renders a response (via template or JSON if requested)

4. Redirects
```

#### 24. Criate (< Rails 5.0+ w/ RSpec >= 3.5)

no-more -> spec/controllers/...
instead -> spec/requests/...
`controllers specs`: skip [middleware, routes, full request/response flow]
`request specs`: full rails stack :)

```
rails g rspec:controller customers
```

#### 25. Use Devise

https://github.com/heartcombo/devise

```
gem 'devise'
rails g devise:install
rails g devise user/member
rails db:migrate
```

#### 26. Factory Bot

Gemfile:

```
gem "factory_bot_rails"
```

spec/rails_helper.rb

```
  config.include FactoryBot::Syntax::Methods
```

Define:

```
FactoryBot.define do
  factory :category do
    description { Faker::Commerce.department }
  end
end
```

#### 27. Controller Specs vs Feature Specs

see [link](controller_vs_feature_specs.md)

#### 28. Devise vs Warden

see [link](devise_vs_warden_test.md)

Thank you!
