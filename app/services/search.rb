class Search

  TYPES = %w(all questions answers comments users)

  class << self
    def execute(query, region)
      if region == 'all'
        ThinkingSphinx.search(escape(query))
      else
        klass(region).search(escape(query)) if TYPES.include?(region)
      end
    end

    def klass(string)
      string.classify.constantize
    end

    def escape(query)
      ThinkingSphinx::Query.escape(query)
    end
  end
end
