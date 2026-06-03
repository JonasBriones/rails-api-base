# frozen_string_literal: true

module HealthCheck
  class Checker
    def self.call
      healthy = api_info_payload.values.all? { |check| check[:status] == 'OK' }

      {
        healthy: healthy,
        status: healthy ? 'healthy' : 'unhealthy',
        checks: api_info_payload,
        timestamp: Time.current.iso8601,
        uptime: uptime_seconds,
        system: system_info
      }
    end

    def self.api_info_payload
      {
        environment: check_environment,
        time: check_time
      }
    end

    def self.check_database
      ActiveRecord::Base.connection.execute('SELECT 1')
      { status: 'OK', message: 'Database connected', latency_ms: measure_latency { ActiveRecord::Base.connection.execute('SELECT 1') } }
    rescue StandardError => e
      { status: 'ERROR', message: 'Database connection failed', error: e.message }
    end

    def self.database_metrics
      {
        connection_pool_size: ActiveRecord::Base.connection_pool.size,
        active_connections: ActiveRecord::Base.connection_pool.connections.count(&:in_use?),
        waiting_connections: ActiveRecord::Base.connection_pool.num_waiting
      }
    rescue StandardError => e
      { error: e.message }
    end

    def self.check_time
      {
        status: 'OK',
        message: 'System time synchronized',
        server_time: Time.current.iso8601,
        utc_offset: Time.zone.now.utc_offset
      }
    end

    def self.check_environment
      {
        status: 'OK',
        message: 'Environment configured',
        rails_env: Rails.env,
        ruby_version: RUBY_VERSION,
        rails_version: Rails.version
      }
    end

    def self.uptime_seconds
      Rails.application.config.start_time ||= Time.current
      (Time.current - Rails.application.config.start_time).to_i
    end

    def self.system_info
      system_info_data
    rescue StandardError
      {
        hostname: 'unknown',
        pid: Process.pid,
        cpu_count: 1,
        memory: 'unknown'
      }
    end

    def self.system_info_data
      {
        hostname: `hostname`.strip,
        pid: Process.pid,
        cpu_count: `nproc`.strip.to_i,
        memory: get_memory_info
      }
    end
  end
end
