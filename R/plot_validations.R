ggplot(merged, aes(x = SILO_TMP, y = BoM_TMP)) +
  stat_binhex() +
  geom_abline(slope = 1, colour = "white")
