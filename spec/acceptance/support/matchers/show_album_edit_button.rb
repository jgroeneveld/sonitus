RSpec::Matchers.define :show_album_edit_button do
  selector = '.album .controls .edit'

  match_for_should do |page|
    page.has_selector? selector
  end

  match_for_should_not do |page|
    page.has_no_selector? selector
  end
end
