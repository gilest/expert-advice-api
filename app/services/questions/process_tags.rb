# Processes tag data into a consistent format
module Questions
  class ProcessTags
    def initialize(tags)
      @tags = tags
    end

    def run
      if !@tags
        return ''
      end

      @tags = @tags
             .downcase
             # Replace all unwanted chars with a space
             .gsub(/[^a-z1-9,]/, ' ')
             # Replace all sections of whitespace with a single space
             .gsub(/\s+/, ' ')
             .split(',')
             .uniq
             .sort
             .join(',')
      @tags
    end
  end
end
