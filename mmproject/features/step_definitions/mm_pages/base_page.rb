# encoding: utf-8
require 'logger'

class BasePage

  def initialize(browser, host, locale)
    @browser = browser
    @host = host
    @locale = locale
    @options = EnvManager.instance.options
    @log = Logger.new(STDOUT)
    @log.level = Logger::DEBUG
  end

  def visit()
    path = self.path
    url = "#{@options[:protocol]}://#{@host}#{path}"
    @log.debug("Page URL: #{url}")
    @browser.goto url
  end
end


