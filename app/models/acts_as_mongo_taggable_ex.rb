module ActsAsMongoTaggable
  module ClassMethods
    def where_with_tag(phrase, opts={})
      lo = opts.clone
      case_sensitive = lo.delete :case_sensitive
      phrase = phrase.downcase unless case_sensitive
      where(lo.merge(:tag_words => phrase))
    end
  end
end
