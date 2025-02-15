module Groups
  class CreateGroup
    def initialize(params)
      @name = params[:name]
    end

    def execute
      group = Group.new(name: @name)
      group.save!
      { status: :created, data: group }
    rescue ActiveRecord::RecordInvalid => e
      { status: :unprocessable_entity, data: e.record.errors }
    end
  end
end
