require 'octokit'

module GHStats
  class Stats
    def initialize username, api: Octokit::Client
      @api = api
      @username = username
    end

    def most_common_language
      languages.uniq.max_by{ |l| languages.count(l) }
    end

    private

    def client
      @api.new(auto_paginate: true, per_page: 100)
    end

    def repos
      client.repos @username
    end

    def languages
      @languages ||= repos.map(&:language).compact
    end
  end
end
