{
  writeShellApplication,
  swww,
  coreutils,
  ...
}:
writeShellApplication {
  name = "wallrotate";

  runtimeInputs = [
    coreutils # for `shuf` and `date`
    swww
  ];

  text = ''
    WALLPAPER_DIR="${../img}"
    INTERVAL="''${INTERVAL:-180}"

    while true; do
        IMAGE=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
        swww img "$IMAGE" --transition-type fade
        echo "$(date --iso-8601=seconds) - Switched to $IMAGE"
        sleep "$INTERVAL"
    done
  '';
}
