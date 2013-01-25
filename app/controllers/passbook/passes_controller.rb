class Passbook::PassesController < ApplicationController
  respond_to :json

  # Get the latest version of a pass.
  def show

    @pass = Passbook::Pass.where(pass_type_identifier: params[:pass_type_identifier], serial_number: params[:serial_number]).first
    head :not_found and return if @pass.nil?
    head :unauthorized and return if request.env['HTTP_AUTHORIZATION'] != "ApplePass #{@pass.authentication_token}"

    mime_type = Mime::Type.lookup_by_extension(:pkpass)
    content_type = mime_type.to_s unless mime_type.nil?

    if stale?(last_modified: @pass.updated_at.utc)
      # respond_with @pass
      filename = "#{Rails.root}/public/tripcase_flight.pkpass"
      # render :file => filename, :content_type => content_type
      send_file filename, :type => 'application/vnd.apple.pkpass'
    else
      head :not_modified
    end

  end

end
