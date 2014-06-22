%w(confirm).each do |method|
  Rack::MethodOverride::HTTP_METHODS << method.upcase

  ActionDispatch::Request::HTTP_METHODS << method.upcase 
  ActionDispatch::Request::HTTP_METHOD_LOOKUP[method.upcase] = method.to_sym

  ActionDispatch::Routing::Mapper::HttpHelpers.class_eval do
    define_method(method.to_sym) do |*args, &block|
      map_method method.to_sym, args, &block
    end
  end
end
