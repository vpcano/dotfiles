# frozen_string_literal: true

class String
  def colorize(color)
    self.color(color.to_sym)
  end

  def remove(pattern)
    gsub(pattern, '')
  end

  def uniq
    split('').uniq.join
  end
  def bold
    return "\e[1m" + self + "\e[0m"
  end
end

class Hash
  def symbolize_keys
    new_hash = {}
    each_key do |key|
      new_hash[key.to_sym] = delete(key)
    end
    new_hash
  end
end
