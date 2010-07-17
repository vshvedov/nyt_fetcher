class Request < ActiveRecord::Base
  has_many :appartments, :dependent => :destroy 
end
