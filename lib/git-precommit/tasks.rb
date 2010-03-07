ENVIRONMENT = Rails.env || RAILS_ENV
if %w[development test].include? ENVIRONMENT
  require "git_precommit"
  
  GitPrecommit::PrecommitTasks.new
  task :environment => ".git/hooks/pre-commit"
end
