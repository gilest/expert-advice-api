module Questions
  # Processes raw tag data into a consistent format
  class ProcessTags
    def initialize(tags)
      @tags = tags
    end

    def run
      return '' unless @tags

      @tags = @tags
              .downcase
              .gsub(/[^a-z1-9,]/, ' ') # All unwanted chars replaced with space
              .gsub(/\s+/, ' ')        # Trim whitespace to single spaces
              .split(',')
              .uniq
              .sort
              .join(',')
      @tags
    end
  end
end
