class ImportController < ApplicationController
    def import_csv_handler
        logger.debug "#{params}"

        begin
            import_csv(params[:spreadsheet])
            render plain: "OK"
        rescue => e
            render plain: e
        end
    end

    private
        def import_params
            params.permit(:spreadsheet)
        end
end
