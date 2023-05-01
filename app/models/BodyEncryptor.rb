class BodyEncryptor
    def initialize(key)
      @cipher = OpenSSL::Cipher.new('AES-256-CBC')
      @cipher.encrypt
      @cipher.key = key
    end
  
    def encrypt(body)
      if body.nil?
        raise ArgumentError, "The body cannot be nil."
      end
  
      encrypted_data = @cipher.update(body) + @cipher.final
      Base64.strict_encode64(encrypted_data)
    end
  
    def decrypt(body)
      encrypted_data = Base64.strict_decode64(body)
      @cipher.decrypt(encrypted_data)
    end
end
  