module V1
  class TracksController < ApplicationController
    load_and_authorize_resource

    def index
      result = GetAllTracks.call
      render json: result.success? ? result.tracks : []
    end

    def show
      result = GetTrackById.call(id: params[:id])
      render json: result.success? ? result.track : []
    end

    def create
      result = CreateTrack.call(track_params: track_params, user_id: current_user.id)
      if result.success?
        render json: result.track, status: :created, location: v1_track_url(result.track)
      else
        render json: result.track.errors, status: :unprocessable_entity
      end
    end

    def update
      result = UpdateTrack.call(id: params[:id], track_params: track_params)
      if result.success?
        render json: result.track
      else
        render json: result.track.errors, status: :unprocessable_entity
      end
    end

    def destroy
      result = DestroyTrack.call(id: params[:id])
      render status: result.success? ? :no_content : :unprocessable_entity
    end

    private

    def track_params
      params.permit(:name, :sound_track)
    end
  end
end