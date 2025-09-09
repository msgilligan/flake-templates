{ config, pkgs, lib, specialArgs, ... }:
let
  isLinux = pkgs.stdenv.isLinux;
in
{
  programs.home-manager.enable = pkgs.stdenv.isLinux;

  home.packages = [
    # base (minimal essential)
    pkgs.file
    pkgs.pstree
    pkgs.coreutils
    pkgs.lazygit
    pkgs.systemctl-tui
  ];
  programs.bash = {
    enable = true;
    sessionVariables = {
      MORE = "-e";
      EDITOR = "vi";
    };
    shellAliases = {
      h = "history 30";
      userctl = "systemctl --user";
      userctl-tui = "systemctl-tui -s user";
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      truecolor = false;
    };
  };

  programs.git = {
    enable = true;
    aliases = {
      ci = "commit";
      co = "checkout";
      st = "status";
      sg = "log --pretty=format:'%h %an %s' --graph";
    };
    delta = {
      enable = true;
      options = {
        side-by-side = true;
        tabs = 4;
      };
    };
    extraConfig = {
      init = {
        defaultBranch = "master";
      };
      push = {
        default = "simple";
      };
    };
  };

  # GO GO GO!
  programs.go.enable = true;

  programs.ssh = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [ vim-airline ];
    extraConfig = ''
      set ignorecase
      set mouse=a
    '';
    extraLuaConfig = ''
      vim.o.tabstop = 4       -- Width of tab character
      vim.o.shiftwidth = 4    -- Width for autoindent
      vim.o.expandtab = true  -- Use spaces instead of tab characters

      -- Language-specific override for .nix
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "nix",
        callback = function()
          vim.bo.tabstop = 2
          vim.bo.shiftwidth = 2
          vim.bo.expandtab = true
        end
      })
    '';
  };

  xdg = {
    enable = true;
  };

  home.sessionVariables = {
    EDITOR = "vi";
    MORE = "-e";
  };
}
