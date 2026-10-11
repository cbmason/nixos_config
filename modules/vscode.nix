{ pkgs, ... }:

{
  environment.systemPackages = [
    # FHS-wrapped so marketplace extensions with prebuilt binaries just work
    pkgs.vscode.fhs
  ];
}
