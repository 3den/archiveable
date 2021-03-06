require_relative "../test_helper"

describe Archiveable do
  class MockModel < MiniTest::Mock
    def self.scopes
      @scopes
    end

    def self.scope(name, callback)
      @scopes ||= {}
      @scopes[name] = callback
    end

    attr_accessor :archived_at
    include Archiveable
  end

  subject { MockModel.new }

  describe ".included" do
    it "sets the published and archived scopes" do
      MockModel.scopes.keys.must_equal [:published, :archived]
    end
  end

  describe ".archived" do
    it "returns true when there is an archived_at date" do
      subject.archived_at = Time.now
      subject.archived.must_equal true
    end

    it "returns false when there is not an archived_at date" do
      subject.archived_at = nil
      subject.archived.must_equal false
    end

    it "sets the archived_at when archived is set to true" do
      Time.stub :now, Time.now do
        subject.archived = true
        subject.archived_at.must_equal Time.now
      end
    end

    it "unsets the archived_at when archived is set to false" do
      subject.archived_at = Time.now
      subject.archived = false
      subject.archived_at.must_equal nil
    end

    it "unsets the archived_at when archived is set to 0" do
      subject.archived_at = Time.now
      subject.archived = 0
      subject.archived_at.must_equal nil
    end
  end

  describe ".published" do
    it "returns true when it is not archived" do
      subject.archived = false
      subject.published.must_equal true
    end

    it "returns false when it is archived" do
      subject.archived = true
      subject.published.must_equal false
    end

    it "sets the archived to false when published is true" do
      subject.published = true
      subject.archived.must_equal false
    end
  end

  describe "#archive" do
    it "updates the archived to true" do
      subject.expect :update, true, [{archived: true}]
      subject.archive
      subject.verify
    end
  end

  describe "#archive!" do
    it "updates the archived to true" do
      subject.expect :update!, true, [{archived: true}]
      subject.archive!
      subject.verify
    end
  end

  describe "#publish" do
    it "updates the archived to false" do
      subject.expect :update, true, [{archived: false}]
      subject.publish
      subject.verify
    end
  end

  describe "#publish!" do
    it "updates the archived to false" do
      subject.expect :update!, true, [{archived: false}]
      subject.publish!
      subject.verify
    end
  end
end
