{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, hyprland }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        myNixos = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos/configuration.nix
 {
        programs.hyprland.enable = true;
        programs.hyprland.package = hyprland.packages.${system}.default;
        nixpkgs.overlays = [ hyprland.overlays.default ];
      }
#	     {
 #           programs.hyprland.enable = true;
           # programs.hyprland.package = hyprland.packages.${system}.default;
  #           }
	{
  	environment.systemPackages = with pkgs; [
    	vscode
  	];
	}
          ];
        };
      };

      packages.${system} = {
        hello = nixpkgs.legacyPackages.${system}.hello;
        default = self.packages.${system}.hello;
      };
    };
}

