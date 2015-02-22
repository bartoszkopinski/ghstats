require "ostruct"
require "spec_helper"
require "ghstats/stats"

module GHStats
  class DummyAPIClient
    REPOS = {
      "rubyist" => %w{Ruby JavaScript PHP Ruby},
      "inactive" => [],
      "unknown" => [nil, nil, "C++"],
      "mixed" => ["Swift", "Swift", "Objective-C", "Objective-C"],
    }

    def initialize(*); end

    def repos(username)
      REPOS[username].map do |l|
        OpenStruct.new(language: l)
      end
    end
  end

  describe Stats do
    describe "#most_common_language" do
      context "for a user with Ruby repos" do
        subject { described_class.new("rubyist", api: DummyAPIClient) }

        it "returns Ruby as the most common language" do
          expect(subject.most_common_language).to eq("Ruby")
        end
      end

      context "for a user with no repos" do
        subject { described_class.new("inactive", api: DummyAPIClient) }

        it "returns nil as the most common language" do
          expect(subject.most_common_language).to be_nil
        end
      end

      context "for a user with many unrecognized repos" do
        subject { described_class.new("unknown", api: DummyAPIClient) }

        it "ignores unknown languages" do
          expect(subject.most_common_language).to eq("C++")
        end
      end

      context "for a user with more than one most common language" do
        subject { described_class.new("mixed", api: DummyAPIClient) }

        it "returns the most recent language" do
          expect(subject.most_common_language).to eq("Swift")
        end
      end
    end
  end
end
