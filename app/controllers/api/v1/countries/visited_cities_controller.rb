# frozen_string_literal: true

class Api::V1::Countries::VisitedCitiesController < ApiController
  before_action :validate_params

  def index
    start_at = DateTime.parse(params[:start_at]).to_i
    end_at = DateTime.parse(params[:end_at]).to_i

    points = current_api_user
             .tracked_points
             .where(timestamp: start_at..end_at)

    render json: { data: CountriesAndCities.new(points).call }
  end

  private

  def validate_params
    missing_params = %i[start_at end_at].select { |param| params[param].blank? }

    if missing_params.any?
      render json: {
        error: "Missing required parameters: #{missing_params.join(', ')}"
      }, status: :bad_request and return
    end

    params.permit(:start_at, :end_at)
  end
end
