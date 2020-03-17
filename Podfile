platform :ios, '13.0'

target 'flashChat' do
  use_frameworks!

  # Pods for flashChat

pod 'CLTypingLabel', '~> 0.4.0'
pod 'Firebase/Auth'
pod 'Firebase/Firestore'

end

# This was recommended for removing the"-pie being ignored" warning

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['LD_NO_PIE'] = 'NO'
        end
    end
end
