class Configuration
  class << self
    attr_accessor :app_version, :git_version
  end
  @app_version = '1.0.3'
  @git_version = `git show --pretty=%H`[0..39]

end