module PhpManualParser
  class Task
    attr_accessor :anchor, :page, :notes, :anchors

    # @param [Anchor] anchor
    # @param [Page] page
    # @param [Array] notes
    # @param [Array] anchors
    def initialize(anchor, page = nil, notes = nil, anchors = nil)
      @anchor, @page, @notes, @anchors = anchor, page, notes, anchors
    end

    def new?
      @page.nil?
    end

  end
end