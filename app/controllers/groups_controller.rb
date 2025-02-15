class GroupsController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing

  def create
    create_group = Groups::CreateGroup.new(group_params)
    response = create_group.execute

    render json: response[:data], status: response[:status]
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def handle_parameter_missing(exception)
    render json: { error: "Required parameters missing: #{exception.param}" }, status: :bad_request
  end
end
