#!/usr/bin/env cucumber
Feature: Using a submodule's local hook scripts
Background:
  Given I successfully run "git init"
    And I successfully run "git submodule add https://github.com/octocat/spoon-knife subproject"
    And I cd to "subproject"
    And a file named "Rakefile" with:
    """
    require "../../../lib/git_precommit"
    GitPrecommit::PrecommitTasks.new :path => "myhooks"

    git_directory = `git rev-parse --git-dir`.strip
    task :default => "#{git_directory}/hooks/pre-commit"
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
    | ../.git/modules/subproject/hooks/pre-commit |

   And the file "../.git/modules/subproject/hooks/pre-commit" should contain "My Hook"

Scenario: The pre-commit hook is modified
  When I append to "../.git/modules/subproject/hooks/pre-commit" with:
  """
  echo "My new hook!"
  """

  And I successfully run "rake"

  Then the file "../.git/modules/subproject/hooks/pre-commit" should not contain "echo"
