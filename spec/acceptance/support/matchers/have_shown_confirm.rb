RSpec::Matchers.define :have_shown_confirm do |message|
  match do |page|
    !page.driver.confirm_messages.nil? && page.driver.confirm_messages.include?(message)
  end
end
