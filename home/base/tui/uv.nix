{...}: {
  programs.uv = {
    enable = true;
    settings = {
      index-url = "https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple";
    };
  };
}
