class Mpssh < Formula
  desc "Mass parallel ssh"
  homepage "https://github.com/ndenev/mpssh"
  head "https://github.com/ndenev/mpssh.git"
  version "1.3.4"

  stable do
    url "https://github.com/ndenev/mpssh/archive/master.tar.gz"
    sha256 "ea612afabee785855659130ad6dd8a2bc28f19636f71f88061dc6749574c934d"
    patch do
      # don't install binaries as root (upstream commit)
      url "https://github.com/ndenev/mpssh/commit/3cbb868b6fdf8dff9ab86868510c0455ad1ec1b3.diff?full_index=1"
      sha256 "c91c3478f05de4b3c200a384ca28449d0c43ad569e8035b3b5247c787f0a984b"
    end
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "714e7b0e97a942f68885baefa599d97e143631154480d0246d04e21a49910acf" => :catalina
    sha256 "e37b5e479ba7f9ad86373e646c63485b55dd1381c2cbc130150e108886675b72" => :mojave
    sha256 "1057c47b866d50031a23a0bd244d3bc056b9f12a4d9bf0aeebc0ea292c484638" => :high_sierra
    sha256 "90d758a0f7accf0b63755c3de8100a880b500e732fc8924123ab2a1c7ce688f8" => :sierra
    sha256 "e5ac485861dfca0be2bb1ca2eb5826b5ca5977c0d2abb12dc58de011c18046f1" => :el_capitan
    sha256 "2b91c9a9dbae19e99b8b8735bb3292cc056dcf8e06472c0b2d354f64896a4186" => :yosemite
    sha256 "60d489a872cb7ed8855c0f95913af4fffe3082b6bee8669b0080c3d30d73249d" => :mavericks
  end

  def install
    system "make", "install", "CC=#{ENV.cc}", "BIN=#{bin}"
    man1.install "mpssh.1"
  end

  test do
    system "#{bin}/mpssh"
  end
end
