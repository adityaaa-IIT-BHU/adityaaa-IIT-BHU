#!/usr/bin/env bash
# Read-only inspection of the source video. Never writes to input/.
set -euo pipefail
SRC="${1:-input/raw.mp4}"
[ -f "$SRC" ] || { echo "Missing: $SRC"; exit 1; }
ffprobe -v error -show_entries format=duration,size,bit_rate:stream=index,codec_type,codec_name,profile,width,height,r_frame_rate,avg_frame_rate,pix_fmt,color_space,sample_rate,channels,channel_layout,bit_rate -of default=nw=1 "$SRC"
echo "--- loudness (EBU R128) ---"
ffmpeg -hide_banner -nostats -i "$SRC" -vn -af ebur128=peak=true -f null - 2>&1 | tail -12
