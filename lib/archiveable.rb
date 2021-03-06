$:.push File.expand_path('../', __FILE__)
require "active_support/all"
require "archiveable/version"

module Archiveable
  extend ActiveSupport::Concern

  included do
    scope :published, -> { where archived_at: nil }
    scope :archived, -> { where.not archived_at: nil }
  end

  def published
    !archived
  end

  def published=(value)
    self.archived = !bool(value)
  end

  def archived
    archived_at.present?
  end

  def archived=(value)
    self.archived_at = bool(value) ? Time.now : nil
  end

  def archive
    update archived: true
  end

  def archive!
    update! archived: true
  end

  def publish
    update archived: false
  end

  def publish!
    update! archived: false
  end

  private

  def bool(value)
    not ["false", "0", ""].include? value.to_s.downcase
  end
end
