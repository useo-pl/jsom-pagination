# frozen_string_literal: true

require_relative 'lib/jsom/pagination/version'

# rubocop:disable Metrics/BlockLength
#
Gem::Specification.new do |spec|
  spec.name = 'jsom-pagination'
  spec.version = JSOM::Pagination::VERSION
  spec.authors = ['Sebastian Wilgosz']
  spec.email = ['sebastian@driggl.com']

  spec.summary = 'A pagination support for JSON:API based web applications.'
  spec.description = <<-STRING
    Easy to use, framework-agnostic set of methods useful for
    integrating JSON:API in your project.
  STRING
  spec.homepage = 'https://github.com/useo-pl/jsom-pagination'
  spec.license = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/useo-pl/jsom-pagination'
  spec.metadata['changelog_uri'] = 'https://github.com/useo-pl/jsom-pagination/releases'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem
  # that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features|Gemfile\.lock)/?})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'dry-struct', '~>1.3'
  spec.add_dependency 'pagy', '~>4.0'
  spec.add_dependency 'rack'
  spec.add_dependency 'addressable', '~> 2.3', '>= 2.3.7'

  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-cobertura'
end
# rubocop:enable Metrics/BlockLength
