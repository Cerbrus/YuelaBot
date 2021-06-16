BOT = Discordrb::Commands::CommandBot.new(
  token: ENV['DISCORD'],
  prefix: ->(message) do
    next unless message&.server
    prefix = ServerPrefix.where(server: message.server.id).first_or_create do |p|
      p.prefix = "!!"
    end
    message.content[prefix.prefix.size..-1] if message.content.start_with?(prefix.prefix)
  end,
  log_level: :debug,
  parse_self: true
)