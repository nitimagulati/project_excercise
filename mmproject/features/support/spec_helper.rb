# For rspec configuration.
RSpec.configure do |config|

  # Keeps track of failed scripts in order to rerun them at the end.
  # config.after :each do
  #   if example.failed?
  #     open("#{@options[:failures_file_name]}", "a") { |f| f << "#{EnvManager.instance.test_name} " }
  #   end
  # end

  config.mock_with :rspec do |mocks|
    mocks.syntax = [:should, :expect]
  end
end

#--------------------------------------
# RSpec::Core::Example extensions
#--------------------------------------
class RSpec::Core::Example
  def passed?
    @exception.nil?
  end

  def failed?
    !passed?
  end
end
