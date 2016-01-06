require 'twilio-ruby'
require 'pry'

#staging_client = Twilio::REST::Client.new(ENV['TWILIO_BALANCE_STAGING_SID'], ENV['TWILIO_BALANCE_STAGING_AUTH'])
production_client = Twilio::REST::Client.new(ENV['TWILIO_BALANCE_PROD_SID'], ENV['TWILIO_BALANCE_PROD_AUTH'])

require File.expand_path("../lib/dollar_amounts_processor", __FILE__)

transcriptions = Array.new
t = production_client.account.transcriptions.list
5.times do
  t.each { |tran| transcriptions << tran }
  t = t.next_page
end

transcriptions.each do |trans|
  puts ""
  puts ""
  puts trans.transcription_text
  puts ""
  puts DollarAmountsProcessor.new.process(trans.transcription_text)
  puts ""
  puts ""
end

binding.pry

