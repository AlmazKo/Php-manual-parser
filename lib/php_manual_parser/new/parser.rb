class Parser
  def parse anchor, html

     anchor.dst_page_id = get_page_id
    @observer.resolved_anchor anchor

  end
end