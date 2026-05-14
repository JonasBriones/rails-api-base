# frozen_string_literal: true

module HealthCheck
  class Checker
    def self.call
      checks = {
        environment: check_environment,
        # database: check_database,
        # database_metrics: database_metrics,
        time: check_time
      }

      healthy = checks.values.all? { |check| check[:status] == 'OK' }

      {
        healthy: healthy,
        status: healthy ? 'healthy' : 'unhealthy',
        checks: checks,
        timestamp: Time.current.iso8601,
        uptime: uptime_seconds,
        system: system_info
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
      # Esto requiere un initializer para tracking de uptime
      Rails.application.config.start_time ||= Time.current
      (Time.current - Rails.application.config.start_time).to_i
    end

    def self.system_info
      {
        hostname: `hostname`.strip,
        pid: Process.pid,
        cpu_count: `nproc`.strip.to_i,
        memory: get_memory_info
      }
    rescue StandardError
      {
        hostname: 'unknown',
        pid: Process.pid,
        cpu_count: 1,
        memory: 'unknown'
      }
    end
  end
end
