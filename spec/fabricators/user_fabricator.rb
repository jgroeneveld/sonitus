Fabricator :user do
  username { Faker::Name.first_name }
  email { Faker::Internet.safe_email }
  password '12345678'
end

Fabricator :user_with_albums, from: :user do
  albums { [Fabricate(:album)] }
end