class Search
  class << self
    def execute(query, region)
      attr = %w(all questions answers comments users)
      if region == 'all'
        ThinkingSphinx.search(query)
      else
        klass(region).search(query) if attr.include?(region)
      end
    end

    def klass(string)
      capitalize_first(string).singularize.constantize
    end

    def capitalize_first(string)
      string.sub(/\S/, &:upcase)
    end
  end
end
