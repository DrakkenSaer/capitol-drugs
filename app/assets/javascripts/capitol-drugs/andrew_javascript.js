/* global jQuery */

(function($){
    
    $(document).ready(function(){
        
        $('a[data-toggle="collapse"]').click(function(){
            $(this).find('#sort-arrow').toggleClass('glyphicon-chevron-down glyphicon-chevron-up');
            
        })
    })  
})(jQuery);
