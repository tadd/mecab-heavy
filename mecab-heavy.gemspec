Gem::Specification.new do |s|
	s.name = %q{mecab-heavy}
	s.version = '0.996.3dev'
	s.author = 'Tadashi Saito'
	s.description = <<-EOF
Ruby bindings for MeCab, a morphological analyzer,
with libmecab and naist-jdic so that you can use easily at Heroku
	EOF
	s.email = 'tad.a.digger@gmail.com'
	s.extensions = [ 'ext/mecab/extconf.rb' ]
  s.files         = `git ls-files`.split($/)
  s.files = Dir.glob('{lib,ext}/**/*.{c,cpp,h,rb,patch}')

	s.has_rdoc = false
	s.homepage = 'http://mecab.sourceforge.net/'
	s.summary = 'Ruby bindings for MeCab, with libmecab and naist-jdic for utility.'

	s.licenses = ['BSD', 'GPL', 'LGPL']

	s.test_files = ['examples/test.rb']

	s.add_dependency 'mini_portile', '~> 0'

        s.add_development_dependency 'rake', '~> 10'
	s.add_development_dependency 'rake-compiler', '~> 0'
end
