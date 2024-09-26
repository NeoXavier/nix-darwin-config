{ config
, pkgs
, ...
}: {
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    # utils

    # misc
    pyenv
  ];
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    masApps = {
      # TODO Feel free to add your favorite apps here.

      #OnepasswordSafari = 1569813296;
      #Things3 = 904280696;
      #FinalCutPro = 424389933;
      #iMovie = 408981434;
      #Notability = 360593530;
      #Xcode = 497799835;
    };

    taps = [
      #"homebrew/cask-fonts"
      #"homebrew/services"
      #"homebrew/cask-versions"
      "koekeishiya/formulae" # yabai
      "nikitabobko/tap"
      "osx-cross/avr"
    ];

    # `brew install`
    brews = [
      "curl" # do not install curl via nixpkgs, it's not working well on macOS!
      "neovim"
      "qmk/qmk/qmk"
      #"watchman"
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      "font-jetbrains-mono-nerd-font"
      "1password"
      "1password-cli"
      "setapp"
      "obsidian"
      "spotify"
      "slack"
      "qmk-toolbox"
      "protonvpn"

      # Productivity
      "alfred"
      "karabiner-elements"
      "fantastical"
      "spaceid"
      "aerospace"

      # Messaging apps
      "signal"
      "telegram"
      "whatsapp"

      # Browsers
      "firefox"
      "google-chrome"

      # Development
      "alacritty"
      "iterm2"
      "vmware-fusion"
      "visual-studio-code"

      # Microsft Office
      "microsoft-excel"
      "microsoft-powerpoint"
      "microsoft-outlook"
      "microsoft-word"
      "microsoft-onenote"
    ];
  };
}
