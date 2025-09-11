FactoryBot.define do 
    factory :customer do 
        name { Faker::Name.name }
        email { Faker::Internet.email }
        phone { Faker::PhoneNumber.cell_phone}
        smoker { ['N', 'S'].sample } 
        gender { ['male', 'female', 'other'].sample }
        avatar { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/avatar.png", "image/png") }
    end

end