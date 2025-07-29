{...}: {
  programs.plasma.window-rules = [
    {
      description = "Pot";
      match = {
        window-class.value = "pot";
        window-types = ["normal"];
      };
      apply.noborder.value = true;
    }
  ];
}
