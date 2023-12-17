module NameCleanup
  def self.clean(name)
    name
      .downcase
      .gsub(/[_ ]/, '-')
      .gsub(/[^-a-z0-9+]/, '')
      .gsub(/-{2,}/, '-')
      .gsub(/^-/, '')
      .chomp('-')
  end
end
