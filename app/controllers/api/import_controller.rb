class ImportController < ApplicationController
    def import_csv_handler

        begin
            import_csv(params[:spreadsheet])
            render plain: "OK"
        rescue => e
            render plain: e
        end
    end

    private
        def import_params
            params.require(:notification).permit(:spreadsheet)
        end
end
