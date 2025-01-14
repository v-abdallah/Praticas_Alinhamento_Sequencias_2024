#!/bin/bash

# Construção do índice de alinhamento com Bowtie (somente precisa ser feito uma vez para a referência)
bowtie-build reference.fasta reference_index

# Diretório onde os arquivos fasta estão localizados
input_dir="./sequencias"
# Diretório onde você deseja salvar os arquivos SAM gerados
output_dir="./resultados"

# Certifique-se de que o diretório de saída existe
mkdir -p $output_dir

# Loop através de cada arquivo .fasta no diretório de entrada
for fasta_file in $input_dir/*.fasta
do
  # Extrai o nome do arquivo sem extensão
  sample_name=$(basename $fasta_file .fasta)
  
  # Executa o alinhamento com Bowtie
  bowtie -f -S -a -v 0 -p 3 -t reference_index $fasta_file > $output_dir/$sample_name.sam 2> $output_dir/$sample_name\_bowtie.log
  
  # Exibe uma mensagem indicando que o alinhamento para a amostra está concluído
  echo "Alinhamento concluído para $sample_name"
done
