{ config, pkgs, lib, inputs, system, ... }:
let inherit (inputs) jwtinfo;
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "luciano.mammino";
  home.homeDirectory = "/home/luciano.mammino";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; ([
    glxinfo
    libGL
    nerdfonts
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    python3
    poetry
    just
    nodejs_22
    corepack_22
    awscli2
    neofetch
    gh
    rustup
  ] ++ [
    jwtinfo.packages.${system}.default
  ]);

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/luciano.mammino/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  programs.fish = { 
    enable = true;
    shellInit = ''
      source /home/luciano.mammino/.nix-profile/etc/profile.d/nix.fish
    '';
    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "85f863f20f24faf675827fb00f3a4e15c7838d76";
          sha256 = "+FUBM7CodtZrYKqU542fQD+ZDGrd2438trKM0tIESs0=";
        };
      }
    ];
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = { 
      add_newline = false; 
      hostname.style = "bold green"; # don't like the default
      username.style_user = "bold blue"; # don't like the default
      scan_timeout = 2000;
      character = { 
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
    enableTransience = true;
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    flags = [
      "--disable-up-arrow"
    ];
    settings = {
      auto_sync = false;
      dialect = "uk";
      search_mode = "fuzzy";
      filter_mode = "directory";
      style = "full";
      show_preview = true;
    };
  };

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      manager = {
        show_hidden = true;
      };
    };
  };

  programs.ripgrep.enable = true;
  programs.bat.enable = true;

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 24;
    };
    shellIntegration.enableFishIntegration = true;
    theme = "Catppuccin-Macchiato";
  };

  programs.alacritty = {
    enable = true;
  };

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        font = wezterm.font("JetBrainsMono Nerd Font"),
        font_size = 24.0,
        color_scheme = "Tomorrow Night",
        front_end = "Software",
        enable_wayland = false,
        default_prog = { "fish" }
      }
    '';
  };

  programs.zellij = {
    enable = false;
    enableFishIntegration = true;
    settings = {
      default_shell = "fish";
      mouse_mode = false;
    };
  };
}
