#!/usr/bin/env cucumber
Feature: Using repository local hook scripts
Background:
  Given I successfully run "git init"
    And a file named "Rakefile" with:
    """
    require "../../lib/git_precommit"
    GitPrecommit::PrecommitTasks.new :path => "myhooks"

    task :default => ".git/hooks/pre-commit"
    """
    And a directory named "./myhooks"
    And a file named "./myhooks/pre-commit" with:
    """
    #!/usr/bin/env sh
    # My Hook
    """

Scenario: No pre-commit hook is installed
  When I successfully run "rake"

  Then the following files should exist:
    | .git/hooks/pre-commit |

   And the file ".git/hooks/pre-commit" should contain "My Hook"

Scenario: The pre-commit hook is modified
  When I append to ".git/hooks/pre-commit" with:
  """
  echo "My new hook!"
  """

  And I successfully run "rake"

  Then the file ".git/hooks/pre-commit" should not contain "echo"
