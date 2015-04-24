require_relative "../newrelic"

if Rory::NewRelic.instance.environments.include? ENV['RORY_ENV']
  require 'better_newrelic_sql_obfuscator'
  whitelisted_fields = %w[
    clients.identifier
  ]
  whitelisted_fields.each { |field| BetterNewrelicSqlObfuscator.whitelist(field) }

  BetterNewrelicSqlObfuscator.dont_obfuscate_table_and_field do |table, field|
    %w[created_at updated_at].include?(field)
  end

  NewRelic::Agent.set_sql_obfuscator(:replace) do |sql|
    BetterNewrelicSqlObfuscator.obfuscate(sql)
  end
end

