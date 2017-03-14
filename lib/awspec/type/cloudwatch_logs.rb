module Awspec::Type
  class CloudwatchLogs < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_cloudwatch_logs_group(@display_name)
    end

    def id
      @id ||= resource_via_client.log_group_name if resource_via_client
    end

    def has_log_stream?(stream_name)
      ret = find_cloudwatch_logs_stream_by_log_group_name(@id).log_stream_name
      return true if ret == stream_name
    end

    def has_metric_filter?(filter_name)
      ret = find_cloudwatch_logs_metric_fileter_by_log_group_name(@id, filter_name).filter_name
      return true if ret == filter_name
    end

    def has_subscription_filter?(filter_name, pattern = nil)
      ret = find_cloudwatch_logs_subscription_fileter_by_log_group_name(@id, filter_name)
      return false unless ret.filter_pattern == pattern
      return true if ret.filter_name == filter_name
    end
  end
end
