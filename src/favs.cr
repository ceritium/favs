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
        result = Store.add(arguments.command.to_s)
        STDOUT.puts "Added # 0 - #{result}"
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
    define_argument index : UInt32,
                  default: 1_u32,
                  required: true
    def run
      index = arguments.index
      unless index.nil?
        STDOUT.puts Store.get(index)
      end
    end
  end

  class DeleteFav < Admiral::Command
    define_argument index : UInt32,
      default: 1_u32,
      required: true

    def run
      index = arguments.index
      unless index.nil?
        result = Store.delete(index)
        STDOUT.puts "Deleted: # #{index} - #{result}"
      end
    end
  end

  register_sub_command add, AddFav
  register_sub_command list, ListFavs, short: "ls"
  register_sub_command show, ShowFav
  register_sub_command delete, DeleteFav, short: "del"

  def run
    puts help
  end
end

Favs::CLI.run
