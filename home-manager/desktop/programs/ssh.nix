{ ... }:

{
  programs.ssh = {
    enable = true;
    serverAliveInterval = 240;
  };
}
