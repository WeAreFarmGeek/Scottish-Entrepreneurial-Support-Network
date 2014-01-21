class User < ActiveRecord::Base
 # attr_accessor :request
  has_secure_password
  #validate :domain_email, :on => :create

 # def update_attributes args, req
 #   self.request = req
 #   super args
 # end

  def domain_email
    if request && request.respond_to?(:host)
      unless email.ends_with? request.host
        self.errors[:email] << ": The email address must end in #{request.host}."
      end
    else
      self.errors[:request] << ": Request virtual attribute has not been set"
    end
  end

end
