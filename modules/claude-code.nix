{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [ inputs.nix-claude-code.overlays.default ];

  environment.systemPackages = [
    pkgs.claude-code
    # pkgs.claude-code-minimal  # same thing without the bundled GitHub CLI (gh)
    # pkgs.claude-code-fhs      # FHS-wrapped, see note below
  ];
}

