Fabricator(:album) do
  title 'Mutter'
  artist 'Rammstein'
  year 2001
  user { |params| params[:user] }
end