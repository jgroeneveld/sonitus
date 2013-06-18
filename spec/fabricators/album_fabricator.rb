Fabricator :album do
  title { Faker::Lorem.words.join(" ") }
  artist { Faker::Lorem.word }
  year 2001
end


Fabricator :album_with_image, from: :album do
  image { File.open(Rails.root.join('spec', 'fixtures', 'album_image.gif')) }
end