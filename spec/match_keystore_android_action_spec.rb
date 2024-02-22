describe Fastlane::Actions::MatchKeystoreAction do
  describe '#run' do
    before do
      allow(ENV).to receive(:fetch).with('ANDROID_MATCH_DEBUG_KEYSTORE').and_return('/tmp/path_to_debug_keystore')
      allow(ENV).to receive(:fetch).with('ANDROID_MATCH_RELEASE_KEYSTORE').and_return('/tmp/path_to_release_keystore')
      allow(ENV).to receive(:fetch).with('ANDROID_MATCH_BRANCH').and_return('branch_name')
      allow(ENV).to receive(:fetch).with('ANDROID_MATCH_URL').and_return('repository_url')
    end

    it 'raises an error for invalid keystore type' do
      expect do
        Fastlane::Actions::MatchKeystoreAction.run(type: 'invalid', force: false)
      end.to raise_error(RuntimeError, /Invalid type/)
    end

    it 'raises an error for missing keystore' do
      allow(File).to receive(:exist?).and_return(false)

      expect do
        Fastlane::Actions::MatchKeystoreAction.run(type: 'debug', force: false)
      end.to raise_error(RuntimeError, /Missing keystore/)
    end
  end
end
end