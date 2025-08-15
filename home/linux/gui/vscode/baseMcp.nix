{
  servers = {
    github = {
      type = "http";
      url = "https://api.githubcopilot.com/mcp/";
      gallery = true;
    };
    context7 = {
      type = "stdio";
      command = "npx";
      args = ["-y" "@upstash/context7-mcp@latest"];
      gallery = true;
    };
  };
  inputs = [];
}
