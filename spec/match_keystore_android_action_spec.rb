describe Fastlane::Actions::MatchKeystoreAndroidAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The match_keystore_android plugin is working!")

      Fastlane::Actions::MatchKeystoreAndroidAction.run(nil)
    end
  end
end
