Fabricator(:album) do
  title 'Mutter'
  artist 'Rammstein'
  user { |params| params[:user] }
end