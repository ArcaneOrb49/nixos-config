# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];





	#####################################
	##                                 ##
	##                                 ##
	##                                 ##
	##  System Settings !!!CareFul!!!  ##
	##                                 ##
	##                                 ##
	#####################################






  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;


  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable CUPS to print documents.
  services.printing.enable = false;



	#####################################
	##                                 ##
	##                                 ##
	##                                 ##
	##            Network              ##
	##                                 ##
	##                                 ##
	#####################################




  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  

  # Enable networking
   networking.networkmanager.enable = true;






	#####################################
	##                                 ##
	##                                 ##
	##                                 ##
	##           Bluetooth             ##
	##                                 ##
	##                                 ##
	#####################################

  
  # Enable Bluetooth service
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package =  pkgs.bluez;   # full BlueZ with extra tools

  # Optional: enable Blueman (GTK tray app)
  services.blueman.enable = true;




	#####################################
	##                                 ##
	##                                 ##
	##                                 ##
	##          Localisation           ##
	##                                 ##
	##                                 ##
	#####################################


  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";






	#####################################
	##                                 ##
	##                                 ##
	##                                 ##
	##        X11 Window System        ##
	##               &                 ##
	##          GNOME Desktop          ##
	#####################################

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
 # services.xserver.displayManager.gdm.enable = true;
 # services.xserver.desktopManager.gnome.enable = true;



services.greetd.enable = true;
services.greetd.settings = {
  default_session = {
    command = "Hyprland";
  };
};

hardware.graphics.enable = true;
xdg.portal.enable = true;
#xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
security.polkit.enable = true;










	#####################################
	##                                 ##
	##                                 ##
	##                                 ##
	##              Audio              ##
	##                                 ##
	##                                 ##
	#####################################




  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };






	#####################################
	##                                 ##
	##                                 ##
	##                                 ##
	##              User               ##
	##                                 ##
	##                                 ##
	#####################################

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.arvid = {
    isNormalUser = true;
    description = "Arvid Meltzer";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  Enable packages here
    ];
  };



# Cursor settings for Wayland
environment.variables = {
  XCURSOR_THEME = "Adwaita";
  XCURSOR_SIZE = "24";
};







	#####################################
	##                                 ##
	##                                 ##
	##                                 ##
	##    Packages to be installed     ##
	##                                 ##
	##                                 ##
	#####################################



  #####################################
  ##             Settings            ##
  #####################################


 # Allow unfree packages
  nixpkgs.config.allowUnfree = true;




  #####################################
  ##         Enabled Programms       ##
  #####################################



  # Install firefox.
  programs.firefox.enable = true;
  
  # Installs Steam with dependencies
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Gam  e Transfers
};

	


 
  #####################################
  ##         System Programms        ##
  #####################################



  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
	wget
	discord
	brave
	git
	kitty
	neofetch
	grim
	slurp
	waybar
	wofi
	networkmanagerapplet
	greetd.gtkgreet
	sway
	unzip
	bluez
	python313
	python313Packages.dbus-python
	openvpn
	polkit
	pywal
	hyprpaper
	dejavu_fonts
  ];









	#####################################
	##                                 ##
	##                                 ##
	##                                 ##
	##          Miscellaneous          ##
	##                                 ##
	##                                 ##
	#####################################

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
