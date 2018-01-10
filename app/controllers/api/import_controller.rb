require '/lib/import_spreadsheet.rb'

class ImportController < ApplicationController
    def import_csv_handler
        import_csv(params[:spreadsheet])
    end

    private
        def import_params
            params.require(:notification).permit(:spreadsheet)
        end
end
