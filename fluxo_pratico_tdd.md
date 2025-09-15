### 🚀 Rails 8 + RSpec + Devise: Um Fluxo Prático de TDD

Este tutorial mostra um ciclo real de desenvolvimento dirigido a testes (TDD) em Rails 8 com RSpec e Devise, passando por debugging de specs, criação de novos modelos e versionamento no GitHub.

#### 1. Criando um novo projeto Rails para TDD

Você pode começar um projeto novo focado em TDD:

```bash
rails new tdd_app
cd tdd_app
```

E preparar o Ruby adequado:

```bash
rbenv install 3.0.1
bundle install
rails s
```

#### 2. Rodando os primeiros testes de feature

Você começa rodando os testes de feature (customer_spec) várias vezes:

```bash
rspec spec/features/customer_spec.rb
```

Quando a saída ficava poluída, limpava com:

```bash
clear
```

#### 3. Tentativa de rodar servidor no ambiente de teste

Para o ambiente de execução, tentar levantar o servidor com:

```bash
RAILS_ENV=test bin/dev
# ou
RAILS_ENV=test rails s
```

#### 4. Executando toda a suíte de testes

Não apenas um arquivo, mas a suíte completa:

```bash
rspec
rspec --format doc
```

#### 5. Alternando entre dev e test

Durante a depuração, alternar entre rodar o servidor em desenvolvimento e em teste:

```bash
bin/dev
RAILS_ENV=test bin/dev
```

#### 6. Isolando falha em uma linha específica

Para debugar apenas um teste problemático:

```bash
rspec spec/features/customer_spec.rb:103 --format documentation --fail-fast --save-page
```

Ou falha a falha:

```bash
bin/rspec spec/models/member_spec.rb --next_failure
```

#### 7. Escrevendo testes de modelo

Primeiros testes de modelo (Product):

```bash
bin/rspec spec/models/product_spec.rb
```

#### 8. Migrando de feature specs para controller/request specs

Gerar novos specs para controllers:

```bash
rails g rspec:controller customers
bin/rspec spec/requests/customers_spec.rb
```

#### 9. Integrando Devise para autenticação

Instalar e configurar o Devise:

```bash
bundle add devise
rails generate devise:install
rails g devise member
rails db:migrate
```

Rodar specs do controller de customers com autenticação de member.

#### 10. Refatorando e organizando specs

Criou novos arquivos e rodou várias vezes:

```bash
bin/rspec spec/controllers/customers_controller_refactored_spec.rb
```

#### 11. Evoluindo o schema do app

Criou migrations para novos campos:

rails generate migration AddGenderToCustomers gender:string
rails db:migrate

#### 12. Versionando no GitHub

Iniciar e configurar o repositório:

```bash
git init
git add .
git commit -m "first commit"
git branch -M master
git remote add origin git@github.com:giljr/jp_rspec_tdd_rails8.git
git push -u origin master
```

Também configurar SSH Keys para autenticação com GitHub.

```bash
ls ~/.ssh
cat ~/.ssh/id_ed25519.pub
ssh-keygen -t ed25519 -C "giljr.2009@gmail.com"
cat ~/.ssh/id_ed25519.pub
ssh-keygen -t ed25519 -C "giljr.2009@gmail.com" -f ~/.ssh/id_ed25519_personal
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519_personal
cat ~/.ssh/id_ed25519_personal.pub
```

#### 13. Criando novos modelos

Adicionar Category e Product:

```bash
rails g model category description:string
rails g model product description:string price:decimal category:references
rails db:migrate
```

E rodar os specs:

```bash
bin/rspec spec/models/product_spec.rb
```

#### 14. Rodando com filtros e tags

Usar ferramentas para isolar falhas:

```bash
bin/rspec --next-failure
bin/rspec --tag devise
```

#### 15. Começando a testar o modelo Member

Criar e rodar o primeiro spec de Member:

```bash
bin/rspec spec/models/member_spec.rb
bin/rspec spec/models/member_spec.rb --next-failure
```

#### ✅ Resumo Final

O ciclo seguido foi:

```bash
Rodar e depurar specs de feature (Customer).

Criar um novo projeto Rails focado em TDD.

Migrar testes de feature para controller/request.

Integrar Devise com Member para autenticação.

Adicionar migrations e novos modelos (Product, Category).

Versionar no GitHub com SSH configurado.

Usar filtros (--next-failure, --tag) para isolar problemas.

Iniciar testes de modelo (Member).
```
