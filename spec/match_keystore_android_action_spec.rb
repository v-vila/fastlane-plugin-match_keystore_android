describe Fastlane::Actions::MatchKeystoreAction do
  describe '#run' do
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