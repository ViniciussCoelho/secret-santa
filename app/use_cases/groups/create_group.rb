module Groups
  class CreateGroup
    def initialize(params)
      @name = params[:name]
    end

    def execute
      group = Group.new(name: @name)
      group.save!
      { status: :created, data: group, message: "Group created successfully" }
    rescue ActiveRecord::RecordInvalid => e
      { status: :unprocessable_entity, message: e.record.errors.full_messages.join(", ") }
    end
  end
end
