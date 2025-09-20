{
  description = "NixOS config with Hyprland from flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, hyprland, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [ hyprland.overlays.default ];
    };
  in {
    nixosConfigurations.myNixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./nixos/configuration.nix

        # Inline module for Hyprland
        {
          programs.hyprland = {
            enable = true;
            package = hyprland.packages.${system}.default;
          };

          services.greetd = {
            enable = true;
            settings = {
              default_session = {
                command = "Hyprland";
                user = "arvid";
              };
            };
          };

          hardware.graphics.enable = true;

          xdg.portal = {
            enable = true;
            #extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
          };

          security.polkit.enable = true;

          environment.systemPackages = with pkgs; [
            vscode
            hyprlock
	    polkit
          ];
        }
      ];
    };
  };
}

