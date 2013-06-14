Fabricator(:album) do
  title { Faker::Lorem.words.join(" ") }
  artist { Faker::Lorem.word }
  year 2001
  user { |params| params[:user] }
end