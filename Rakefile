begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name    = "git-precommit"
    gemspec.summary = "Fail commits if the tests fail."
    gemspec.description = <<-EOS
    A set of rake tasks that install git pre-commit hooks to call your build.
    If your build fails, the commit will not proceed.
    EOS
    gemspec.email   = "toby.tripp+git@gmail.com"
    gemspec.homepage = "http://github.com/tobytripp/git-pre-commit"
    gemspec.authors = ["Toby Tripp"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
