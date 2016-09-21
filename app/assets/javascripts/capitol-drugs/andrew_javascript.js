/* global jQuery */

(function($){
    $(document).ready(function(){
        $('a[data-toggle="collapse"]').on('click', function () {
            $(this).find('.toggle-chevron').toggleClass('glyphicon-chevron-down glyphicon-chevron-up');
        });
    });
})(jQuery);
