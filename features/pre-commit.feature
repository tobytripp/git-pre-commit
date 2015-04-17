#!/usr/bin/env cucumber
Feature: Pre commit hook installation
Background:
  Given I successfully run "git init"
    And a file named "Rakefile" with:
    """
    require "../../lib/git_precommit"
    GitPrecommit::PrecommitTasks.new
    
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
  
   And I successfully run "rake --trace"
   
  Then the file ".git/hooks/pre-commit" should contain "echo"

