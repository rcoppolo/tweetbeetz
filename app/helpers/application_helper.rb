module ApplicationHelper
  def credit_links
    twitter_names = %w(rcoppola rrff__ fieldguider).shuffle

    twitter_names.map do |name|
      link_to "@#{name}", "https://twitter.com/#{name}"
    end.to_sentence.html_safe
  end
end
