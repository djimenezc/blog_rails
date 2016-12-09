require 'log4r'

# outputter = Log4r::FileOutputter.new('log4r', :filename => 'foobar.log')
# outputter.formatter = Log4r::PatternFormatter.new(
#     :date_pattern => '%FT%T.000Z',
#     :pattern      => '%d [%l] %m'
# )
#
# logger = Log4r::Logger.new('log4r')
# logger.outputters = [outputter]

Rails.logger = Logger.new(STDOUT)
# Rails.logger = Log4r::Logger.new('Application Log')

Rails.logger.level = 0

Rails.logger.info 'logger enabled'