require 'simplecov'
require 'simplecov-rcov'
require 'screencap'
require 'fastimage'
require 'database_cleaner'

SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start 'rails' do
  add_filter 'spec'
  add_filter 'config'
end

$:.unshift File.dirname(__FILE__) + '/../lib'
TMP_DIRECTORY = Dir.pwd.concat('/tmp/')

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  config.global_fixtures = :all

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.include Devise::TestHelpers, :type => :controller
  config.extend ControllerMacros, :type => :controller


  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.before(:all) do
    unless ENV['KEEP_OUTPUT']
      system("rm #{TMP_DIRECTORY}/*.png")
      system("rm #{TMP_DIRECTORY}/*.jpg")
    end
  end

  # http://stackoverflow.com/questions/6583618/clean-out-or-reset-test-database-with-rspec-and-mongoid-on-rails-3
  # config.use_transactional_fixtures = false

  # config.before :each do
  #   DatabaseCleaner.strategy = :truncation
  #   DatabaseCleaner.start
  # end
  #
  # config.after do
  #   DatabaseCleaner.clean
  # end

  config.before(:each) do
    Mongoid::Sessions.default.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
end
