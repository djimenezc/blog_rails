require 'spec_helper'

require 'gastly'
require 'graphicsmagick'

require 'timeout'

number_times = 5

describe GastlyService do

  before do
    Rails.logger.info 'Before, starting gastly service'
    @screenshot_service = GastlyService.new
    Rails.logger.info 'cleaning tmp'
    system("rm #{TMP_DIRECTORY}*.png")
    system("rm #{TMP_DIRECTORY}*.jpg")
  end

  before(:each) do
    kill_process
  end

  # it 'Take a page screenshot stockcharts.com-ushl.jpg service' do
  #
  #   file_path = "#{TMP_DIRECTORY}/#{@screenshot_service.get_nl_nh TMP_DIRECTORY}"
  #
  #   assert File.exist? file_path
  # end
  #
  # it 'Take a page screenshot investing vix' do
  #
  #   Rails.logger.info 'Vix asdasdas'
  #   file_path = "#{TMP_DIRECTORY}/#{@screenshot_service.get_vix TMP_DIRECTORY}"
  #
  #   assert File.exist? file_path
  # end

  it 'Take a page screenshot' do

    number_times.times { |i|
      Rails.logger.info("Take a screenshot of google logo #{i}")
      screenshot = Gastly.screenshot('http://google.com')
      screenshot.selector = '#hplogo' # By default, the full screen is captured
      screenshot.browser_width = 1280 # Default: 1440px
      screenshot.browser_height = 780 # Default: 900px
      screenshot.timeout = 1000 # Default: 0 seconds
      screenshot.cookies = {user_id: 1, auth_token: 'abcd'} # If you need
      screenshot.proxy_host = '10.10.10.1' # If you want to use a http proxy
      screenshot.proxy_port = '8080'
      screenshot.phantomjs_options = '--ignore-ssl-errors=true'
      image = screenshot.capture

      image.resize(width: 110, height: 110) # Creates a previews of web-page
      image.format('png')
      image.save("#{TMP_DIRECTORY}googleLogo-#{i}.png")

      assert File.exist? "#{TMP_DIRECTORY}googleLogo-#{i}.png"
    }
  end

  it 'Take a page screenshot stockcharts.com-ushl.jpg example' do

    begin
      Timeout::timeout(15) do
        2.times { |i|
          Rails.logger.info("Take a page screenshot stockcharts.com-ushl.jpg #{i}")
          screenshot = Gastly.screenshot('http://stockcharts.com/h-sc/ui?s=$USHL5&p=D&yr=8&mn=0&dy=0&id=p27747499092')
          screenshot.selector = '.chartImg-container' # By default, the full screen is captured
          screenshot.phantomjs_options = '--ignore-ssl-errors=true'
          image = screenshot.capture

          Rails.logger.info("After capture screenshot stockcharts.com-ushl.jpg #{i}")
          image.format('png')
          file_path = "#{TMP_DIRECTORY}stockcharts.com-ushl#{i}.png"
          image.save(file_path)
          Rails.logger.info("Save screenshot stockcharts.com-ushl.jpg #{i}")

          assert File.exist? file_path
        }
      end
    rescue Timeout::Error
      puts 'process not finished in time, killing it'
      Process.kill('TERM', pid)
    end
  end

  private_methods

  def kill_process
    Rails.logger.info 'killing gastly/script.js processes'
    system 'pkill -9 phantomjs'
  end

end
