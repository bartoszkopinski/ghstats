require "spec_helper"
require "ghstats/cli"

module GHStats
  describe CLI do
    describe ".start" do
      subject{ described_class.start(@username) }

      context "with invalid args" do
        after do
          expect{ subject }.to raise_error(RuntimeError)
        end

        it "raises an exception for empty args" do
          @username = []
        end

        it "raises an exception for an empty username" do
          @username = [nil]
        end

        it "raises an exception for a blank username" do
          @username = ""
        end
      end

      context "with a valid username" do
        before do
          @username = "username"
        end

        it "returns the most common language for a user" do
          expect(Stats).to receive(:new).and_return(double(most_common_language: "Ruby"))
          expect(subject).to eq("Ruby")
        end

        it "returns a message when the most common language language is unknown" do
          expect(Stats).to receive(:new).and_return(double(most_common_language: nil))
          expect(subject).to eq("Unknown language")
        end
      end
    end
  end
end
