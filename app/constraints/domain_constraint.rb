class DomainConstraint 
    def initialize
      generate_hosts
    end
    
    def generate_hosts
      @domains = Publisher.select(:name).pluck(:name).map{|name| name.parameterize}.uniq 
      set_timestamp
    end
    
    def set_timestamp
        redis = Redis.new(host: "localhost")
        redis.set("rails_routes_ts", Digest::MD5.hexdigest(@domains.inspect))
    end
    
    def matches?(request)
      check_if_expired_routes?
      @domains.include?(request.subdomains(0).first)
    end
    
    def check_if_expired_routes?
        redis = Redis.new(host: "localhost")
        if redis.get("rails_routes_ts") !=  Digest::MD5.hexdigest(@domains.inspect)
            generate_hosts
        end
    end
end