module Groups
  class CreateGroup
    def initialize(params)
      @name = params[:name]
    end

    def execute
      group = Group.new(name: @name)
      group.save
      group
    end
  end
end
