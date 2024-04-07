# Bash Video Cutter Script

This Bash script is designed to cut and extract multiple short videos out of a long video file and transform them into a format suitable for reel/short uploads for YoutubeShorts or Tiktok. 
It utilizes the `ffmpeg` tool for video processing.

## Prerequisites

Before using this script, ensure you have the following prerequisites installed:

- [ffmpeg](https://ffmpeg.org/): A video processing tool that can decode, encode, transcode, mux, demux, stream, filter, and play almost any multimedia video.

## Usage

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/bracikaa/bash-video-cutter
   ```

2. **Navigate to the Script Directory:**

   ```bash
   cd your-repository
   ```

3. **Make the Script Executable (if necessary):**

   ```bash
   chmod +x video_cutter.sh
   ```

4. **Run the Script:**

   To see the help please run:
   ```bash
   ./video-short-creator-cutter.sh -h
   ```

   An example of a command is found below:
   ```bash
   ./video-short-creator-cutter.sh -i input_video.mp4 -t timestamps_file.txt -o output_directory/
   ```

   - `input_video.mp4`: The path to the long video file you want to cut. Multiple formats are supported.
   - `timestamps_file.txt`: A text file containing the timestamps (in format HH:MM:SS HH:MM:SS) for the segments you want to cut from the long video. Each timestamp should be on a new line.
   - `output_directory/`: The directory where the cut video segments will be saved.

5. **Example of Timestamps File (`timestamps_file.txt`):**

   ```
   00:10:00 00:10:50
   00:20:00 00:20:50
   01:05:30 01:06:30
   ```

   This example file will cut three segments from the input video:

   - From 00:00:00 to 00:10:50
   - From 00:10:00 to 00:20:50
   - From 00:20:00 to 01:06:30

## Notes

- Make sure your input video is in a format supported by ffmpeg.
- Ensure the timestamps provided in the timestamps file are in the correct format (HH:MM:SS HH:MM:SS).
- Output video segments will be saved with sequential filenames in the specified output directory.

## TODOs

- Ability to enter your own format and extension of video shorts
- Ability to change the exported names
- Progress bar (hide ffmpeg report)
