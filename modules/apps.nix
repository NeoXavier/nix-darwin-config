{ config
, pkgs
, inputs
, currentSystem
, ...
}:
let
  minimal = [
    "font-jetbrains-mono-nerd-font"
    "1password"
    "1password-cli"
    "obsidian"
    "spotify"
    "protonvpn"
    "jordanbaird-ice"

    # Productivity
    "alfred"
    "karabiner-elements"
    "fantastical"
    "aerospace"

    # Browsers
    "firefox"
    "google-chrome"

    # Development
    "ghostty"

  ];

  full = minimal ++ [
    "setapp"
    "slack"
    "qmk-toolbox"
    "zoom"
    "elmedia-player"
    "daisydisk"
    "keepingyouawake"
    "gimp"

    # Productivity
    "chatgpt"

    # Messaging apps
    "signal"
    "telegram"
    "whatsapp"

    # Development
    "alacritty"
    "iterm2"
    "vmware-fusion"
    "visual-studio-code"
    "mactex"

    # Microsft Office
    "microsoft-excel"
    "microsoft-powerpoint"
    "microsoft-outlook"
    "microsoft-word"
    "microsoft-onenote"
    "microsoft-teams"
  ];

    casks = if currentSystem == "aarch64-darwin" then full else minimal;
in
{
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    # utils

    # misc
    pyenv
  ];
  # ++ [ inputs.ghostty.packages.aarch64-darwin.default ]; (waiting for ghostty flake to suppor nix-darwin)
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
      "nikitabobko/tap"
      "osx-cross/avr"
      "osx-cross/arm"
    ];

    # `brew install`
    brews = [
      "curl" # do not install curl via nixpkgs, it's not working well on macOS!
      # "neovim"
      #"watchman"
      "pyenv"
      "pyenv-virtualenv"
      "gettext"
      "mysql@8.0" # If removing this, also remove it from path in zshrc
      "ranger"
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = casks;
  };
}
