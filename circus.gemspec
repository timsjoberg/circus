# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{circus}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tim Sjoberg"]
  s.date = %q{2010-07-01}
  s.description = %q{A relatively simple event driven irc gem without a DSL or any EOF magick}
  s.email = %q{bedlamp@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "circus.gemspec",
     "lib/circus.rb",
     "lib/irc.rb",
     "lib/irc/commands.rb",
     "lib/irc/connection.rb",
     "lib/irc/errors.rb",
     "lib/irc/event_manager.rb",
     "lib/irc/messages/action.rb",
     "lib/irc/messages/ctcp.rb",
     "lib/irc/messages/ctcp_reply.rb",
     "lib/irc/messages/join.rb",
     "lib/irc/messages/kick.rb",
     "lib/irc/messages/mode.rb",
     "lib/irc/messages/nick.rb",
     "lib/irc/messages/notice.rb",
     "lib/irc/messages/part.rb",
     "lib/irc/messages/pass.rb",
     "lib/irc/messages/pong.rb",
     "lib/irc/messages/privmsg.rb",
     "lib/irc/messages/quit.rb",
     "lib/irc/messages/raw.rb",
     "lib/irc/messages/topic.rb",
     "lib/irc/messages/user.rb",
     "lib/irc/parser.rb",
     "spec/circus_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/timsjoberg/circus}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A relatively simple event driven irc gem}
  s.test_files = [
    "spec/circus_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.5"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<activesupport>, [">= 2.3.5"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<activesupport>, [">= 2.3.5"])
  end
end

