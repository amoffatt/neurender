
touch ~/.no_auto_tmux

mkdir the_output_dir
magick mogrify -format jpg -path "2023-06-21 - Pardise Lake Trail - Forest - jpg" -quality 92 "2023-06-21 - Pardise Lake Trail - Forest/"*.DNG

tar -czvf paradise-lake-trail.tar.gz 2023-06-21\ -\ Pardise\ Lake\ Trail\ -\ Forest\ -\ jpg

scp -P 36718 -i ~/.ssh/vastai_id_rsa paradise-lake-trail.tar.gz root@ssh5.vast.ai:/home/user/data/

ns-process-data metashape --data data/paradise_lake --xml data/paradise_lake/metashape_cameras.xml --output-dir data/paradise_lake_output

ns-train nerfacto --data {output directory}




# Building gaussian splatting
git clone https://github.com/graphdeco-inria/gaussian-splatting --recursive
conda env create --file environment.yml
conda activate gaussian_splatting


# to update the wheel files used by gaussian-splatting, run the gaussian-splatting-build/rebuild-gaussian-splatting-deps.sh
# script, then look at the output logs to find the built wheel files.
# This can be cleaned up in the future.


# Gaussian Splatting prep and training

<put_files_into_data_folder_format>
python3 convert.py -s /home/user/data/paradise-lake-trail 
python3 train.py -s /home/user/data/paradise-lake-trail 


# Retreive model
# on server, tar and gzip the model folder
tar -czvf paradise-lake-trail-model-7k.tar.gz 51b906

# from client machine, retrieve the compressed file
scp -P 37790 -i ~/.ssh/vastai_id_rsa  root@ssh5.vast.ai:/home/user/gaussian-splatting/output/paradise-lake-trail-model-7k.tar.gz ./



# Control vastai

vastai search offers
vastai create instance ${OFFER_ID} --image image/${IMAGE_ID}
vastai show instances
vastai destroy instance 7037790

ssh $(vastai ssh-url ID)


