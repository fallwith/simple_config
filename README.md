# SimpleConfig

SimpleConfig is a simple utility that processes key/value based configuration
files in order to produce a Ruby key/value structure.

This project is for demonstration purposes only and should not be used in
production. Use YAML or a utility such as [SettingsLogic](https://github.com/binarylogic/settingslogic)
instead.

## Usage

Given the following config file:

  ```
  # Credentials
  # user = calvin
  # password = hobbes
  ```

Use SimpleConfig.load_file to produce a Ruby struct:

  ```ruby
  config = SimpleConfig.load_file("/path/to/config_file")
  config.user      # => "calvin"
  config.password  # => "hobbes"
  ```

Alternatively, use SimpleConfig.load to read in a string:

  ```ruby
  config = SimpleConfig.load("tatooine = womp rats\nhoth = tauntaun")
  config.tatooine  # => "womp rats"
  config.hoth      # => "tauntaun"
  ```

## Settings

SimpleConfig can itself be configured via SimpleConfig::SETTINGS.

Currently the only supported setting is the delimiter used to separate
items in a key/value pair.

  ```ruby
  SimpleConfig::SETTINGS.delimiter = ':'
  config = SimpleConfig.load("neo : trinity")
  config.neo  # => "trinity"
  ```

## Configuration File Syntax Rules

1. Comment lines begin with '#'. Inline comments are not supported.
2. There must be at least one space character on both sides of the delimiter
   that separates the key/value pair.

## Developing SimpleConfig

RVM users can make use of the project .rvmrc file.

rbenv and other non-RVM users can make use of the project .ruby-version file
and the bin/setup script.

The included spec tests can be launched via bin/test or simply "rake" with no
arguments.

