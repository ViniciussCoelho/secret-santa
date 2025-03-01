class GroupsController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing

  def index
    list_groups = Groups::ListGroups.new(filter_params)
    response = list_groups.execute

    render json: { data: response[:data], message: response[:message] }, status: response[:status]
  end

  def create
    create_group = Groups::CreateGroup.new(group_params)
    response = create_group.execute

    render json: { data: response[:data], message: response[:message] }, status: response[:status]
  end

  private

  def filter_params
    params.permit(:name, :order, :direction, :page, :per_page)
  end

  def group_params
    params.require(:group).permit(:name)
  end

  def handle_parameter_missing(exception)
    render json: { error: "Required parameters missing: #{exception.param}" }, status: :bad_request
  end
end
