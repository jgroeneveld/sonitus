# separate matcher fuer should und should not wegen
# https://github.com/jnicklas/capybara#asynchronous-javascript-ajax-and-friends

RSpec::Matchers.define :show_album do |album|
  selector = "#album_#{album.id}"

  match_for_should do |page|
    page.has_selector? selector
  end

  match_for_should_not do |page|
    page.has_no_selector? selector
  end
end
