require 'formula'

class Rdiocommander < Formula
  homepage 'http://obihann.github.io/RdioCommander/'
  url 'https://github.com/obihann/RdioCommander/archive/1.2.1.tar.gz'
  sha1 '5d8fbe19720b1e0b0737c99710a7a7c1d57131ba'

  depends_on :python

  resource 'urwid' do
    url 'https://pypi.python.org/packages/source/u/urwid/urwid-1.2.0.tar.gz'
    sha1 '3776647aaf596c1b70cff9ef8647e519b51bfdd8'
  end


  def install
    ENV.prepend_create_path "PYTHONPATH", libexec+"lib/python2.7/site-packages"
    install_args = [ "setup.py", "install", "--prefix=#{libexec}" ]

    resource("urwid").stage { system "python", *install_args }

    system "python", "setup.py", "install", "--prefix=#{prefix}"

    bin.env_script_all_files(libexec+"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  def test
    system "#{bin}/rdio", "--version"
  end
end
