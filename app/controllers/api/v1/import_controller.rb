class Api::V1::ImportController < ApplicationController
  def csv
    logger.debug "#{params}"

    render plain: "OK"
  end

  private
    def import_params
        params.permit(:spreadsheet)
    end
end
