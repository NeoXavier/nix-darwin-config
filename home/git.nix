{ ... }: {
  programs.git = {
    enable = true;
    aliases = {
      #ff = "merge --ff-only";
      #pushall = "!git remote | xargs -L1 git push --all";
      graph = "log --decorate --oneline --graph";
      #add-nowhitespace = "!git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -";
      #fast-forward = "merge --ff-only";
    };
    userName = "NeoXavier";
    userEmail = "xavierneo88@gmail.com";
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKvthpQx+4xQBZ2HenJ/ubjLhmr68Dw0+00k+Ot+xj9J";
      signByDefault = true;
    };
    # aliases = {
    #   cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 -r git branch -d
    #   prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
    #   root = "rev-parse --show-toplevel";
    # };
    extraConfig = {
      branch.autosetuprebase = "always";
      color.ui = true;
      github.user = "NeoXavier";
      push = {
        default = "tracking";
        autoSetupRemote = true;

      };
      init.defaultBranch = "master";
      commit.gpsign = true;
      gpg = {
        format = "ssh";
        ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };
    };
    ignores = [ ".direnv" ];
  };
}
