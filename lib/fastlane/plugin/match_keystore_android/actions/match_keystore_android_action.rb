require 'fastlane/action'
require_relative '../helper/match_keystore_android_helper'

module Fastlane
  module Actions
    class MatchKeystoreAction < Action
      def self.run(params)
        keystore_type = params[:type]
        keystore = nil

        case keystore_type
        when 'debug'
          keystore = ENV['ANDROID_MATCH_DEBUG_KEYSTORE']
        when 'release'
          keystore = ENV['ANDROID_MATCH_RELEASE_KEYSTORE']
        else
          raise "Invalid type #{keystore_type}. Valid values: debug|release."
        end

        raise "Missing keystore #{keystore}." unless keystore

        return if !params[:force] && File.exist?(keystore)

        temp_dir = "/tmp/#{SecureRandom.hex(8)}"
        git_clone_command = "git clone --branch #{ENV['ANDROID_MATCH_BRANCH']} #{ENV['ANDROID_MATCH_URL']} #{temp_dir}"
        FileUtils.mkdir_p(temp_dir)
        sh(git_clone_command)
        FileUtils.cp("#{temp_dir}/#{keystore}", '../')
        FileUtils.rm_rf(temp_dir)
      end

      def self.description
        "Match keystore action"
      end

      def self.authors
        ["Virginia Vila"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :type,
                                       description: "Keystore type",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :force,
                                       description: "Force keystore update",
                                       default_value: false,
                                       is_string: false)
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end