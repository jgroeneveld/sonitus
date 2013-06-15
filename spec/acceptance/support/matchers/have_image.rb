# angelehnt an
# http://lostechies.com/derickbailey/2011/09/27/adding-a-has_image-matcher-to-capybara/

RSpec::Matchers.define :have_image do |src|
  match_for_should do |page|
    page.has_xpath?("//img[contains(@src,\"#{src}\")]")
  end

  match_for_should_not do |page|
    page.has_no_xpath?("//img[contains(@src,\"#{src}\")]")
  end
end
