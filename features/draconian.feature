#!/usr/bin/env cucumber
Feature: Draconian option
Background:
  Given a directory named ".git/hooks"
    And a file named "Rakefile" with:
    """
    require "../../lib/git_precommit"
    GitPrecommit::PrecommitTasks.new :draconian => true
    
    task :default => ".git/hooks/pre-commit"
    """
  
Scenario: No pre-commit hook is installed
  When I successfully run "rake"

  Then the following files should exist:
    | .git/hooks/pre-commit |

Scenario: The pre-commit hook is modified
  When I append to ".git/hooks/pre-commit" with:
  """
  echo "My new hook!"
  """

  And I successfully run "rake"
  
  Then the file ".git/hooks/pre-commit" should not contain "echo"
