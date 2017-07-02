class Search

  class << self
    def execute(query, region)
      attr = %w(all questions answers comments users)
      if region == 'all'
        ThinkingSphinx.search(escape(query))
      else
        klass(region).search(escape(query)) if attr.include?(region)
      end
    end

    def klass(string)
      capitalize_first(string).singularize.constantize
    end

    def capitalize_first(string)
      string.sub(/\S/, &:upcase)
    end

    def escape(query)
      ThinkingSphinx::Query.escape(query)
    end
  end
end
