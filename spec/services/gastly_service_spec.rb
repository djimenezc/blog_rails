require 'spec_helper'

require 'gastly'
require 'graphicsmagick'

describe ScreenScrapperService do

  it 'Take a page screenshot' do

    screenshot = Gastly.screenshot('http://google.com')
    screenshot.selector = '#hplogo' # By default, the full screen is captured
    screenshot.browser_width = 1280 # Default: 1440px
    screenshot.browser_height = 780 # Default: 900px
    screenshot.timeout = 1000 # Default: 0 seconds
    screenshot.cookies = { user_id: 1, auth_token: 'abcd' } # If you need
    screenshot.proxy_host = '10.10.10.1' # If you want to use a http proxy
    screenshot.proxy_port = '8080'
    screenshot.phantomjs_options = '--ignore-ssl-errors=true'
    image = screenshot.capture

    image.resize(width: 110, height: 110) # Creates a previews of web-page
    image.format('png')
    image.save(TMP_DIRECTORY + 'googleLogo.png')
  end

  it 'Take a page screenshot stockcharts.com-ushl.jpg' do

    screenshot = Gastly.screenshot('http://stockcharts.com/h-sc/ui?s=$USHL5&p=D&yr=8&mn=0&dy=0&id=p27747499092')
    screenshot.selector = '.chartImg-container' # By default, the full screen is captured
    screenshot.browser_width = 1280 # Default: 1440px
    screenshot.browser_height = 780 # Default: 900px
    screenshot.timeout = 1000 # Default: 0 seconds
    screenshot.cookies = { user_id: 1, auth_token: 'abcd' } # If you need
    screenshot.phantomjs_options = '--ignore-ssl-errors=true'
    image = screenshot.capture

    image.format('png')
    image.save(TMP_DIRECTORY + 'stockcharts.com-ushl.png')
  end

end
