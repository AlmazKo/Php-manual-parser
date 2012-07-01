# coding: utf-8

require 'bash-visual'

module PhpManualParser

  class Log
    include Bash_Visual

    ERROR = :error
    INFO = :info
    WINDOW_SIZE = 62
    DOUBLE_WINDOW_SIZE = WINDOW_SIZE * 2 + 2
    FONT = Font.new(Font::STD, Font::WHITE)
    FONT_ERROR = Font.new(Font::STD, Font::LIGHT_RED)
    MAP = {
        main: VerticalScroll.new(
            coordinates: [1, 11],
            window_size: [WINDOW_SIZE, 20],
            font: FONT,
            start: Scroll::ENDING,
            adapt_size_message: true,
            prefix: -> { Time.now.strftime('%H-%M-%S:%3N') << " " }
        ),
        downloader: VerticalScroll.new(
            coordinates: [WINDOW_SIZE + 3, 11],
            window_size: [WINDOW_SIZE, 20],
            font: FONT,
            start: Scroll::ENDING,
            adapt_size_message: true,
            prefix: -> { Time.now.strftime('%H-%M-%S:%3N') << " " }
        ),
        parser: VerticalScroll.new(
            coordinates: [WINDOW_SIZE * 2 + 5, 11],
            window_size: [WINDOW_SIZE, 20],
            font: FONT,
            start: Scroll::ENDING,
            adapt_size_message: true,
            prefix: -> { Time.now.strftime('%H-%M-%S:%3N') << " " }
        ),
        mysql: VerticalScroll.new(
            coordinates: [1, 33],
            window_size: [WINDOW_SIZE * 3 + 3, 16],
            font: FONT,
            start: Scroll::ENDING,
            adapt_size_message: true,
            prefix: -> { Time.now.strftime('%H-%M-%S:%3N') << " " }
        )


    }


    def self.draw
      console = Console.new(FONT)
      console.clear

      console.position = [0, 0]


      console.draw_window(1, 11, WINDOW_SIZE + 2, 22, 'Main thread', FONT, Console::BORDER_UTF)
      console.draw_window(WINDOW_SIZE + 3, 11, WINDOW_SIZE + 2, 22, 'Download threads', FONT, Console::BORDER_UTF)
      console.draw_window(WINDOW_SIZE * 2 + 5, 11, WINDOW_SIZE + 2, 22, 'Parser thread', FONT, Console::BORDER_UTF)

      console.draw_window(1, 33, WINDOW_SIZE * 3  + 5, 18, 'Mysql thread', FONT, Console::BORDER_UTF)
    end

    def self.add message = '', thread_name = Thread.current[:name]
      if MAP[thread_name]
        if message.is_a? Exception
          MAP[thread_name].add message, FONT_ERROR
        else
          MAP[thread_name].add message
        end

      end

    end

  end
end