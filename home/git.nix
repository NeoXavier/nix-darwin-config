{ ... }: {
  programs.git = {
    enable = true;
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID9ghWJfG0I25bTwPnMVI5Gooena5Vn1LyX4EYyIAxVQ";
      signByDefault = true;
    };
    settings = {
      alias= {
        #ff = "merge --ff-only";
        #pushall = "!git remote | xargs -L1 git push --all";
        #add-nowhitespace = "!git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -";
        #fast-forward = "merge --ff-only";
        #cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 -r git branch -d
        #prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
        #root = "rev-parse --show-toplevel";
        graph = "log --decorate --oneline --graph";
      };
      user.name = "Xavier Neo";
      user.email = "xavier_neo@dev.ensigninfosecurity.com";
      branch.autosetuprebase = "always";
      color.ui = true;
      github.user = "NeoXavier";
      push = {
        default = "tracking";
        autoSetupRemote = true;

      };
      init.defaultBranch = "master";
      commit.gpgsign = true;
      gpg = {
        format = "ssh";
        ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };
    };
    ignores = [ ".direnv" ];
  };
}
