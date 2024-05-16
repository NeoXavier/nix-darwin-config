{pkgs, ...}:
###################################################################################
#
#  macOS's System configuration
#
#  All the configuration options are documented here:
#    https://daiderd.com/nix-darwin/manual/index.html#sec-options
#  and see the source code of this project to get more undocumented options:
#    https://github.com/rgcr/m-cli
#
###################################################################################
{
  system = {
    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      #https://superuser.com/questions/1211108/remove-osx-spotlight-keyboard-shortcut-from-command-line
      # target output for AppleSymbolicHotKeys:64
      #
      # <key>64</key>
      # <dict>
      #   <key>enabled</key>
      #   <false/>
      #   <key>value</key>
      #   <dict>
      #     <key>parameters</key>
      #     <array>
      #       <integer>65535</integer>
      #       <integer>49</integer>
      #       <integer>1048576</integer>
      #     </array>
      #     <key>type</key>
      #     <string>standard</string>
      #   </dict>
      # </dict>

      /usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist \
        -c "Delete :AppleSymbolicHotKeys:64" \
        -c "Add :AppleSymbolicHotKeys:64:enabled bool false" \
        -c "Add :AppleSymbolicHotKeys:64:value:parameters array" \
        -c "Add :AppleSymbolicHotKeys:64:value:parameters: integer 65535" \
        -c "Add :AppleSymbolicHotKeys:64:value:parameters: integer 49" \
        -c "Add :AppleSymbolicHotKeys:64:value:parameters: integer 1048576" \
        -c "Add :AppleSymbolicHotKeys:64:type string standard"

      # target output for AppleSymbolicHotKeys:65
      #
      # <key>65</key>
      # <dict>
      #   <key>enabled</key>
      #   <false/>
      #   <key>value</key>
      #   <dict>
      #     <key>parameters</key>
      #     <array>
      #       <integer>65535</integer>
      #       <integer>49</integer>
      #       <integer>1572864</integer>
      #     </array>
      #     <key>type</key>
      #     <string>standard</string>
      #   </dict>
      # </dict>

      /usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist \
        -c "Delete :AppleSymbolicHotKeys:65" \
        -c "Add :AppleSymbolicHotKeys:65:enabled bool false" \
        -c "Add :AppleSymbolicHotKeys:65:value:parameters array" \
        -c "Add :AppleSymbolicHotKeys:65:value:parameters: integer 65535" \
        -c "Add :AppleSymbolicHotKeys:65:value:parameters: integer 49" \
        -c "Add :AppleSymbolicHotKeys:65:value:parameters: integer 1572864" \
        -c "Add :AppleSymbolicHotKeys:65:type string standard"
      defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      menuExtraClock.IsAnalog = true; # Show an analog clock instead of a digital one

      # customize dock
      dock = {
        tilesize = 40;
        show-process-indicators = true;
        appswitcher-all-displays = true; # display the appswitcher on all displays or only the main one
        dashboard-in-overlay = true; # hide Dashboard as a Space
        expose-group-by-app = true; # group windows by application in Mission Control’s Exposé
        launchanim = false; # Animate opening applications from the Dock
        minimize-to-application = true; # minimize windows into their application icon
        mru-spaces = true; # automatically rearrange spaces based on most recent use
        orientation = "bottom";
        show-recents = false; # disable recent apps
        autohide = true;
        #autohide-time-modifier = 1000.0;
        enable-spring-load-actions-on-all-items = true;
      };

      # finder
      finder = {
        _FXShowPosixPathInTitle = true; # show full path in finder title
        AppleShowAllExtensions = true; # show all file extensions
        AppleShowAllFiles = true; # always show hidden files
        FXDefaultSearchScope = "SCcf"; # Change the default search scope
        FXEnableExtensionChangeWarning = false; # disable warning when changing file extension
        FXPreferredViewStyle = "Nlsv"; # Change the default finder view
        QuitMenuItem = true; # enable quit menu item
        ShowPathbar = true; # show path bar
        ShowStatusBar = true; # show status bar
      };

      # trackpad
      trackpad = {
        Clicking = true; # enable tap to click
        TrackpadRightClick = true; # enable two finger right click
      };

      # customize macOS
      NSGlobalDomain = {
        AppleEnableMouseSwipeNavigateWithScrolls = false; # swiping left or right with two fingers to navigate backward or forward.
        AppleEnableSwipeNavigateWithScrolls = false;
        AppleICUForce24HourTime = true;
        AppleInterfaceStyleSwitchesAutomatically = true;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        AppleShowScrollBars = "Always";
        "com.apple.swipescrolldirection" = false; # disable natural scrolling
        "com.apple.sound.beep.feedback" = 0; # disable beep sound when pressing volume up/down key
        #AppleInterfaceStyle = "Dark";  # dark mode

        # If you press and hold certain keyboard keys when in a text area, the key’s character begins to repeat.
        # This is very useful for vim users, they use `hjkl` to move cursor.
        # sets how long it takes before it starts repeating.
        InitialKeyRepeat = 15; # normal minimum is 15 (225 ms), maximum is 120 (1800 ms)
        # sets how fast it repeats once it starts.
        KeyRepeat = 3; # normal minimum is 2 (30 ms), maximum is 120 (1800 ms)

        NSAutomaticCapitalizationEnabled = false; # disable auto capitalization
        NSAutomaticDashSubstitutionEnabled = false; # disable auto dash substitution
        NSAutomaticPeriodSubstitutionEnabled = false; # disable auto period substitution
        NSAutomaticQuoteSubstitutionEnabled = false; # disable auto quote substitution
        NSAutomaticSpellingCorrectionEnabled = false; # disable auto spelling correction
        NSNavPanelExpandedStateForSaveMode = true; # expand save panel by default
        NSNavPanelExpandedStateForSaveMode2 = true;
        # speed up animation on open/save boxes (default:0.2)
        NSWindowResizeTime = 0.001;
        PMPrintingExpandedStateForPrint = true;
        PMPrintingExpandedStateForPrint2 = true;
      };

      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;

      # Customize settings that not supported by nix-darwin directly
      # see the source code of this project to get more undocumented options:
      #    https://github.com/rgcr/m-cli
      #
      # All custom entries can be found by running `defaults read` command.
      # or `defaults read xxx` to read a specific domain.
      CustomUserPreferences = {
        ".GlobalPreferences" = {
          # automatically switch to a new space when switching to the application
          AppleSpacesSwitchOnActivate = true;
        };

        NSGlobalDomain = {
          # Add a context menu item for showing the Web Inspector in web views
          WebKitDeveloperExtras = true;
        };

        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = false;
          ShowHardDrivesOnDesktop = false;
          ShowMountedServersOnDesktop = false;
          ShowRemovableMediaOnDesktop = false;
          _FXSortFoldersFirst = true;
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
          FXEnableExtensionChangeWarning = false;
        };

        #need full disk access to the terminal app - kitty
        "com.apple.Safari" = {
          # Privacy: don’t send search queries to Apple
          UniversalSearchEnabled = false;
          SuppressSearchSuggestions = true;
          # Press Tab to highlight each item on a web page
          WebKitTabToLinksPreferenceKey = true;
          ShowFullURLInSmartSearchField = true;
          # Prevent Safari from opening ‘safe’ files automatically after downloading
          AutoOpenSafeDownloads = false;
          ShowFavoritesBar = false;
          IncludeInternalDebugMenu = false;
          IncludeDevelopMenu = false;
          WebKitDeveloperExtrasEnabledPreferenceKey = true;
          WebContinuousSpellCheckingEnabled = true;
          WebAutomaticSpellingCorrectionEnabled = false;
          AutoFillFromAddressBook = false;
          AutoFillCreditCardData = false;
          AutoFillMiscellaneousForms = false;
          WarnAboutFraudulentWebsites = true;
          WebKitJavaEnabled = false;
          WebKitJavaScriptCanOpenWindowsAutomatically = false;
          "com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks" = true;
          "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
          "com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled" = false;
          "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled" = false;
          "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles" = false;
          "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically" = false;
         };

        "com.apple.mail" = {
          # Disable inline attachments (just show the icons)
          DisableInlineAttachmentViewing = true;
        };

        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };

        "com.apple.screensaver" = {
          # Require password immediately after sleep or screen saver begins
          askForPassword = 1;
          askForPasswordDelay = 0;
        };

        "com.apple.SoftwareUpdate" = {
          AutomaticCheckEnabled = true;
          # Check for software updates daily, not just once per week
          ScheduleFrequency = 1;
          # Download newly available updates in background
          AutomaticDownload = 1;
          # Install System data files & security updates
          CriticalUpdateInstall = 1;
         };

        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };

        "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;

        # Prevent Photos from opening automatically when devices are plugged in
        "com.apple.ImageCapture".disableHotPlug = true;

        # Turn on app auto-update
        "com.apple.commerce".AutoUpdate = true;

        "com.apple.NetworkBrowser" = {
          # Enable AirDrop over Ethernet
          BrowseAllInterfaces = true;
        };

        #Show remaining battery percent
        "com.apple.controlcenter.plist".BatteryShowPercentage = true;

      };

      loginwindow = {
        GuestEnabled = false; # disable guest user
      };

    };

  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;
  environment.shells = [
    pkgs.zsh
  ];

  # Set your time zone.
  # comment this due to the issue:
  #   https://github.com/LnL7/nix-darwin/issues/359
  # time.timeZone = "Asia/singapore";

  # Fonts
  fonts = {
    # will be removed after this PR is merged:
    #   https://github.com/LnL7/nix-darwin/pull/754
    fontDir.enable = true;

    # will change to `fonts.packages` after this PR is merged:
    #   https://github.com/LnL7/nix-darwin/pull/754
    fonts = with pkgs; [

      # packages = with pkgs; [
      # nerdfonts
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
        ];
      })

    ];
  };
}
