if cd "55"; then
    echo "Changed directory successfully to $(pwd)"
else
    echo "Failed to change directory"
    exit 1 # Exit the script if cd fails
fi
blur=1

convert_ffmpeg() {
    input_file="$1"
    new_file="${input_file}K.mp4"
    echo "$new_file"
    # ffmpeg -i "$input_file" "$new_file"
    # ffmpeg -i "$input_file" -lavfi "[0:v]scale=256/81*iw:256/81*ih,boxblur=luma_radius=min(h\,w)/40:luma_power=3:chroma_radius=min(cw\,ch)/40:chroma_power=1[bg];[bg][0:v]overlay=(W-w)/2:(H-h)/2,setsar=1,crop=w=iw*81/256" "$new_file"
}

export -f convert_ffmpeg

find . -type f -iname "*.mp4" -print0 | parallel -0 convert_ffmpeg

# ls | xargs -P4 -L1 sh -c 'ffmpeg -i $0 -lavfi "[0:v]scale=256/81*iw:256/81*ih,boxblur=luma_radius=min(h\,w)/40:luma_power=3:chroma_radius=min(cw\,ch)/40:chroma_power=1[bg];[bg][0:v]overlay=(W-w)/2:(H-h)/2,setsar=1,crop=w=iw*81/256" -loglevel error ${0##/}'

# for file in *.mp4; do

#     file_name="${file%.*}"
#     new_file="${file_name}K.mp4"

#     #     # ffmpeg_converting_to_portrait_opts=(
#     #     #     -i "$file"                                                                                                     #input file
#     #     #     -vf "scale='min(1080,iw)':min'(1920,ih)':force_original_aspect_ratio=decrease,pad=1080:1920:-1:-1:color=black" #filtergraph
#     #     #     -loglevel error
#     #     #     "$new_file"
#     #     # )

#     #     # ffmpeg_converting_to_portrait_opts_blurred=(
#     #     #     -i "$file" #input file
#     #     #     -lavfi "[0:v]scale=256/81*iw:256/81*ih,boxblur=luma_radius=min(h\,w)/40:luma_power=3:chroma_radius=min(cw\,ch)/40:chroma_power=1[bg];[bg][0:v]overlay=(W-w)/2:(H-h)/2,setsar=1,crop=w=iw*81/256"
#     #     #     -loglevel error
#     #     #     "$new_file"
#     #     # )

#     ffmpeg -i "$file" -lavfi "[0:v]scale=256/81*iw:256/81*ih,boxblur=luma_radius=min(h\,w)/40:luma_power=3:chroma_radius=min(cw\,ch)/40:chroma_power=1[bg];[bg][0:v]overlay=(W-w)/2:(H-h)/2,setsar=1,crop=w=iw*81/256" -loglevel error "$new_file"

#     # if [ $blur -eq 0 ]; then
#     #     ffmpeg "${ffmpeg_converting_to_portrait_opts_blurred[@]}"
#     # else
#     #     ffmpeg "${ffmpeg_converting_to_portrait_opts[@]}"
#     # fi

#     if [ $? -eq 0 ]; then
#         echo "Succesfully created short video $new_file"
#     else
#         echo "An error occured while creating $new_file short video"
#     fi
# done
