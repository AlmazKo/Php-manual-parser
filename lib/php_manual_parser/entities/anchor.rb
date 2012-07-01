module PhpManualParser

  class Anchor < Entity

    attr_accessor :id, :from_page_id, :to_page_id, :url, :url_params, :is_contents, :canonical_url, :to_note_id

  end
end