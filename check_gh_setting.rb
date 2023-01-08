# frozen_string_literal: true

require "json"

response = JSON.parse(ARGV.join)
build_type = response["build_type"]
branch, path = response["source"].values_at("branch", "path")

if build_type == "legacy" && branch == "gh-pages" && path == "/"
  exit 0
else
  path = "/(root)" if path == "/"
  puts "::error::Incorrect GitHub Pages setting! Use `gh-pages /(root)` instead of `#{branch} #{path}`."
  exit 1
end
