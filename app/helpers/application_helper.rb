module ApplicationHelper
    # Usage: <% title(STRING or method that returns STRING) %>
    def title(page_title)
        content_for :title, page_title.to_s
    end
    
    # Usage: <%= user_email_or_name(@user) %>
    def user_email_or_name(user)
       user.bill_address ? user.bill_address.firstname : user.email 
    end
end
