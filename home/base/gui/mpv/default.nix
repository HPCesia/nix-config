{pkgs, ...}: {
  imports = [./scriptOpts];

  programs.mpv = {
    enable = true;
    defaultProfiles = ["gpu-hq"];
    scripts = with pkgs.mpvScripts; [
      mpris
      uosc
      thumbfast
      autoload
      reload
      mpv-playlistmanager
    ];
    config = {
      vo = "gpu-next";
      hwdec = "auto-copy";
      scale = "ewa_lanczossharp";
      # --- 动态范围与色彩管理 --- #
      target-colorspace-hint = "auto";
      tone-mapping = "hable";
      dither = "fruit";
      dither-depth = "auto";
      # --- 音频质量配置 --- #
      ao = "pipewire";
      audio-resample-filter-size = 64;
      audio-resample-phase-shift = 10;
      # --- 字幕配置 --- #
      sub-auto = "fuzzy";
      sub-bold = "yes";
      sub-outline-size = 2.25;
      sub-outline-color = "#111111";
      sub-color = "#FEFEFE";
      sub-font-size = "36";
      sub-use-margins = "yes";
      sub-ass-override = "force";
      # --- 用户体验 --- #
      save-position-on-quit = true;
      keep-open = "yes";
      osd-bar = "no"; # use uosc
      # 音量控制
      volume = 80;
      volume-max = 120;
      # OSD 显示
      osd-duration = 2500;
      osd-font-size = 32;
      # 截图设置
      screenshot-format = "png";
      screenshot-dir = "~/Pictures/mpv";
      screenshot-template = "%F-%P";
    };
  };
}
