library(ggplot2)
library(patchwork)


## main cohort
all_df_f = read.table('IIRN_p2_cohorts_fig_table.txt', header = T, sep = '\t')

temp2 = aggregate(data=all_df_f, time~pn_ID, function(x) max(x) )
all_df_f$pn_ID = factor(x = all_df_f$pn_ID, levels = rev(c(temp2$pn_ID[ rev(order(temp2$time)) ])) )

all_df_f$Group[all_df_f$Group == 'never_flared'] = 'Never flared'
all_df_f$Group[all_df_f$Group == 'flared'] = 'Flared'
all_df_f$Group = factor(x = all_df_f$Group, levels = c('Never flared','Flared') ) 

fu_name = 'Last follow-up/flare'
all_df_f$time3 =all_df_f$time2/30

all_df_f$type = gsub('Follow-up',fu_name, all_df_f$type)
g_5a = ggplot(all_df_f, aes( x = time3, y = pn_ID, 
                        fill = Disease_Status, shape = type )) + 
  geom_line(aes(group = pn_ID), colour = 'gray') + 
  # geom_point(size = 1.7, alpha = 0.5) + 
  geom_point(alpha = 0.6, aes(size = type == fu_name)) +
  # scale_size_manual(values = c(1.5,2.3)) + 
  scale_size_manual(values = c(2,2.5)) +
  # facet_wrap(Dx+pn_ID~., switch = "y") + 
  # facet_grid(Dx~., scale = 'free', space = 'free', switch = "y") + 
  facet_grid(Group~., scale = 'free', space = 'free', switch = "y") + 
  theme_minimal() + 
  xlab('Months from first sample') + ylab('') +
  theme(panel.grid = element_blank(),
        strip.text.y.left = element_text(angle = 90, size=11),
        legend.text = element_text(size=11), 
        axis.title.x = element_text(size=15), 
        axis.text = element_text(size=11),
        # axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.ticks.x=element_line(),
        # strip.text.y.left = element_text(angle = 0)
  ) + 
  # scale_fill_manual(values = c('#ff4040','#ffca63','#5c5cff'), 
  #                   labels = c('CD active','CD remission','Control')) +
  scale_fill_manual(values = c('#ffca63','#5c5cff','gray80','#ff4040'), 
                    labels = c('CD remission','Control','CD remission followup','CD active'),
                    breaks = c('CD_Remission','Control','CD_Remission_followup','CD_active')
                    ) +
  guides(fill = guide_legend("", override.aes = list(shape = 21, alpha=1))) + 
  # facet_grid(Cohort~., scales = 'free') + 
  scale_shape_manual( breaks = c('Stool metabolomics','Serum metabolomics',
                                 fu_name), 
                      # values = c(15,16,17) ) 
                      values = c(23,22, 21), name='' ) 
g_5af = g_5a + theme(axis.text.y=element_blank())


## validatioon cohort
name = 'CURE'
out_path = './'
# dir.create(out_path)

na_str = c('no_data','_','NA','unknown', 'other','na','No_followup','')

# map_all_file = sprintf('%s/CURE_16S_metabolomics_map_v3_yael.tsv', out_path)
# map_all_file = sprintf('%s/CURE_16S_metabolomics_map_v4.tsv', out_path)
map_all_file = sprintf('%s/CURE_cohort_figure_for_nina_paper2_table_v2_NL.tsv', out_path)
map_all = read.table(map_all_file,sep="\t", header=TRUE, na.strings = na_str, comment.char = '', quote = '')

map_all = map_all[map_all$pn_flare !='Active',]

map_all$visit = sprintf('%02d', map_all$visit)

met_df = map_all[!is.na(map_all$metabolomics_ID),]
met_df$type = 'Fecal metabolomics'

serum_df = map_all[!is.na(map_all$Chem_Lab),]
serum_df$type = 'Serum lab'

last_fu_df =  map_all[!is.na(map_all$Time_in_study_24M),
                      c('pn_ID','group3','Time_in_study_24M','pn_flare')] 
last_fu_df = unique(last_fu_df)
names(last_fu_df)[names(last_fu_df)== 'Time_in_study_24M'] = 'visit'
last_fu_df$visit = sprintf('%02d',last_fu_df$visit )
last_fu_df$type = 'Last follow-up/flare'
last_fu_df$visit[last_fu_df$visit == '22'] = '21'

wanted_vars = c('pn_ID','visit','pn_flare','group3','type')

map_all = rbind(met_df[,wanted_vars], serum_df[,wanted_vars], last_fu_df[,wanted_vars])

## order patients, using visit
pns = unique(map_all$pn_ID)
max_time = vector(mode = 'numeric',length = length(pns))
for ( i in 1:length(pns) )
{
  max_time[i] = max(map_all$visit[map_all$pn_ID == pns[i]], na.rm = T)
}
# pns_for_level = sprintf('%02d-%s',max_time, pns)
pns_for_level = sprintf('%s-%s',max_time, pns)
pns_ord = order
map_all$pn_ID = factor(map_all$pn_ID, levels = pns[order(pns_for_level)])

map_all$group3[map_all$group3 == 'Never_flared'] = 'Never flared'
map_all$group3 = factor(x = map_all$group3, levels = c('Never flared','Flared') ) 


map_all$Disease_Status = ifelse(map_all$pn_flare == 'Pre_flare','CD active','CD remission followup')
map_all$Disease_Status[map_all$type != 'Last follow-up/flare' ] = 'CD remission'
g2 = ggplot( map_all, 
             aes(x=as.numeric(visit), y=pn_ID, group = pn_ID)) + 
  geom_line(colour='gray') + 
  # geom_point(aes(fill = Disease_Status, shape = type), size=2.5, colour='black') +  
  geom_point(aes(fill = Disease_Status, 
                 shape = type, 
                 size = type == 'Last follow-up/flare'),
             alpha = 0.6) + 
  scale_size_manual(values = c(2,2.5)) + 
  scale_shape_manual( breaks = c('Fecal metabolomics','Serum lab',
                                  'Last follow-up/flare'), 
                      values = c(23,22,21), name='' ) +
                      # values = c(24,25, 21), name='' ) +  
  # scale_fill_brewer(palette = 'Set1') + 
  # scale_fill_manual(values = c('#ff4040','#ffca63','#61A3BA','#7743DB','#C3ACD0','black'), 
  #                   breaks = c('Active','Pre_flare','Never_flared','SF','left','Withdrew_consent')) + 
  scale_fill_manual(values = c('#ffca63','#5c5cff','gray80','#ff4040'), 
                    labels = c('CD remission','Control','CD remission followup','CD active'),
                    breaks = c('CD remission','Control','CD remission followup','CD active')) + 
  facet_grid(group3~., scales = 'free', space = 'free', switch = "y") +
  # facet_grid(~type, scales = 'free', space = 'free') +
  # scale_colour_manual(values = c('blue','red')) + 
  theme_minimal() + xlab('Months from first sample') + 
  theme(panel.grid = element_blank(),
        strip.text.y.left = element_text(angle = 90, size=11),
        legend.text = element_text(size=11), 
        axis.title.x = element_text(size=15), 
        axis.text = element_text(size=11),
        # axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.ticks.x=element_line(),
        # strip.text.y.left = element_text(angle = 0)
  ) + 
  guides(fill = guide_legend("", override.aes = list(shape = 21, alpha=1))) 
g2f = g2 + theme(axis.text.y=element_blank())


## merge cohorts to 1 figure

gg = g_5a + g2 + plot_layout(widths = c(1, 0.6))
ggf = g_5af + g2f + plot_layout(widths = c(1, 0.6))

ggsave(gg, file=sprintf('IIRN_CURE_cohorts_fig_full.pdf'),
       device = "pdf", width = 11,height = 8, limitsize = FALSE)

ggsave(ggf, file=sprintf('IIRN_CURE_cohorts_fig.pdf'),
       device = "pdf", width = 11,height = 5, limitsize = FALSE)

