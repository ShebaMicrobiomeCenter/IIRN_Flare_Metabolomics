library(magrittr)
library(tibble)
library(dplyr)


## --- Maaslin #4 - IIRN_Flare in IIRN Remission samples only --- ##
# sample_type <- 'Serum'
sample_type = 'Stool'
maaslin_num <- 'IIRN_Flare_LOO'

# maaslin_parameters <- c('Fasting','Gender', 'Age','IIRN_Flare') #Serum
maaslin_parameters <- c( 'Gender', 'Age', 'IIRN_Flare') #Stool

biom <- read.table(paste0('Cohort1_',sample_type,'_metabolomics_data.tsv')
                   ,sep="\t", header=T, row.names = 1, comment.char ="")
biom %>% rownames_to_column("MB") %>% 
  write.table("maaslin_otu_MZM.tsv", sep = "\t", quote = F, row.names = F)

metadata <- read.delim(paste0('Cohort1_',sample_type,'_metabolomics_metadata.txt'))
metadata$SampleID %<>% make.names()

metadata <- metadata %>% filter(Cohort == 'IIRN') %>% 
                         filter(Disease_Status == 'CD_Remission')

for(pnid in unique(metadata$pn_ID)){ 

  output_folder = paste0(sample_type,"_maaslin_",maaslin_num, "_", pnid)
  metadata %>% select('SampleID','pn_ID', all_of(maaslin_parameters)) %>%
  filter(pn_ID != pnid) |> 
  write.table(paste0("maaslin_metadata_MZM_",maaslin_num, "_", pnid, ".tsv")
              , sep = "\t", quote = F, row.names = F)

Maaslin2::Maaslin2("maaslin_otu_MZM.tsv", paste0("maaslin_metadata_MZM_",maaslin_num,"_", pnid, ".tsv")
                   , output_folder, random_effects = c("pn_ID"), fixed_effects = all_of(maaslin_parameters), 
                   plot_heatmap = F, plot_scatter = F)


file.copy("maaslin_otu_MZM.tsv", output_folder)
fs::file_move(paste0("maaslin_metadata_MZM_",maaslin_num,"_", pnid, ".tsv"), output_folder)
}
