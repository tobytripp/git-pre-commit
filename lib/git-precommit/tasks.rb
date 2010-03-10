if defined? Rails
  ENVIRONMENT = Rails.env
else 
  ENVIRONMENT = RAILS_ENV || "development"
end

if %w[development test].include? ENVIRONMENT
  require "git_precommit"
  
  GitPrecommit::PrecommitTasks.new
  task :environment => ".git/hooks/pre-commit"
end
