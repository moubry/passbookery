class Passbook::PassesController < ApplicationController
  respond_to :json

  # Get the latest version of a pass.
  def show

    @pass = Passbook::Pass.where(pass_type_identifier: params[:pass_type_identifier], serial_number: params[:serial_number]).first
    head :not_found and return if @pass.nil?
    head :unauthorized and return if request.env['HTTP_AUTHORIZATION'] != "ApplePass #{@pass.authentication_token}"

    debugger

    mime_type = Mime::Type.lookup_by_extension(:pkpass)
    content_type = mime_type.to_s unless mime_type.nil?

    filename = "#{Rails.root}/public/tripcase_flight.pkpass"
    filename = "#{Rails.root}/public/tripcase_flightgatee32.pkpass" if @pass.which == '2'
    filename = "#{Rails.root}/public/tripcase_flight_833am.pkpass" if @pass.which == '3'

    if stale?(last_modified: @pass.updated_at.utc)
      send_file filename, :type => 'application/vnd.apple.pkpass'
    else
      head :not_modified
    end

  end

end
