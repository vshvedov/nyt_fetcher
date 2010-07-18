require 'nokogiri'
require 'open-uri'
class RequestsController < ApplicationController
  def index
    @requests = Request.all
  end
  
  def show
   sort = case params['sort']
           when "title"  then "title"
           when "bd"   then "bd"
           when "ba" then "ba"
           when "price" then "price"
           when "sqft" then "sqft"
           when "posted_at" then "posted_at"
           when "title_reverse" then "title DESC"
           when "bd_reverse" then "bd DESC"
           when "ba_reverse" then "ba DESC"
           when "price_reverse" then "price DESC"
           when "sqft_reverse" then "sqft DESC"
           when "posted_at_reverse" then "posted_at DESC"
   end
    #conditions = ["property_no LIKE ?", "%#{params[:query]}%"] unless params[:query].nil?

    @request = Request.find(params[:id])
    @appartments = @request.appartments.paginate :page => params[:page], :order => sort, :per_page => 20#, :conditions => conditions
    
    if request.xml_http_request?
      render :partial => "items_list", :layout => false
    end
  end
  
  def new
    @request = Request.new
  end
  
  def create
    @request = Request.new(params[:request])
    url_path  = "http://realestate.nytimes.com/rentals/10036-NEW-YORK-NY-USA/0-99000000-price/0-p"
    doc = Nokogiri::HTML(open(url_path))
    total_pages =  doc.css(".input").text[/[0-9\.]+/].to_i
    if @request.save
      for i in (0..total_pages)
        nyt_page = i*10
        url_for_page = "http://realestate.nytimes.com/rentals/10036-NEW-YORK-NY-USA/0-99000000-price/#{nyt_page.to_s}-p"
        puts "Page ---> #{url_for_page}"
        page_doc = Nokogiri::HTML(open(url_for_page))
        page_doc.css(".property-info.clearfix").each do |p|
          @appartment = Appartment.new
          @appartment.request_id = @request.id
          title = p.at_css("h3 a").text
          price = p.at_css("h4").text
          psumm = p.css(".property-summary").text

          if match = psumm.match(/(\d) BD/)
            bd = match.captures[0]
          else
            bd = "n/a"
          end

          if match = psumm.match(/(\S+) BA/)
            ba = match.captures[0]
          else
            ba = "n/a"
          end

          if match = psumm.match(/(\S+) Sq. Ft./)
            sqft = match.captures[0]
          else
            sqft = nil
          end
          
          posted_at = p.css(".property-title.box.blue.clearfix span").last.text[/[0-9\.]+/]

          @appartment.title = title
          @appartment.price = price
          @appartment.bd = bd
          @appartment.ba = ba
          @appartment.sqft = sqft
          @appartment.posted_at = posted_at
          puts "------------- Page: #{i}"
          @appartment.save
        end
      end

      flash[:notice] = "Successfully created request."
      redirect_to @request
    else
      render :action => 'new'
    end
  end
  
  def edit
    @request = Request.find(params[:id])
  end
  
  def update
    @request = Request.find(params[:id])
    if @request.update_attributes(params[:request])
      flash[:notice] = "Successfully updated request."
      redirect_to @request
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    flash[:notice] = "Successfully destroyed request."
    redirect_to requests_url
  end
end
