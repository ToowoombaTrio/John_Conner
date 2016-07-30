

merged <- NULL
ggplot2::ggplot(merged, ggplot2::aes(x = SILO_TMP, y = BoM_TMP)) +
  ggplot2::stat_binhex() +
  ggplot2::geom_abline(slope = 1, colour = "white")
