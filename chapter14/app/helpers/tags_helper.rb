module TagsHelper
  def tag_links(tags)
    tags.map do |tag|
      link_to "#{tag.name} (#{tag.page_tags_count})",
              tag_path(tag.name)
    end.join(' ')
  end
end
