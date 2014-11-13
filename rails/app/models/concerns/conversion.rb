module Conversion
  extend ActiveSupport::Concern

  module ClassMethods
    def normalize_type(ctype)
      case ctype
      when /run|jog/i
        'running'
      when /swim/i
        'swimming'
      when /bike/i
        'biking'
      when /climb/i
        'climbing'
      when /walk/i
        'walking'
      when /train/i
        'training'
      else
        'other'
      end
    end

    def parse_date(date)
      date.is_a?(Date) ? date : Date.parse(date)
    end

    def parse_elapsed_time_to_seconds(time)
      if time.is_a?(String) && /^\d{1,2}(?::\d{2}){2}/ =~ time
        Time.parse(time) - Time.now.at_beginning_of_day
      else
        time.to_i
      end
    end

    def speed(dist, time)
      avg_speed = dist > 0 ? (dist/(time/3600)).round(2) : 0

      return 0 if avg_speed < 1

      avg_speed
    end

    def time_str(time)
      if time < 1.day
        Time.at(time).gmtime.strftime('%R:%S')
      elsif time >= 1.day && time < 1.month
        Time.at(time).gmtime.strftime('%d:%R:%S')
      else
        Time.at(time).gmtime.strftime('%m:%d:%R:%S')
      end
    end

  end
end
