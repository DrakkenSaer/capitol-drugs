class ImportController < ApplicationController
    def import_csv_handler
        logger.debug "#{params}"

        render plain: "OK"
    end

    private
        def import_params
            params.permit(:spreadsheet)
        end
end
