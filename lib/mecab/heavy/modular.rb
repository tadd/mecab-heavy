module MeCab
  module Heavy
    DICTIONARY_PATH = File.expand_path(Dir.glob(__dir__ + "/../../../ext/mecab/ports/*/mecab/*/lib/mecab/dic/naist-jdic").first)

    module Extension
      module Tagger
        def self.included(base)
          base.class_eval do
            alias initialize_before_mecab_heavy initialize
            def initialize(argument = '')
              p :here
              initialize_before_mecab_heavy(argument + " -d #{::MeCab::Heavy::DICTIONARY_PATH}")
            end
          end
        end
      end

      module Light
        module Tagger
          def self.included(base)
            base.class_eval do
              alias initialize_before_mecab_heavy initialize
              def initialize(argument = '')
                initialize_before_mecab_heavy(argument + " -d #{::MeCab::Heavy::DICTIONARY_PATH}")
              end
            end
          end
        end
      end
    end
  end
end
