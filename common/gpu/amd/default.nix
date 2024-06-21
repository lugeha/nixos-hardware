{ config, lib, pkgs, ... }:

{
  options.hardware.amdgpu.loadInInitrd = lib.mkEnableOption (lib.mdDoc
    "loading `amdgpu` kernelModule at stage 1. (Add `amdgpu` to `boot.initrd.kernelModules`)"
  ) // {
    default = true;
  };

  config = lib.mkMerge [
    {
      services.xserver.videoDrivers = lib.mkDefault [ "modesetting" ];
    }
    (lib.mkIf config.hardware.amdgpu.loadInInitrd {
      boot.initrd.kernelModules = [ "amdgpu" ];
    })
  ];
}
