class GastlyService

  FILE_EXTENSION = 'png'
  TIME_OUT = 2000

  def get_nl_nh (folder='public/files')

    Rails.logger.info 'Generating nl_nh image'

    image = capture_image 'http://stockcharts.com/h-sc/ui?s=$USHL5&p=D&yr=8&mn=0&dy=0&id=p27747499092',
                          '.chartImg-container'

    save_image_tmp_folder image, 'stockcharts.com-nh_nl', folder
  end

  def get_vix(folder='public/files')

    Rails.logger.info 'Generating vix image'

    image = capture_image 'http://www.investing.com/indices/volatility-s-p-500',
                          '#js_instrument_chart_wrapper'

    save_image_tmp_folder image, 'investing.vix-sp500', folder
  end

  private_methods

  def capture_image (url, selector)

    screenshot = Gastly.screenshot(url)
    screenshot.selector = selector
    screenshot.browser_width = 1280 # Default: 1440px
    screenshot.browser_height = 780 # Default: 900px
    screenshot.timeout = TIME_OUT # Default: 0 seconds
    screenshot.cookies = {user_id: 1, auth_token: 'abcd'} # If you need
    screenshot.phantomjs_options = '--ignore-ssl-errors=true'

    screenshot.capture
  end

  def save_image_tmp_folder(image, file_name, folder)

    file_path = Rails.root.join(folder, "#{file_name}."+FILE_EXTENSION)
    File.delete file_path if File.exist?(file_path)
    image.format(FILE_EXTENSION)
    image.save(file_path)

    "#{file_name}.#{FILE_EXTENSION}"
  end
end