if RAILS_ENV == 'development' || RAILS_ENV == 'test'
  $LOAD_PATH.unshift( File.join( File.dirname( __FILE__ ), '..', 'lib' ) )
  require "git_precommit"
  
  GitPrecommit::PrecommitTasks.new
  task :environment => ".git/hooks/pre-commit"
end
