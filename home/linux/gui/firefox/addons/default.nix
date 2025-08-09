{ buildFirefoxXpiAddon, fetchurl, lib, stdenv }:
  {
    "lulu-translator" = buildFirefoxXpiAddon {
      pname = "lulu-translator";
      version = "25.7.0";
      addonId = "{20c4c749-556c-4659-8827-16dfaf0601f9}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4539524/2818091-25.7.0.xpi";
      sha256 = "a87c7f30dde5125e48cc848d7af730dcabe38e455ffe254799591d79b514d211";
      meta = with lib;
      {
        description = "LuLu Translate, the world-leading cross-platform translation software, supports translation by selecting words.";
        mozPermissions = [
          "<all_urls>"
          "webRequest"
          "storage"
          "activeTab"
          "contextMenus"
          "scripting"
          "cookies"
          "file:///*"
          "*://*/*"
        ];
        platforms = platforms.all;
      };
    };
  }