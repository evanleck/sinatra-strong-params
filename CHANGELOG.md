# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2019-01-27

### Added
- Now you don't need to explicitly allow the needed params anymore when using `needs` and `allows` combined.

### Changed
- The error message for missing needed params now includes a list of the missing ones.

### Fixed
- When using `allows`, the params hash keys was changing from string to symbol.

## [0.0.3] - 2017-01-30

### Added
- Gem test setup and basic tests.

## [0.0.2] - 2015-11-12

### Added
- Accept `missing_parameter_message` configuration for missing needed params error message.

## [0.0.1] - 2014-07-12

### Added
- Gem created.
