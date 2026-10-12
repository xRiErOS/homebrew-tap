class OkfCli < Formula
  include Language::Python::Virtualenv

  desc "CLI and MCP server for Open Knowledge Format (OKF) catalogues"
  homepage "https://github.com/xRiErOS/okf-cli"
  url "https://github.com/xRiErOS/okf-cli/archive/refs/tags/rel-0-2-3.tar.gz"
  sha256 "8cfddc7b8862870709e2e5d988af1d4242746957eb13b1aba26fe9e2dfe89b14"
  license "Apache-2.0"

  depends_on "python@3.14"
  depends_on "uv" # the MCP server runs as `uv run --with "mcp<2"`

  def install
    # Same artifact as `pipx install` / `uv tool install`: the wheel layout of pyproject.toml.
    venv = virtualenv_create(libexec, "python3.14")
    venv.pip_install_and_link buildpath
  end

  def caveats
    <<~EOS
      Wire okf into your coding agents and shells (previews first, changes nothing):
        okf install
      Then perform it:
        okf install --apply
    EOS
  end

  test do
    assert_match "usage:", shell_output("#{bin}/okf --help")
    system bin/"okf", "install", "--json", "--only", "claude"
  end
end
