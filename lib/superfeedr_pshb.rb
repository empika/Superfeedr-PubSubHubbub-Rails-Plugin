# SupperfeedrPshb
require 'httparty'

module SuperfeedrPshb
  class SuperfeedrPshb
    include HTTParty
    attr_accessor :hub, :auth, :callback_root
    base_uri nil
 
    def initialize(username, password, callback_root, hub = "http://superfeedr.com/hubbub")
      self.class.base_uri hub
      self.class.basic_auth username, password
      @auth = {:username => username, :password => password}
      @callback_root = callback_root
    end
    
    def create_and_send_request(type, mode_options)
      options = { :body => { 'hub.mode' => type, 'hub.verify' => "sync" } }
      options[:body].merge!(mode_options)
      puts options.inspect
      self.class.post('/', options)
    end

    def subscribe(callback, topic, token)
      options = {'hub.callback' => @callback_root + callback, 'hub.topic' => topic, 'hub.verify_token' => token}
      create_and_send_request("subscribe", options)
    end
    
    def unsubscribe(callback, topic, token)
      options = {'hub.callback' => @callback_root + callback, 'hub.topic' => topic, 'hub.verify_token' => token}
      create_and_send_request("unsubscribe", options)
    end
  
  end
  
end