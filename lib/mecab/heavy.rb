require_relative 'heavy/modular'

require 'mecab'

MeCab::Tagger.send(:include, MeCab::Heavy::Extension::Tagger)
MeCab::Light::Tagger.send(:include, MeCab::Heavy::Extension::Light::Tagger)
