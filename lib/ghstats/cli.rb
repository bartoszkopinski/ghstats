require "ghstats/stats"

module GHStats
  class CLI
    def self.start args
      username, _ = *args

      if username.to_s.empty?
        fail("Usage: ghstats <username>")
      end

      Stats.new(username).most_common_language || "Unknown language"
    end
  end
end
