if Rails.env == 'development' || Rails.env == 'test'
  require "git_precommit"
  
  GitPrecommit::PrecommitTasks.new
  task :environment => ".git/hooks/pre-commit"
end
