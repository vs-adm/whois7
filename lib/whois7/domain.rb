# encoding: utf-8
require 'ostruct'

module Whois7
  class Domain
    def initialize(fqdn)
      @fqdn = fqdn
    end

    def available?
      data['available'] == 'yes'
    end

    private

    def data
      @data ||= Api::Client.fqdn_get(@fqdn)
    end
  end
end
