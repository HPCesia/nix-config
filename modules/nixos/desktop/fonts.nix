{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = false;
    fontDir.enable = true;

    packages = with pkgs; [
      # noto-fonts
      # noto-fonts-cjk
      noto-fonts-emoji
      # noto-fonts-extra

      source-sans
      source-serif
      source-han-sans
      source-han-serif

      # nerdfonts
      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable-small/pkgs/data/fonts/nerd-fonts/manifests/fonts.json
      nerd-fonts.symbols-only # symbols icon only

      maple-mono.NF-CN
    ];

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = ["Source Han Serif SC" "Source Han Serif TC" "Noto Color Emoji"];
      sansSerif = ["Source Han Sans SC" "Source Han Sans TC" "Noto Color Emoji"];
      monospace = ["Maple Mono NF CN" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

  # https://wiki.archlinux.org/title/KMSCON
  services.kmscon = {
    # Use kmscon as the virtual console instead of gettys.
    # kmscon is a kms/dri-based userspace virtual terminal implementation.
    # It supports a richer feature set than the standard linux console VT,
    # including full unicode support, and when the video card supports drm should be much faster.
    enable = true;
    fonts = [
      {
        name = "JetBrains Mono";
        package = pkgs.jetbrains-mono;
      }
    ];
    extraOptions = "--term xterm-256color";
    extraConfig = "font-size=12";
    # Whether to use 3D hardware acceleration to render the console.
    hwRender = true;
  };
}
