{
    description = "First nix-darwin system flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nix-darwin.url = "github:LnL7/nix-darwin";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

        nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

        homebrew-sdkman = {
            url = "github:sdkman/homebrew-tap";
            flake = false;
        };


        neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    };

    outputs = { self, ... }@inputs:
        let
            configuration = { pkgs, config, ... }: {
                system.primaryUser = "parthbhargava";

                # List packages installed in system profile. To search by name, run:
                # $ nix-env -qaP | grep wget
                nixpkgs.config.allowUnfree = true;

                environment.systemPackages = with pkgs; [ 
                    neovim
                    mkalias
                    tmux
                    rustup
                    vscode
                    gh
                    stow
                    ngrok
                    spotify
                    zoxide
                    fzf
                    eza
                    ripgrep
                    modrinth-app
                    # inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
                    rlwrap  # required by cht.sh cli mode
                    readline  # python installation seemed incomplete
                    fd  # required by venv-selector.nvim
                    zotero
                    nushell
                    cmake
                    pkg-config
                    atuin
                    inconsolata
                    hyperfine
                    bat
                    # postman
                    aria2
                ];

                homebrew = {
                    enable = true;
                    brews = [
                        "mas"
                        "sdkman-cli"
                        "croc"
                        "xz"  # python installation seemed incomplete
                        # "huggingface-cli"
                        "starship"
                        "zinit"
                        "ollama"
                        "ncdu"
                        "go"
                        "qemu"
                        "bitwarden-cli"
                        "xh"
                        "dust"
                        "dua-cli"
                        "evil-helix"
                        "cargo-binstall"
                        "git-delta"
                        "ripgrep-all"
                        "tokei"
                        "just"
                        "mask"
                        "mprocs"
                        "openssl"
                        "glab"
                    ];

                    casks = [
                        "iina"
                        "hammerspoon"
                        "karabiner-elements"
                        "docker"
                        "notion"
                        "clop"
                        "minecraft"
                        "logi-options+"
                        "iterm2"
                        "notchnook"
                        "arc"
                        "alfred"
                        "steam"
                        "zerotier-one"
                        "termius"
                        "ghostty"
                        "appcleaner"
                        "whatsapp"
                        "qflipper"
                        "trex"
                        "miniforge"
                        "logseq"
                        "devtoys"
                        "aldente"
                        "topnotch"
                        "mactex-no-gui"
                        "legcord"
                        "zoom"
                        "zen"
                        "espanso"
                        "thebrowsercompany-dia"
                        "pieces"
                        "microsoft-teams"
                        "openscad"
                    ];
                    # afaik, dozer deprecated through homebrew, manual install necessary

                    masApps = {
                        "SnippetsLab" = 1006087419;
                        "Slack" = 803453959;
                        "Unarchiver" = 425424353;
                        "Edison" = 1489591003;
                        "Bitwarden" = 1352778147;
                        "Bear" = 1091189122;
                        "Amphetamine" = 937984704;
                        "Xnip" = 1221250572;
                        "Outlook" = 985367838;
                        "Tailscale" = 1475387142;
                    };
                    onActivation.cleanup = "zap";
                    onActivation.autoUpdate = true;
                    onActivation.upgrade = true;
                };
                # https://apps.apple.com/au/app/tot/id1491071483?mt=12
                # https://apps.apple.com/au/app/snippetslab/id1006087419?mt=12

                fonts.packages = [
                    # pkgs.nerd-fonts._0xproto
                    # pkgs.nerd-fonts.droid_sans_mono
                    pkgs.nerd-fonts.jetbrains-mono
                ];

                system.activationScripts.applications.text = let
                    env = pkgs.buildEnv {
                        name = "system-applications";
                        paths = config.environment.systemPackages;
                        pathsToLink = "/Applications";
                    };
                in
                    pkgs.lib.mkForce ''
          # Set up applications.
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read -r src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
                        ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
                    '';

                system.defaults = {
                    dock.autohide = true;
                };

                # Necessary for using flakes on this system.
                nix.settings.experimental-features = "nix-command flakes";

                # Enable alternative shell support in nix-darwin.
                # programs.fish.enable = true;
                programs.zsh.enable = true;

                # Set Git commit hash for darwin-version.
                system.configurationRevision = self.rev or self.dirtyRev or null;

                # Used for backwards compatibility, please read the changelog before changing.
                # $ darwin-rebuild changelog
                system.stateVersion = 5;

                # The platform the configuration will be used on.
                nixpkgs.hostPlatform = "aarch64-darwin";
            };
        in
            {
            # Build darwin flake using:
            # $ darwin-rebuild build --flake .#simple
            darwinConfigurations."pro" = inputs.nix-darwin.lib.darwinSystem {
                modules = [
                    configuration
                    inputs.nix-homebrew.darwinModules.nix-homebrew
                    {
                        nix-homebrew = {
                            # Install Homebrew under the default prefix
                            enable = true;

                            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
                            enableRosetta = true;

                            # User owning the Homebrew prefix
                            user = "parthbhargava";

                            taps = {
                                "sdkman/homebrew-tap" = inputs.homebrew-sdkman;
                            };

                            autoMigrate = true;
                        };
                    }
                ];
            };
        };
}
