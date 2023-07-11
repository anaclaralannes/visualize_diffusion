#!/bin/bash

# Define o tipo de terminal para as imagens de saída
terminal_type="png"

# Define a resolução da imagem de saída
resolution="1024,768"

# Define a paleta de cores
palette="jet"

# Define o diretório de saída para imagens
output_dir="output_images"
mkdir -p "$output_dir"

for file in output_timestep_*.txt; do
  # Extrai o timestep do nome do arquivo
  timestep=$(echo "$file" | grep -o -E '[0-9]+')

  # Define o nome do arquivo de imagem de saída
  output_image="${output_dir}/image_timestep_${timestep}.${terminal_type}"

  gnuplot -e "
    set terminal ${terminal_type} size ${resolution};
    set output '${output_image}';
    set title 'Distribuição da temperatura no timestep ${timestep}';
    set xlabel 'X';
    set ylabel 'Y';
    set cblabel 'Temperatura';
    set pm3d map;
    set palette defined (0 '#000090', 1 '#000fff', 2 '#0090ff', 3 '#0fffee', 4 '#90ff70', 5 '#ffee00', 6 '#ff7000', 7 '#ee0000', 8 '#7f0000');
    set size square;
    splot '${file}' u 1:2:3 with pm3d;
  "
done

echo "Visualization complete! Images saved in the '${output_dir}' directory."

