class Configuration
  class << self
    attr_accessor :app_version
  end
  @app_version = '1.0.1'
  @git_version = `git show --pretty=%H`[0..39]

  def version
    "#{@app_version}-#{@git_version}"
  end
end