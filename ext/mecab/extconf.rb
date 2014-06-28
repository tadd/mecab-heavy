require 'rbconfig'
RbConfig::MAKEFILE_CONFIG['CXX'] = ENV['CXX'] if ENV['CXX']
RbConfig::MAKEFILE_CONFIG['CC'] = ENV['CC'] if ENV['CC']

require 'mkmf'
require 'mini_portile'

require_relative 'parallel_make'

find_executable('make')

def cook_internal(name, version, url, patches = [])
  recipe = MiniPortile.new(name, version)
  recipe.files = [url]
  recipe.configure_options += %w[--with-charset=utf8 --disable-shared --enable-static CXX='g++ -fPIC' CC='gcc -fPIC']
  recipe.patch_files += patches.map{|f| File.expand_path(f, __dir__)} unless patches.empty?
  recipe.cook
  recipe.activate
end

def cook_mecab
  cook_internal('mecab', '0.996', 'https://mecab.googlecode.com/files/mecab-0.996.tar.gz')
end

def cook_naist_jdic
  cook_internal('mecab-naist-jdic', '0.6.3b-20111013',
                'http://jaist.dl.sourceforge.jp/naist-jdic/53500/mecab-naist-jdic-0.6.3b-20111013.tar.gz',
                %w[patch/prefix.patch])
end

cook_mecab
cook_naist_jdic

mecab_config = with_config('mecab-config', 'mecab-config')

get = ->(opt) { `#{mecab_config} --#{opt}`.strip }
  
$CFLAGS << ' ' << get['cflags'] << ' -fPIC'
$LDFLAGS << ' ' << get['libs']
$libs << ' ' << get['libs-only-l'].split.map{|l| "-l#{l}"}.join(' ') # fix broken mecab_config as pkg_config script

unless `#{mecab_config} --version`.chomp =~ /^0\.996/
  puts "[ERROR] Mecab 0.996 requires libmecab version 0.996."
  exit 1
end

include = Dir.glob("#{Dir.pwd}/ports/*/mecab/0.996/include").first
$CPPFLAGS += " -I#{include}"

have_header('mecab.h') && create_makefile('mecab')
