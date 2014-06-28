Gem::Specification.new do |s|
	s.name = %q{mecab-heavy}
	s.version = '0.996.0'
	s.author = 'Tadashi Saito'
	s.date = '2014-XX-XX'
	s.description = <<-EOF
Ruby bindings for MeCab, a morphological analyzer.
	EOF
	s.email = 'taku@chasen.org'
	s.extensions = [ 'ext/mecab/extconf.rb' ]
  s.files         = `git ls-files`.split($/)
  s.files = Dir.glob('ext/**/*.{c,cpp,h,rb}')

	s.has_rdoc = false
	s.homepage = 'http://mecab.sourceforge.net/'
	s.summary = 'Ruby bindings for MeCab.'

	s.licenses = ['BSD', 'GPL', 'LGPL']

	s.test_files = ['examples/test.rb']

	s.add_development_dependency 'rake', '~> 10'
	s.add_development_dependency 'rake-compiler', '~> 0'
end
