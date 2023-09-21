import os
from subprocess import run
import argparse
from am_imaging.video.frame_selection import export_sharpest_frames


def main():
    parser = argparse.ArgumentParser(description='')
    parser.add_argument('input_file', type=str, help='Input video file path')
    parser.add_argument('--downscale', type=int, default=1, help='The downscale factor.')
    parser.add_argument('--interval', type=int, default=12, help='Select the sharpest of every <interval> frames in the video')

    args = parser.parse_args()

    input_file = args.input_file
    processing_dir = input_file + "_data"
    output_dir = os.path.join(processing_dir, "input")

    export_sharpest_frames(args.input_file, output_dir, downscale=args.downscale, interval=args.interval)

    run(["python3", "convert.py", "--source_path", processing_dir])
    run(["python3", "train.py", "--source_path", processing_dir])

    print("Done!")






if __name__ == '__main__':
    main()