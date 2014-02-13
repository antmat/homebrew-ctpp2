require 'formula'


class Ctpp2 < Formula
  url 'http://ctpp.havoc.ru/download/ctpp2-2.8.tar.gz'
  homepage 'http://ctpp.havoc.ru'
  md5 'f9474c6dae89b7c514a997d505c32e76'
  depends_on 'cmake' => :build
#  depends_on 'gcc47'
  fails_with [:llvm, :clang] do
    cause <<-EOS.undent
      Impossible to build with clang or llvm.
      EOS
  end

  def patches
    # fixes build on mac os (getpwd definition)
    "https://raw.github.com/antmat/homebrew-ctpp2/master/patch.diff"
  end

  def install
    system "mkdir -p build && cd build && cmake -DCMAKE_CXX_COMPILER=`ls /usr/local/bin/g++* | tail -n1` #{std_cmake_parameters} .. && make install && cd .."
    include.install "include" => "ctpp2"
  end

end

__END__

