# Example use: resolver_for(my_type).with(obj, args, ctx)
# Returns a list [:type, :obj, :args, :ctx] when chained with #with
def resolver_for(type)
  [type].tap do |resolver|
    resolver.define_singleton_method(:with) do |obj, args, ctx|
      resolver + [obj, args, ctx]
    end
  end
end
