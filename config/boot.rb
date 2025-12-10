ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.

# Load environment variables from .env file (only loads if .env exists)
begin
  require "dotenv"
  Dotenv.load
rescue LoadError
  # dotenv not available, skip
end

require "bootsnap/setup" # Speed up boot time by caching expensive operations.
