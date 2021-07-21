class Sparkctl < Formula
  desc "CLI for interacting with spark on k8s"
  homepage "https://github.com/GoogleCloudPlatform/spark-on-k8s-operator"
  url "https://github.com/GoogleCloudPlatform/spark-on-k8s-operator.git",
      tag:      "v1beta2-1.2.2-3.0.0",
      revision: "2e8b733f5ad029ceb8a949b153a53c434b8fcfe1"
  # the versioning scheme is apiversion-operatorVersion-sparkVersion.
  # Homebrew will automatically detect the spark version by default
  # instead pull the operator version which more closely matches to sparkctl
  version "1.2.2"
  license "Apache-2.0"
  head "https://github.com/GoogleCloudPlatform/spark-on-k8s-operator.git"
  depends_on "go@1.15" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["CGO_ENABLED"] = "0"
    dir = buildpath/"src/github.com/GoogleCloudPlatform/spark-on-k8s-operator"
    dir.install (buildpath/"").children
    cd dir/"sparkctl" do
      system "go", "build", *std_go_args
    end
  end

  test do
    system "test", "-f", "#{bin}/sparkctl"
    system "#{bin}/sparkctl", "--help"
  end
end
