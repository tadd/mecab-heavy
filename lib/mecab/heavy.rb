require_relative 'heavy/modular'

require 'mecab'

MeCab::Tagger.include(MeCab::Heavy::Extension::Tagger)

begin
  MeCab::Light::Tagger.include(MeCab::Heavy::Extension::Light::Tagger)
rescue
end
