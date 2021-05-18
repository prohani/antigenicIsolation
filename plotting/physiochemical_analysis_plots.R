ggplot <- function(...) ggplot2::ggplot(...) + scale_color_brewer(palette="Paired") + scale_fill_brewer(palette="Paired")
unlockBinding("ggplot", parent.env(asNamespace("GGally")))
assign("ggplot",ggplot, parent.env(asNamespace("GGally")))

smith_physiochemical_df <- measure_physio(seq = sequences)

smith_physio_matrix <- (
  ggpairs(data = smith_physiochemical_df,
          columns = 3:7,
          mapping = ggplot2::aes(color = cluster),
          legend = 1) +
    labs(title = "Physiochemical analysis of Smith HA segments") +
    theme(legend.position = "bottom") 
)

smith_hydrophic_lm <- lm(Hydrophobicity ~ date, data = smith_physiochemical_df)
smith_hydrophobicity_vs_time <- (
  ggplot(data = smith_physiochemical_df, aes(x = date, y = Hydrophobicity, color = cluster)) + 
    geom_point() + 
    geom_abline(aes(slope = smith_hydrophic_lm$coefficients[2], 
                    intercept = smith_hydrophic_lm$coefficients[1])) + 
    theme_bw()
)

smith_charge_lm <- lm(Charge ~ date, data = smith_physiochemical_df)
smith_charge_vs_time <- (
  ggplot(data = smith_physiochemical_df, aes(x = date, y = Charge, color = cluster)) + 
    geom_point() + 
    geom_abline(aes(slope = smith_charge_lm$coefficients[2], 
                    intercept = smith_charge_lm$coefficients[1])) + 
    theme_bw()
)

smith_instability_lm <- lm(Instability_Index ~ date, data = smith_physiochemical_df)
smith_instability_vs_time <- ( 
  ggplot(data = smith_physiochemical_df, aes(x = date, y = Instability_Index, color = cluster)) +
    geom_point() +
    geom_abline(aes(slope = smith_instability_lm$coefficients[2],
                    intercept = smith_instability_lm$coefficients[1])) +
    theme_bw()
)

smith_boman_lm <- lm(boman ~ date, data = smith_physiochemical_df)
smith_boman_vs_time <- (
  ggplot(data = smith_physiochemical_df, aes(x = date, y = boman, color = cluster)) +
    geom_point() +
    geom_abline(aes(slope = smith_boman_lm$coefficients[2],
                    intercept = smith_boman_lm$coefficients[1])) +
    theme_bw()
)

smith_boman_hydrophobicity_lm <- lm(boman ~ Hydrophobicity, data = smith_physiochemical_df)
smith_boman_vs_hydrophobicity <- (
  ggplot(data = smith_physiochemical_df, aes(x = Hydrophobicity, y = boman, color = cluster)) +
    geom_point() +
    geom_abline(aes(slope = smith_boman_hydrophobicity_lm$coefficients[2],
                    intercept = smith_boman_hydrophobicity_lm$coefficients[1])) +
    geom_text(aes(label = date), hjust = 0, vjust = 0) +
    theme_bw()
)

#######################

#gisaid_physio_matrix <- (
#  ggpairs(data = gisaid_physiochemical_df[, -1]) + 
#  labs(title = "Physiochemical analysis of GISAID HA segments from 1970 - 2003")
#)
#
#gisaid_hydrophic_lm <- lm(Hydrophobicity ~ date, data = gisaid_physiochemical_df)
#gisaid_hydrophobicity_vs_time <- (
#  ggplot(data = gisaid_physiochemical_df, aes(x = date, y = Hydrophobicity)) + 
#    geom_point() + 
#    geom_abline(aes(slope = gisaid_hydrophic_lm$coefficients[2], 
#                    intercept = gisaid_hydrophic_lm$coefficients[1])) + 
#    labs(title = "Hydrophobicity over time (GISAID samples from 1970 - 2003)") + 
#    theme_bw()
#)
#
#gisaid_hydrophobicity_density <- (
#  ggplot(data = gisaid_physiochemical_df, aes(x = date, y = Hydrophobicity)) + 
#    geom_bin2d(bins = 80) + 
#    labs(title = "Hydrophobicity over time (GISAID samples from 1970 - 2003)") + 
#    theme_bw()
#)
#
#gisaid_charge_lm <- lm(Charge ~ date, data = gisaid_physiochemical_df)
#gisaid_charge_vs_time <- (
#  ggplot(data = gisaid_physiochemical_df, aes(x = date, y = Charge)) + 
#    geom_point() + 
#    geom_abline(aes(slope = gisaid_charge_lm$coefficients[2], 
#                    intercept = gisaid_charge_lm$coefficients[1])) + 
#    labs(title = "Charge over time (GISAID samples from 1970 - 2003)") + 
#    theme_bw()
#)
#
#gisaid_charge_density <- (
#  ggplot(data = gisaid_physiochemical_df, aes(x = date, y = Charge)) + 
#    geom_bin2d(bins = 80) + 
#    labs(title = "Charge over time (GISAID samples from 1970 - 2003)") + 
#    theme_bw()
#)
#
#gisaid_instability_lm <- lm(Instability_Index ~ date, data = gisaid_physiochemical_df)
#gisaid_instability_vs_time <- ( 
#  ggplot(data = gisaid_physiochemical_df, aes(x = date, y = Instability_Index)) +
#    geom_point() +
#    geom_abline(aes(slope = gisaid_instability_lm$coefficients[2],
#                  intercept = gisaid_instability_lm$coefficients[1])) +
#    labs(title = "Instability Index over time (GISAID samples from 1970 - 2003)") +
#    theme_bw()
#)
#
#gisaid_boman_lm <- lm(boman ~ date, data = gisaid_physiochemical_df)
#gisaid_boman_vs_time <- (
#  ggplot(data = gisaid_physiochemical_df, aes(x = date, y = boman)) +
#    geom_point() +
#    geom_abline(aes(slope = gisaid_boman_lm$coefficients[2],
#                  intercept = gisaid_boman_lm$coefficients[1])) +
#    labs(title = "Boman scores over time (GISAID samples from 1970 - 2003)") +
#    theme_bw()
#)
#
#gisaid_boman_hydrophobicity_lm <- lm(boman ~ Hydrophobicity, data = gisaid_physiochemical_df)
#gisaid_boman_vs_hydrophobicity <- (
#  ggplot(data = gisaid_physiochemical_df, aes(x = Hydrophobicity, y = boman)) +
#    geom_point() +
#    geom_abline(aes(slope = gisaid_boman_hydrophobicity_lm$coefficients[2],
#                  intercept = gisaid_boman_hydrophobicity_lm$coefficients[1])) +
#    labs(title = "Boman scores over time (GISAID samples from 1970 - 2003)") +
#    geom_text(aes(label = date), hjust = 0, vjust = 0) +
#    theme_bw()
#)
#
##summary(gisaid_hydrophic_lm)
#