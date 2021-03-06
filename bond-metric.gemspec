# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: bond-metric 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "bond-metric"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Lukas Beaton"]
  s.date = "2016-10-08"
  s.description = "A set of functions for calculating bond benchmarks. The current benchmarks that are supported are \"Spread to Benchmark\" and \"Spread to Curve\"."
  s.email = "lukas.beaton@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.markdown"
  ]
  s.files = [
    ".document",
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.markdown",
    "Rakefile",
    "VERSION",
    "bond-metric.gemspec",
    "lib/bond_metric.rb",
    "lib/factory/bond.rb",
    "lib/service/benchmark.rb",
    "lib/service/report.rb",
    "lib/struct/bond.rb",
    "lib/struct/spread_to_benchmark.rb",
    "lib/struct/spread_to_curve.rb",
    "spec/fixtures/bonds_bad.csv",
    "spec/fixtures/bonds_good.csv",
    "spec/integration/service/report_spec.rb",
    "spec/spec_helper.rb",
    "spec/unit/bond_metric_spec.rb",
    "spec/unit/factory/bond_spec.rb",
    "spec/unit/service/benchmark_spec.rb",
    "spec/unit/struct/bond_spec.rb"
  ]
  s.homepage = "http://github.com/LukasBeaton/bond-metric"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5"
  s.summary = "A set of functions for calculating bond benchmarks."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["= 2.14.0"])
      s.add_development_dependency(%q<byebug>, ["= 9.0.6"])
      s.add_development_dependency(%q<coveralls>, ["= 0.8.15"])
      s.add_development_dependency(%q<rdoc>, ["= 3.12.2"])
      s.add_development_dependency(%q<jeweler>, ["= 2.0.1"])
      s.add_development_dependency(%q<simplecov>, ["= 0.12.0"])
    else
      s.add_dependency(%q<rspec>, ["= 2.14.0"])
      s.add_dependency(%q<byebug>, ["= 9.0.6"])
      s.add_dependency(%q<coveralls>, ["= 0.8.15"])
      s.add_dependency(%q<rdoc>, ["= 3.12.2"])
      s.add_dependency(%q<jeweler>, ["= 2.0.1"])
      s.add_dependency(%q<simplecov>, ["= 0.12.0"])
    end
  else
    s.add_dependency(%q<rspec>, ["= 2.14.0"])
    s.add_dependency(%q<byebug>, ["= 9.0.6"])
    s.add_dependency(%q<coveralls>, ["= 0.8.15"])
    s.add_dependency(%q<rdoc>, ["= 3.12.2"])
    s.add_dependency(%q<jeweler>, ["= 2.0.1"])
    s.add_dependency(%q<simplecov>, ["= 0.12.0"])
  end
end

