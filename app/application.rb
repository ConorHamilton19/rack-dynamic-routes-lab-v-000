class Application


  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
      
    elsif req.path.match(/cart/)
      @@cart.each{|cart| resp.write "#{cart}\n"}
        if @@cart.length == 0 
          resp.write "Your cart is empty"
        end
        
    elsif req.path.match(/add/)
      add_item = req.params["item"]
        if @@items.include? add_item
         @@cart << add_item
         resp.write "added #{add_item}"
        else
         resp.write "We don't have that item!"
       end 
       
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
      
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

end
