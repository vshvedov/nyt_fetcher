module RequestsHelper
  def sort_link(text, param)
     key = param
     key += "_reverse" if params[:sort] == param
     options = {
         :url => {:action => 'show', :params => params.merge({:sort => key})},
         :update => 'table',
         :method => :get,
         :before => "$('#spinner').show()",
         :success => "$('#spinner').hide()"
     }
     html_options = {
       :title => "Sort by field",
       :href => url_for(:action => 'show', :params => params.merge({:sort => key}))
     }
     link_to_remote(text, options, html_options)
  end 
end
