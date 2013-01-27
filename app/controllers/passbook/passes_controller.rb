class Passbook::PassesController < ApplicationController
  respond_to :json

  # Get the latest version of a pass.
  def show

    @pass = Passbook::Pass.where(pass_type_identifier: params[:pass_type_identifier], serial_number: params[:serial_number]).first
    head :not_found and return if @pass.nil?
    head :unauthorized and return if request.env['HTTP_AUTHORIZATION'] != "ApplePass #{@pass.authentication_token}"

    # suck in example data for now, can be provided by the DB entry later if we want
    passJSONPath = "#{Rails.root}/passbook/pass.json"
    passJSONPath = "#{Rails.root}/passbook/pass2.json" if @pass.which == '2'
    passJSONPath = "#{Rails.root}/passbook/pass3.json" if @pass.which == '3'

    # read in the JSON from the file
    passJSON = File.read(passJSONPath)

    passFile = PB::PKPass.new passJSON

    passFile.addFiles [
      "#{Rails.root}/passbook/icon.png",
      "#{Rails.root}/passbook/icon@2x.png",
      "#{Rails.root}/passbook/logo.png",
      "#{Rails.root}/passbook/logo@2x.png"
    ]

    pkpass = passFile.file

    if stale?(last_modified: @pass.updated_at.utc)
      send_file pkpass.path, type: 'application/vnd.apple.pkpass', disposition: 'attachment', filename: "pass.pkpass"
    else
      head :not_modified
    end

  end

end
