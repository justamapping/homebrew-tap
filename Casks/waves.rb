cask "waves" do
  version "0.1.0"
  sha256 "47d7fddf95cd2084de580ce5f60797314ed3a1c0617a5682a434800cdf2ec6df"

  url "https://github.com/justamapping/waves-releases/releases/download/v#{version}/Waves-#{version}.zip"
  name "Waves"
  desc "Menu bar audio visualizer"
  homepage "https://github.com/justamapping/waves-releases"

  depends_on macos: :sonoma

  app "Waves.app"

  zap trash: "~/Library/Preferences/com.lucasdepaola.waves.plist"
end
