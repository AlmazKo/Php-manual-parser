class Observer
  @@mutex = Mutex.new

  attr_reader :observers, :subjects;

  def add_listiner anchor

  end


  def add_listiner anchor

  end


  def resolved_anchor anchor

    @@mutex.synchronize {
       @observers[anchor.canonize_url].each { |observer_anchor|
         observer_anchor.dst_page_id = observer_anchor.dst_page_id
         observer_anchor.save

       }
       @observers[anchor.canonize_url] = nil
       @subjects.remove anchor.canonize_url
    }
  end
end