{ config, lib, pkgs, ... }:

{
  # Load the NVIDIA kernel module
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;

    # Save VRAM across suspend/resume (NVreg_PreserveVideoMemoryAllocations=1
    # plus the nvidia-suspend/resume services). Without this the GPU comes
    # back with its memory wiped, KWin loses its GL context and crashes,
    # taking every Wayland client (e.g. Firefox) down with it.
    powerManagement.enable = true;
  };

  # Enable OpenGL/graphics support
  hardware.graphics.enable = true;

  # Tell X/Wayland to use the NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];

  # Add NVtop
  environment.systemPackages = [ pkgs.nvtopPackages.nvidia ];
}

