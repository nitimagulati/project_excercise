require 'singleton'
require 'webdriver-user-agent'
require 'selenium-webdriver'
require 'fileutils'
require_relative './env_manager'
require_relative './utilities'


class TestContext
  include Singleton

  @@browser = nil

  def browser(force_new = false)
    begin
      if force_new || !@@browser
        begin
          @@browser = Watir::Browser.new(EnvManager.instance.options[:browser])
          @@browser.window.move_to(0, 0)
        end
        # just to make sure the browser doesn't end up with a tiny window
        if @@browser.window.size[:width] < 1200
          @@browser.window.resize_to(1200, @@browser.window.size[:height])
        end
        if @@browser.window.size[:height] < 800
          @@browser.window.resize_to(@@browser.window.size[:width], 800)
        end
      end
      return @@browser
    end
  end

end