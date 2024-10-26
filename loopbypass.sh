while true; do
  cmd stats clear-puller-cache
  rm /storage/emulated/0/Android/data/com.dts.freefireth/files/ffrtc_log.txt
  rm -rf /storage/emulated/0/Android/data/com.dts.freefireth/files/ImageCache/
  rm -rf /storage/emulated/0/Android/data/com.dts.freefireth/files/WorkShop/
  sleep 10
done
