module Groups
  class ListGroups
    def initialize(params)
      @builder = Builders::GroupQueryBuilder.new
      @params = params
    end

    def execute
      groups = @builder.filter_by_name(@params[:name])
                      .order_by(@params[:order], @params[:direction])
                      .paginate(@params[:page], @params[:per_page])
                      .result
      { status: :ok, data: groups, message: "Groups fetched successfully" }
    rescue => e
      { status: :internal_server_error, message: e.message }
    end
  end
end
