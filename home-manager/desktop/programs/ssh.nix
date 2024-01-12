{ ... }:

{
  programs.ssh = {
    enable = true;
    serverAliveInterval = 240;
    # Always adds private keys to the running ssh-agent
    addKeysToAgent = "yes";
  };

  # Enable the ssh agent to store private keys
  programs.ssh-agent.enable = true;
}
