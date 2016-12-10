class GastlyService

  FILE_EXTENSION = 'png'

  def get_nl_nh

    Rails.logger.info 'Generating nl_nh image'

    screenshot = Gastly.screenshot('http://stockcharts.com/h-sc/ui?s=$USHL5&p=D&yr=8&mn=0&dy=0&id=p27747499092')
    screenshot.selector = '.chartImg-container' # By default, the full screen is captured
    screenshot.browser_width = 1280 # Default: 1440px
    screenshot.browser_height = 780 # Default: 900px
    screenshot.timeout = 1000 # Default: 0 seconds
    screenshot.cookies = {user_id: 1, auth_token: 'abcd'} # If you need
    screenshot.phantomjs_options = '--ignore-ssl-errors=true'
    image = screenshot.capture

    save_image_tmp_folder image, 'stockcharts.com-nh_nl'
  end

  def save_image_tmp_folder(image, file_name)

    file_path = Rails.root.join('public/files', "#{file_name}."+FILE_EXTENSION)
    File.delete file_path if File.exist?(file_path)
    image.format(FILE_EXTENSION)
    image.save(file_path)

    "#{file_name}.#{FILE_EXTENSION}"
  end
end