# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ActiveRecord::Base.logger = Logger.new(STDOUT)
require 'json'
require 'uri'

def get_json(url)
  uri = URI.parse(url)
  port = ":#{uri.port}" unless [80, 443].include?(uri.port)
  url_root = "#{uri.scheme}://#{uri.host}#{port}"
  url_path = uri.path
  connection = Faraday.new url_root do |conn|
    conn.use FaradayMiddleware::FollowRedirects
    conn.adapter :net_http
  end
  response = connection.get url_path do |request|
    request.options.timeout = 240
  end
  JSON.parse(response.body)
end

#
# admins seeds
#
# https://docs.google.com/spreadsheets/d/1-PcMltAi7xzzYOzoRHbpX2_1WvdGwkTqqrfd1nlIeyk/edit?usp=sharing
json_data = get_json('https://script.google.com/macros/s/AKfycbx0sCUbV0eW-jvSPA-VKGH75ZT68JsD2Cy81bpy5zMqgQbsnOI5hNBuAAvEcSflGhW3hg/exec')

records = []
json_data['tables']['app_configs'].each do |row|
    records << AppConfig.new(
        id: row['id'],
        title: row['title'],
        description: row['description'],
        key: row['key'],
        value: row['value'],
    )
end
AppConfig.import records

records = []
json_data['tables']['pwned_tags'].each do |row|
    records << PwnedTag.new(
        id: row['id'],
        name: row['name'],
        description: row['description'],
    )
end
PwnedTag.import records

records = []
json_data['tables']['pwneds'].each do |row|
    records << Pwned.new(
        id: row['id'],
        password: row['password'],
        password_sha256: Digest::SHA256.hexdigest(row['password']),
        pwned_tag_id: row['pwned_tag_id'],
    )
end
Pwned.import records

json_data['tables']['admins'].each do |row|
    record = Admin.new(
        id: row['id'],
        status: row['status'],
        email: row['email'],
        password: row['password'],
        password_confirmation: row['password'],
        discarded_at: row['discarded_at'],
    )
    record.save!
end


### ダミーデータ
### ユーザー作成
Account.sorcery_config.activation_mailer_disabled = true
Account.sorcery_config.reset_password_mailer_disabled = true
json_data['tables']['accounts'].each do |row|
    record = Account.new(
        id: row['id'],
        email: row['email'],
        password: row['password'],
        password_confirmation: row['password'],
        status: row['status'],
        activation_state: row['activation_state'],
    )
    record.save!
end
