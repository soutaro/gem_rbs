# Write Ruby code to test the RBS.
# It is type checked by `steep check` command.

require "activerecord"

module Test
  class ApplicationRecord < ActiveRecord::Base
    primary_abstract_class
  end

  class User < ApplicationRecord
    # @dynamic articles
    has_many :articles

    enum status: { active: 0, inactive: 1 }, _suffix: true
    enum :role, { admin: 0, user: 1 }, _prefix: true
    enum :classify, %w[hoge fuga], _default: "hoge"
    enum :hoge, fuga: 0, piyo: 1

    encrypts :secret, :key
    encrypts :token, deterministic: true
    encrypts :phrase, ignore_case: true
  end

  class Article < ActiveRecord::Base
  end

  User.where.missing.to_sql
  User.where(role: :admin).load_async
  User.deterministic_encrypted_attributes
  User.source_attribute_from_preserved_attribute(:phrase)
  User.insert({ id: 1, name: 'James' }, returning: %i[id name], unique_by: :id, record_timestamps: true)
  User.insert!({ id: 1, name: 'James' }, returning: %i[id name], record_timestamps: true)
  User.insert_all([{ id: 1, name: 'James' }], returning: %i[id name], unique_by: :id, record_timestamps: true)
  User.insert_all!([{ id: 1, name: 'James' }], returning: %i[id name], record_timestamps: true)
  User.upsert({ id: 1, name: 'James' }, returning: %i[id name], unique_by: :id, record_timestamps: true)
  User.upsert_all([{ id: 1, name: 'James' }], returning: %i[id name], unique_by: :id, record_timestamps: true)
  User.strict_loading
  User.strict_loading(false)
  User.create_with(name: 'name', age: 1)
  User.create_with(nil)
  user = User.new(secret: 'dummy', key: 'dummy', token: 'dummy', phrase: 'dummy')
  user.encrypt
  user.encrypted_attribute?(:secret)
  user.decrypt
  user.ciphertext_for(:token)
  user.articles.insert({ id: 1, name: 'James' }, returning: %i[id name], unique_by: :id, record_timestamps: true)
  user.articles.insert!({ id: 1, name: 'James' }, returning: %i[id name], record_timestamps: true)
  user.articles.insert_all([{ id: 1, name: 'James' }], returning: %i[id name], unique_by: :id, record_timestamps: true)
  user.articles.insert_all!([{ id: 1, name: 'James' }], returning: %i[id name], record_timestamps: true)
  user.articles.upsert({ id: 1, name: 'James' }, returning: %i[id name], unique_by: :id, record_timestamps: true)
  user.articles.upsert_all([{ id: 1, name: 'James' }], returning: %i[id name], unique_by: :id, record_timestamps: true)
  user.values_at(:name, :age)
  user.values_at("name", :age)
  user.strict_loading!
  user.strict_loading!(false, mode: :n_plus_one_only)
  user.strict_loading?
end
