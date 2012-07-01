class DownloadManager

  def add_task anchor
      result = download anchor
    @parser.add_task {anchor, result}
  end
end