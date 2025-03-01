module Groups
  module Builders
    class GroupQueryBuilder
      def initialize
        @relation = Group
      end

      def filter_by_name(name)
        return self if name.blank?

        @relation = @relation.where("name ILIKE ?", "%#{name}%")
        self
      end

      def order_by(field, direction)
        return self if field.blank?

        @relation = @relation.order(field => direction || :asc)
        self
      end

      def paginate(page, per_page)
        @relation = @relation.paginate(
          page: page || 1,
          per_page: per_page || 10
        )
        self
      end

      def result
        @relation
      end
    end
  end
end
