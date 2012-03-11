# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "git-precommit/version"

Gem::Specification.new do |s|
  s.name = %q{git-precommit}
  s.version = GitPrecommit::VERSION

  s.authors  = ["Toby Tripp"]
  s.email    = %q{toby.tripp+git@gmail.com}
  s.homepage = %q{http://github.com/tobytripp/git-pre-commit}

  s.summary = %q{Abort git commit if the tests fail.}
  s.description = %q{
    A set of rake tasks that install git pre-commit hooks to run your tests.
    If your build fails, the commit will not proceed.

    Git-precommit will call `rake precommit` to run your tests.  Be sure to define this task.
  }

  s.files            = `git ls-files`.split("\n")
  s.executables      = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths    = ["lib"]

  s.extra_rdoc_files = %w[README.rdoc]
  s.rdoc_options     = ["--charset=UTF-8"]
  s.rubygems_version = %q{1.3.6}

  s.rubyforge_project = "git-precommit"

  s.add_dependency "rake"

  s.add_development_dependency "rspec",    "~> 2.0.0"
  s.add_development_dependency "cucumber", "~> 0.9.0"
  s.add_development_dependency "aruba"
  s.add_development_dependency "syntax"
  s.add_development_dependency "guard",    "~> 0.2.2"
  s.add_development_dependency "guard-cucumber"
end
