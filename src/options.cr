module Options

  alias OptionProc = String -> Nil

  class GeneratorOption
    getter short_flag, long_flag, description, action

    def initialize(
      @short_flag  : String,
      @long_flag   : String,
      @description : String,
      @action      : OptionProc
    )
    end

  end
end
