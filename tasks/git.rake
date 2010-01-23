if RAILS_ENV == 'development' || RAILS_ENV == 'test'
  require "git_precommit"
  GitPrecommit::PrecommitTasks.new
  task :environment => ".git/hooks/pre-commit"
end
