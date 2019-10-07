require 'singleton'
require 'logger'
require 'webdriver-user-agent'
require 'rspec/autorun' # needs to be explicitly required for rspec > 2.5
#require '../support/spec_helper'


class EnvManager
	include Singleton

	def initialize
		@log = Logger.new(STDOUT)
		@log.level = Logger::INFO
	end

	attr_reader :options
	attr_reader :test_name

	def setup_environment
		@options = Hash[]

		#Default options
		@options[:browser] = :chrome
		@options[:host]="exercise1.com"
		@options[:locale]=:en
		@options[:currency]="USD"
		@options[:currency]="$"
		#@options[:load_path] = ".,../support/test_context,../support/utilities,../../features/step_definitions/,../../features/step_definitions/mm_pages/"
		@options[:protocol] = "https"
		@options[:failures_file_name] = "failures"

		# load_path = @options[:load_path]
		# load_path.split(",").each  do |path|
		# 	@log.debug("Adding #{path} to Load Path")
		# 	$LOAD_PATH << path
		# end
	end

end
