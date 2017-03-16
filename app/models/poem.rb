# class Poem < ActiveResource::Base #ActiveRecord::Baseから変更
#   self.site = "https://blooming-bayou-26594.herokuapp.com/poems"
# end

# class Poem < ActiveResource::Base
#   self.site = "https://blooming-bayou-26594.herokuapp.com"
# end

class Poem
  include Her::Model
end
