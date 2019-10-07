require 'logger'

class Utilities

  def initialize(browser)
    @browser = browser
    @log = Logger.new(STDOUT)
    @log.level = Logger::DEBUG
  end

  def log(info)
    @log.debug(info)
  end

end

