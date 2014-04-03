require 'bundler'
Bundler.require

Dir["#{__dir__}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |c|
  c.filter_run :focus
  c.run_all_when_everything_filtered = true

  c.order = :random
  Kernel.srand c.seed

  c.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  c.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end
