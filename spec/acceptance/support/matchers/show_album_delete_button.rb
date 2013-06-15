RSpec::Matchers.define :show_album_delete_button do
  selector = '.album .controls .delete'

  match_for_should do |page|
    page.has_selector? selector
  end

  match_for_should_not do |page|
    page.has_no_selector? selector
  end
end
