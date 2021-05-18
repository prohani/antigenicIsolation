gisaid_physio_matrix <- function(data) {
  plt <- ggpairs(data[, -1])
  return(plt)
}

gisaid_hydrophobicity_vs_time <- function(data) {
  gisaid_hydrophic_lm <- lm(Hydrophobicity ~ date, data)
  
  plt <- ggplot(data, aes(x = date, y = Hydrophobicity)) + 
    geom_point() + 
    geom_abline(aes(slope = gisaid_hydrophic_lm$coefficients[2], 
                    intercept = gisaid_hydrophic_lm$coefficients[1]),
                color = "red") + 
    theme_bw()
  
  return(plt)
}

gisaid_hydrophobicity_density <- function(data, n_bins = 80) {
  plt <- ggplot(data, aes(x = date, y = Hydrophobicity)) + 
    geom_bin2d(bins = n_bins) + 
    theme_bw()
  
  return(plt)
}

compare_subunits <- function(HA1 = HA1_physiochemical, HA2 = HA2_physiochemical, property) {
  hp.col <- which(colnames(HA1) == property)
  date.col <- which(colnames(HA1) == "date")
  
  if (hp.col != which(colnames(HA2) == property))
    stop(paste("Error: The column (", property, ") in HA1 is not the same as in HA2", sep = ""))
  if (date.col != which(colnames(HA2) == "date"))
    stop("Error: The column (date) in HA1 is not the same as in HA2")
  
  merged_data <- merge(HA1[, c(hp.col, date.col)], 
                       HA2[, c(hp.col, date.col)], 
                       by = "date")
  melted_data <- melt(merged_data, id.vars = "date")
  
  plt <- ggplot(data = melted_data, aes(x = date, y = value, color = variable)) +
    geom_point(alpha = 0.1) +
    scale_color_discrete(labels = c("HA1", "HA2")) +
    labs(x = "Collection Date (Year)", y = property, color = "HA Subunit") +
    theme_bw()
  
  return(plt)
}

compare_segments <- function(segment1, segment2, segment1_name = "HA", segment2_name = "NA", property) {
  hp.col <- which(colnames(segment1) == property)
  date.col <- which(colnames(segment1) == "date")
  
  if (hp.col != which(colnames(segment2) == property))
    stop(paste("Error: The column (", property, ") in ", segment1_name, " is not the same as in ", segment2_name, sep = ""))
  if (date.col != which(colnames(segment2) == "date"))
    stop("Error: The column (date) in ", segment1_name, " is not the same as in ", segment2_name)
  
  merged_data <- merge(segment1[, c(hp.col, date.col)], 
                       segment2[, c(hp.col, date.col)], 
                       by = "date")
  melted_data <- melt(merged_data, id.vars = "date")
  
  plt <- ggplot(data = melted_data, aes(x = date, y = value, color = variable)) +
    geom_point(alpha = 0.1) +
    scale_color_discrete(labels = c(segment1_name, segment2_name)) +
    labs(x = "Collection Date (Year)", y = property, color = "Gene Segment") +
    theme_bw()
  
  return(plt)
}

gisaid_charge_vs_time <- function(data) {
  gisaid_charge_lm <- lm(Charge ~ date, data)
  
  plt <- ggplot(data, aes(x = date, y = Charge)) + 
    geom_point() +
    geom_abline(aes(slope = gisaid_charge_lm$coefficients[2],
                    intercept = gisaid_charge_lm$coefficients[1]),
                color = "red") +
    theme_bw()
  
  return(plt)
}

gisaid_charge_density <- function(data, n_bins = 80) {
  plt <- ggplot(data, aes(x = date, y = Charge)) + 
    geom_bin2d(bins = n_bins) +
    theme_bw()
  
  return(plt)
}

gisaid_instability_vs_time <- function(data) { 
  gisaid_instability_lm <- lm(Instability_Index ~ date, data)
  
  plt <- ggplot(data, aes(x = date, y = Instability_Index)) +
    geom_point() +
    geom_abline(aes(slope = gisaid_instability_lm$coefficients[2],
                    intercept = gisaid_instability_lm$coefficients[1]),
                color = "red") +
    theme_bw()
  
  return(plt)
}

gisaid_boman_vs_time <- function(data) {
  gisaid_boman_lm <- lm(boman ~ date, data)
  
  plt <- ggplot(data, aes(x = date, y = boman)) +
    geom_point() +
    geom_abline(aes(slope = gisaid_boman_lm$coefficients[2],
                    intercept = gisaid_boman_lm$coefficients[1]),
                color = "red") +
    theme_bw()
  
  return(plt)
}

gisaid_boman_vs_hydrophobicity <- function(data) {
  gisaid_boman_hydrophobicity_lm <- lm(boman ~ Hydrophobicity, data)
  
  plt <- ggplot(data, aes(x = Hydrophobicity, y = boman)) +
    geom_point() +
    geom_abline(aes(slope = gisaid_boman_hydrophobicity_lm$coefficients[2],
                    intercept = gisaid_boman_hydrophobicity_lm$coefficients[1])) +
    geom_text(aes(label = date), hjust = 0, vjust = 0) +
    theme_bw()
  
  return(plt)
}
