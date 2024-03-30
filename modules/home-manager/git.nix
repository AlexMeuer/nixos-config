{ pkg, input, ... }: {
  programs.git = {
    enable = true;
    userName = "alexmeuer";
    userEmail = "alex@alexmeuer.com";
  };
  programs.lazygit = {
    enable = true;
  };
  programs.gh = {
    enable = true;
  };
  programs.gh-dash = {
    enable = true;
  };
}
