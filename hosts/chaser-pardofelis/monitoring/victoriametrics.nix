{
  lib,
  config,
  ...
}:
# let
#   isSecret = v: lib.isAttrs v && v ? "secretName";
#   hosts = config.modules.my-hosts;
#   managedHosts = lib.filterAttrs (name: host: !builtins.isNull host.network.ipv4) hosts;
# in
lib.mkMerge [
  {
    services.victoriametrics = {
      enable = true;
      listenAddress = "127.0.0.1:9020";

      extraOptions = [
        # Allowed percent of system memory VictoriaMetrics caches may occupy.
        "-memory.allowedPercent=30"
      ];

      prometheusConfig.scrape_configs = [
        {
          job_name = "node-exporter-local";
          scrape_interval = "30s";
          metrics_path = "/metrics";
          static_configs = [
            {
              # All my NixOS hosts.
              targets = ["127.0.0.1:${builtins.toString config.services.prometheus.exporters.node.port}"];
              labels.type = "node";
              labels.host = "pardofelis";
            }
          ];
        }
      ];
    };
  }
  # TODO: Complete below before I have another remote host running NixOS
  # (
  #   lib.concatMapAttrs
  #   (host: cfg: let
  #     templateName = "prometheus-node-exporter-${host}.json";
  #     nodeExporterPort = builtins.toString config.services.prometheus.exporters.node.port;
  #   in {
  #     services.victoriametrics.prometheusConfig.scrape_configs = [
  #       {
  #         job_name = "node-exporter-${host}";
  #         scrape_interval = "30s";
  #         metrics_path = "/metrics";
  #         static_configs = lib.mkIf (!isSecret cfg.network.ipv4) [
  #           {
  #             targets = ["${cfg.network.ipv4}:${nodeExporterPort}"];
  #             labels.type = "node";
  #             labels.host = host;
  #           }
  #         ];
  #         file_sd_configs = lib.mkIf (isSecret cfg.network.ipv4) [
  #           {files = config.sops.templates.${templateName}.path;}
  #         ];
  #       }
  #     ];
  #     sops.templates.${templateName} = lib.mkIf (isSecret cfg.network.ipv4) {
  #       content = ''
  #         [${builtins.toJSON {
  #           targets = ["${config.sops.placeholder."${host}-ipv4"}:${nodeExporterPort}"];
  #           labels.type = "node";
  #           labels.host = host;
  #         }}]
  #       '';
  #       user = "root";
  #       group = "victoriametrics";
  #       mode = "0440";
  #     };
  #   })
  #   managedHosts
  # )
]
