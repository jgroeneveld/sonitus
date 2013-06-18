# separate matcher fuer should und should not wegen
# https://github.com/jnicklas/capybara#asynchronous-javascript-ajax-and-friends

RSpec::Matchers.define :show_album do |album|
  match_for_should do |page|
    page.has_selector? album_selector(album)
  end

  match_for_should_not do |page|
    page.has_no_selector? album_selector(album)
  end
end
