{
    description = "My NixOS systems";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

        nix-claude-code = {
          url = "github:ryoppippi/nix-claude-code";
          inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, ... }@inputs: {
        nixosConfigurations = {
            quietus = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                modules = [
                    ./hosts/quietus/configuration.nix
                    ./hosts/quietus/hardware-configuration.nix
                    ./modules/common.nix
                    ./modules/nvidia.nix
                    ./modules/claude-code.nix
                ];
            };
        };
    };
}

