{ pkgs, input, ... }: {
  programs.git = {
    enable = true;
    userName = "Alex Meuer";
    userEmail = "alex@alexmeuer.com";
    delta.enable = true;
    lfs.enable = true;
  };
  programs.lazygit = {
    enable = true;
  };
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
  programs.gh-dash = {
    enable = true;
    # settings = {
    #   theme = {};
    # };
  };
}
