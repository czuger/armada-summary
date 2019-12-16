require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: #{__FILE__} [options]'

  opts.on('-f', '--french', 'French version') do |f|
    options[:french] = f
  end
end.parse!

I18n.locale = options[:french] ? :fr : :en