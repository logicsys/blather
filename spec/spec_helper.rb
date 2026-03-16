require 'blather'
require 'countdownlatch'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :mocha
  config.filter_run_when_matching :focus

  config.before(:each) do
    EM.stubs(:schedule).yields
    EM.stubs(:defer).yields
    Blather::Stream::Parser.debug = true
    Blather.logger = Logger.new($stdout).tap { |logger| logger.level = Logger::DEBUG }
  end
end

def parse_stanza(xml)
  Nokogiri::XML.parse xml
end

def jruby?
  RUBY_PLATFORM =~ /java/
end
