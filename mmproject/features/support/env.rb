require 'rubygems'
require 'rspec/autorun' # needs to be explicitly required for rspec > 2.5
require 'monetize'
require 'watir'

require_relative './env_manager'
require_relative  './test_context'
require_relative  './utilities'
require_relative  '../../features/step_definitions/mm_pages/base_page'
require_relative  '../../features/step_definitions/mm_pages/mass_mutual_page'

#To Do add path in load path
#$LOAD_PATH << '.'
# $:.unshift File.dirname(__FILE__)
# #

EnvManager.instance.setup_environment
#
Before do
  EnvManager.instance.setup_environment
  @options = EnvManager.instance.options
  @browser = TestContext.instance.browser(true)
  @page = MassMutualPage.new(@browser, @options[:host], @options[:locale], @options[:currency],@options[:Symbol])
  @utils = Utilities.new(@browser)
  @browser.driver.manage.window.maximize
  @text_field_1_monetized_value = Monetize.parse("$122,365.24")
  @text_field_2_monetized_value = Monetize.parse("$599.00")
  @text_field_3_monetized_value = Monetize.parse("$850,1399.99")
  @text_field_4_monetized_value = Monetize.parse("$23,329.50")
  @text_field_5_monetized_value = Monetize.parse("$566.27")
  @total_bal_monetized_value = Monetize.parse("$1000,000.00")
  @total_bal_calculated_value = Monetize.parse("$122,365.24")+Monetize.parse("$599.00")+Monetize.parse("$850,1399.99")+Monetize.parse("$23,329.50")+Monetize.parse("$566.27")
end

After do
  @browser.close
end