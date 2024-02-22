describe Fastlane::Actions::MatchKeystoreAction do
  describe '#run' do
    it 'clones the repository and copies the keystore' do
      allow(ENV).to receive(:[]).and_return(nil) # Stub environment variables
      allow(FileUtils).to receive(:mkdir_p)
      allow(FileUtils).to receive(:cp)
      allow(FileUtils).to receive(:rm_rf)
      allow(File).to receive(:exist?).and_return(false)
      expect(Fastlane::Actions::MatchKeystoreAction).to receive(:sh).with(/git clone/)

      Fastlane::Actions::MatchKeystoreAction.run(type: 'debug', force: false)
    end

    it 'raises an error for invalid keystore type' do
      expect do
        Fastlane::Actions::MatchKeystoreAction.run(type: 'invalid', force: false)
      end.to raise_error(RuntimeError, /Invalid type/)
    end

    it 'raises an error for missing keystore' do
      allow(ENV).to receive(:[]).and_return(nil) # Stub environment variables
      expect do
        Fastlane::Actions::MatchKeystoreAction.run(type: 'debug', force: false)
      end.to raise_error(RuntimeError, /Missing keystore/)
    end
  end
end