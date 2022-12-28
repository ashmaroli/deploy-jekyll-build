# frozen_string_literal: true

require "jekyll"
require "safe_yaml"

build_opts = SafeYAML.load(ENV["BUILD_OPTS_YAML"]) if ENV["BUILD_OPTS_YAML"]
build_opts ||= {}

build_opts["source"]      = ENV["JEKYLL_SITE_SRC"]
build_opts["destination"] = if ENV["JEKYLL_SITE_DEST"].to_s.empty?
                              File.join(ENV["JEKYLL_SITE_SRC"], "_site")
                            else
                              ENV["JEKYLL_SITE_DEST"]
                            end
build_opts["trace"] = true

puts ""
Jekyll.logger.info ("-" * 80).center(80).cyan
Jekyll.logger.info "Jekyll #{Jekyll::VERSION}".center(80).cyan
Jekyll.logger.info ("-" * 80).center(80).cyan
puts ""

Jekyll::Commands::Build.process(build_opts)

puts ""
