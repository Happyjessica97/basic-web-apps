require "sinatra"

require "rubygems"
require "bundler/setup"

Bundler.require(:default, Sinatra::Application.environment)

# Load the .env file if it exists
if File.exist?(".env")
  Dotenv.load(".env")
end

# Yell at the user (and exit) if DATABASE_URL isn't set
unless ENV.key?("DATABASE_URL")
  puts "ENV['DATABASE_URL'] is undefined.  Make sure your .env file is correct."
  puts "To use the example file env.example, run"
  puts ""
  puts "  rake setup:dotenv"
  puts ""
  exit 1
end

DataMapper.setup(:default, ENV["DATABASE_URL"])

# Display DataMapper debugging information in development
if Sinatra::Application.development?
  DataMapper::Logger.new($stdout, :debug)
end
