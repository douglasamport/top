company_arr = [
  {"id"=>"1", "properties"=>{"name"=>"Google", "stock_symbol"=>"GOOG", "primary_role"=>"company"}},
  {"id"=>"2", "properties"=>{"name"=>"Facebook", "stock_symbol"=>"FB", "primary_role"=>"company"}}
]

def print_data(array)
  array.each do |hash| 
    hash.each_pair do |k, v|
      if v.class == Hash 
        v.each_pair { |key, value| puts value }
      else
        puts v
      end
    end
  end
end

def deep_copy(o)
  Marshal.load(Marshal.dump(o))
end

### Builds a new Hash using only each_with_object
# def build_new_without_key(array, rmv_key)
#   new_arr = []
#   array.map do |top_hash|
#     top_hash.each_with_object({}) do |(k, v), a|
#       if v.class == Hash
#         new_v = v.each_with_object({}) do |(l, w), b|
#           if l != rmv_key
#             b[l] = w
#             b
#           end
#         end
#         a[k] = new_v
#       else
#         a[k] = v
#       end
#     end
#   end
# end

### cleaner version of the above using select to trim hash
def build_new_without_key(array, rmv_key)
  new_arr = []
  array.map do |top_hash|
    top_hash.each_with_object({}) do |(k, v), a|
      if v.class == Hash
        a[k] = v.select { |l, w| l != rmv_key }
      else
        a[k] = v
      end
    end
  end
end

mod_company_arr = build_new_without_key(company_arr, "stock_symbol")

### copies Hash and Modifies the copy
# def modify_role (arr1)
#   arr2 = deep_copy(arr1)
#   arr2.map do |hash|
#    hash.each_pair do |key, value| 
#       if value.class == Hash
#         value.delete("primary_role")
#         value["industry"] = "tech"
#       end
#     end
#   end
# end

# mod_company_arr = modify_role(company_arr)

p company_arr
p mod_company_arr

# print_data(mod_company_arr)