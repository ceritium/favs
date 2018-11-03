require "admiral"
require "./favs/store"

class Favs::CLI < Admiral::Command
  VERSION = "0.1.0"

  define_version VERSION
  define_help description: "Store your fav commands"

  class AddFav < Admiral::Command
    define_argument command : String, required: true

    def run
      if arguments.command
        Store.add(arguments.command.to_s)
      end
    end
  end

  class ListFavs < Admiral::Command
    def run
      Store.load.each_with_index do |item, index|
        STDOUT.puts "# #{index} - #{item}"
      end
    end
  end

  class ShowFav < Admiral::Command
    define_argument item : UInt32,
                  default: 1_u32,
                  required: true
    def run
      if !arguments.item.nil?
        STDOUT.puts Store.get(arguments.item)
      end
    end
  end

  register_sub_command add, AddFav, short: "a"
  register_sub_command list, ListFavs, short: "ls"
  register_sub_command show, ShowFav

  def run
    puts help
  end
end

Favs::CLI.run
