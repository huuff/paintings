{
  writeShellApplication,
  swww,
  coreutils,
  ...
}:
writeShellApplication {
  name = "wallrotate";

  runtimeInputs = [
    coreutils # for `shuf`
    swww
  ];

  text = ''
    WALLPAPER_DIR="${../img}"
    INTERVAL="''${INTERVAL:-180}"

    while true; do
        IMAGE=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
        swww img "$IMAGE" --transition-type fade
        sleep "$INTERVAL"
    done
  '';
}
