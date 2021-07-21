class Sparkctl < Formula
  desc "CLI for interacting with spark on k8s"
  homepage "https://github.com/GoogleCloudPlatform/spark-on-k8s-operator"
  url "https://github.com/GoogleCloudPlatform/spark-on-k8s-operator/archive/refs/tags/v1beta2-1.2.2-3.0.0.tar.gz"
  version "1.2.2"
  sha256 "72fd2e1967ea20c82718c011558fa863c06cdd29cfae65ffc02177da2446a2a9"
  # the versioning scheme is apiversion-operatorVersion-sparkVersion.
  # Homebrew will automatically detect the spark version by default
  # instead pull the operator version which more closely matches to sparkctl
  license "Apache-2.0"
  head "https://github.com/GoogleCloudPlatform/spark-on-k8s-operator.git"
  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    cd buildpath/"sparkctl" do
      system "go", "build", *std_go_args
    end
  end

  test do
    system "#{bin}/sparkctl", "--help"
    assert_match(/failed to get SparkApplication client: unable to load in-cluster configuration,.*/,
                 shell_output("#{bin}/sparkctl list 2>&1"))
  end
end
