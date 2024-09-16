{...}: {
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
      key = "7E3F503DB9A7E8B3";
      signByDefault = true;
    };
    # aliases = {
    #   cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 -r git branch -d";
    #   prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
    #   root = "rev-parse --show-toplevel";
    # };
    extraConfig = {
      branch.autosetuprebase = "always";
      color.ui = true;
      # core.askPass = ""; # needs to be empty to use terminal for ask pass
      # credential.helper = "store"; # want to make this more secure
      github.user = "NeoXavier";
      push.default = "tracking";
      init.defaultBranch = "master";
    };
    ignores = [".direnv"];
  };
}
