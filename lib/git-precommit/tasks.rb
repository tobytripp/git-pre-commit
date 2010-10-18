if defined? Rails
  ENVIRONMENT = Rails.env
else 
  ENVIRONMENT   = RAILS_ENV if defined? RAILS_ENV
  ENVIRONMENT ||= ENV["RACK_ENV"] if ENV["RACK_ENV"]
  ENVIRONMENT ||= "development"
end

if %w[development cucumber test].include? ENVIRONMENT
  require "git_precommit"
  
  GitPrecommit::PrecommitTasks.new
  task :environment => ".git/hooks/pre-commit"
end
