ggplot(merged, aes(x = SILO_TMP, y = BoM_TMP)) +
  + stat_binhex()