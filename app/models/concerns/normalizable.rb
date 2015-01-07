module Normalizable
  extend ActiveSupport::Concern
  module ClassMethods
    def normalize_answer(ans)
      ans.gsub(/ё/,'е').gsub(/Ё/,'Е').gsub(/,/,'').mb_chars.downcase.strip
    end
  end
end
