# frozen_string_literal: true

require 'simplecov'
require 'simplecov-cobertura'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
                                                                 SimpleCov::Formatter::HTMLFormatter,
                                                                 SimpleCov::Formatter::CoberturaFormatter # Para GitHub
                                                               ])

SimpleCov.start do
  # Configuración básica
  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/vendor/'
  add_filter '/bin/'

  # Grupos de cobertura
  add_group 'Models', 'app/models'
  add_group 'Controllers', 'app/controllers'
  add_group 'Domain', 'app/domain'
  add_group 'Services', 'app/services'

  # Configuración de formato
  if ENV['CI']
    # En CI, solo usar Cobertura
    SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
  end

  # Cobertura mínima (opcional)
  minimum_coverage 95 if ENV['CI']
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = 'spec/examples.txt'
  config.disable_monkey_patching!
  config.warnings = true

  config.default_formatter = 'doc' if config.files_to_run.one?
  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed
end
