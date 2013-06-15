desc "Run tests with SimpleCov"
RSpec::Core::RakeTask.new('coverage') do |t|
  ENV['COVERAGE'] = "true"
end
