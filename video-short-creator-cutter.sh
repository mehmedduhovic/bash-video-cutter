#!/usr/bin/env bash

# Function to display script usage
usage() {
    echo "Usage: $0 -i INPUT_VIDEO -t TIMESTAMP_FILE -o OUTPUT_DIRECTORY"
    echo "List of possible arguments:"
    echo " -h   Display this help message"
    echo " -i   FILE Specify an input file"
    echo " -t   FILE Specify a timestamp file"
    echo " -o   FILE Specify an output file"
}

start_script() {
    input_video=""
    input_timestamps=""
    directory=""

    while [ $# -gt 0 ]; do
        case $1 in
        -h)
            usage
            exit 0
            ;;
        -i)
            input_video="$2"
            echo "using $2 as input video"
            shift
            shift
            ;;
        -t)
            input_timestamps="$2"
            echo "using $2 as input timestamps"
            shift
            shift
            ;;
        -o)
            directory="$2"
            echo "using $2 as directory"
            shift
            shift
            ;;
        esac
    done

    error_count=0

    if [ -z "$input_video" ]; then
        echo -e "\033[31mERROR: Input video parameter is missing! \033[0m"
        ((error_count++))
    fi

    if [ -z "$input_timestamps" ]; then
        echo -e "\033[31mERROR: Input timestamps parameter is missing! \033[0m"
        ((error_count++))
    fi

    if [ -z "$directory" ]; then
        echo -e "\033[33mWARNING: Output directory parameter is missing! \033[0m"
        echo "Creating the default directory named 'output'"
        directory="output"
        mkdir -p $directory
    fi

    if [[ ! -e "$directory" ]]; then
        mkdir $directory
    fi

    if [[ ! -e "input_video" ]]; then
        echo -e "\033[31mERROR: Input video is missing! \033[0m"
        ((error_count++))
    fi

    if [ "$error_count" -gt 0 ]; then
        echo -e "\033[37;41mEXITING THE SCRIPT!\033[0m"
        exit 0
    fi

    count=1

    while IFS= read -r line; do
        start_timestamp=$(echo "$line" | awk '{print $1}')
        end_timestamp=$(echo "$line" | awk '{print $2}')
        output_video="${count}.mp4"

        ffmpeg_cutting_opts=(
            -nostdin               #disable stdin, because ffmpeg runs as a background process using while
            -ss "$start_timestamp" #decodes the timestamp
            -to "$end_timestamp"   #stop writing the output
            -i "$input_video"      #input file url
            -c:v copy              #codec video copy
            -c:a copy              #codec audio copy
            -copyinkf              #fixes the freezing issue
            "$directory/$output_video"
        )

        ffmpeg "${ffmpeg_cutting_opts[@]}"
        ((count++))
    done <"$input_timestamps"

    cd "$directory" || exit

    for file in *.mp4; do
        file_name="${file%.*}"
        new_file="${file_name}K.mp4"

        ffmpeg_converting_to_portrait_opts=(
            -i "$file"                                                                                                     #input file
            -vf "scale='min(1080,iw)':min'(1920,ih)':force_original_aspect_ratio=decrease,pad=1080:1920:-1:-1:color=black" #filtergraph
            "$new_file"
        )

        ffmpeg "${ffmpeg_converting_to_portrait_opts[@]}"
    done
}

start_script "$@"
