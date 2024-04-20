#!/usr/bin/env bash

start_script() {
    input_video=""
    while [ $# -gt 0 ]; do
        case $1 in
        -v)
            input_video="$2"
            echo "using $2 as input video"
            shift
            shift
            ;;
        -o)
            output_video="$2"
            echo "using $2 as output video"
            shift
            shift
            ;;
        esac
    done

    predicted_filename=$(yt-dlp --get-filename -o '%(title)s.%(ext)s' -f 22 "$input_video")
    extension="${predicted_filename##*.}"

    yt-dlp -f 22 "$input_video" -o "${output_video}.%(ext)s"
    new_filename="${output_video}.${extension}"
    ./video-short-creator-cutter.sh -i "$new_filename" -o "$output_video" -t "./timestamps.txt" -b

}

start_script "$@"
