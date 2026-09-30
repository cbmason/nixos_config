{
    description = "My NixOS systems";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    };

    outputs = { self, nixpkgs }: {
        nixosConfigurations = {
            quietus = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./hosts/quietus/configuration.nix
                    ./hosts/quietus/hardware-configuration.nix
                    ./modules/common.nix
                    ./modules/nvidia.nix
                ];
            };
        };
    };
}

