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
	  specialArgs = { inherit hyprland; }; # pass hyprland into modules
          modules = [
            ./nixos/configuration.nix


 # Inline module that applies Hyprland + overlay
            {
              programs.hyprland.enable = true;
              programs.hyprland.package = hyprland.packages.${system}.default;

              nixpkgs.overlays = [ hyprland.overlays.default ];
	}

{
  services.greetd.enable = true;
  services.greetd.settings = {
    default_session = {
      command = "Hyprland";
      user = "arvid";
    };
  };

  # Graphics + portals (recommended)
  hardware.graphics.enable = true;            # new name on recent NixOS
  xdg.portal.enable = true;
#  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  security.polkit.enable = true;              # for portals / permissions
}



   
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

