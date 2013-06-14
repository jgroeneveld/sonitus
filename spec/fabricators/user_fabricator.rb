Fabricator(:user) do
  username { Faker::Name.first_name }
  email { Faker::Internet.safe_email }
  password '12345678'
end