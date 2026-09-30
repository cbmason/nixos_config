{ config, lib, pkgs, ... }:

{
  # Load the NVIDIA kernel module
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
  };

  # Enable OpenGL/graphics support
  hardware.graphics.enable = true;

  # Tell X/Wayland to use the NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];
}

