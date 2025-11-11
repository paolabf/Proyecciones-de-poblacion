source("02-codigo/02-grafica-años-con-decrecimiento.R")

#Ver las gráficas por entidad 

pob_variacion %>%
  left_join(primer_decrecimiento, by = "entidad") %>%
  ggplot(aes(x = ano, y = total, color = entidad)) +
  # Línea vertical del primer decrecimiento
  geom_vline(data = primer_decrecimiento, 
             aes(xintercept = primer_ano), 
             color = "#DD8D29", linetype = "dashed", 
             alpha = 0.9, linewidth = 0.5) +
  # Línea principal
  geom_line(linewidth = 0.7, alpha = 0.9) +
  facet_wrap(~entidad, scales = "free_y", ncol = 4) +
  scale_color_manual(values = rep(wes_palette("FantasticFox1"), length.out = 32)) +
  scale_x_continuous(breaks = seq(1970, 2070, by = 20)) +
  scale_y_continuous(labels = scales::label_number(scale = 1e-6, suffix = "M")) +
  labs(
    title = "Evolución de la población por entidad",
    subtitle = "Proyecciones 1970-2070",
    x = NULL,
    y = "Población (millones)",
    caption = " La línea punteada marca el primer año en el que hubo decrecimiento.
    Fuente: Proyecciones de población CONAPO"
  ) +
  theme_minimal(base_family = "sans", base_size = 10) +
  theme(
    plot.background = element_rect(fill = "#fafafa", color = NA),
    panel.background = element_rect(fill = "white", color = NA),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "gray95", linewidth = 0.3),
    plot.title = element_text(face = "bold", size = 16, 
                              margin = margin(b = 5), hjust = 0.5),
    plot.subtitle = element_text(size = 10, color = "gray30",
                                 margin = margin(b = 15), hjust = 0.5),
    plot.caption = element_text(color = "gray50", size = 8,
                                hjust = 1, margin = margin(t = 15)),
    strip.text = element_text(face = "bold", size = 9, 
                              margin = margin(b = 5)),
    strip.background = element_rect(fill = "gray95", color = NA),
    axis.text = element_text(size = 8),
    axis.title.y = element_text(size = 9, margin = margin(r = 10)),
    legend.position = "none",
    plot.margin = margin(20, 20, 20, 20),
    panel.spacing = unit(1, "lines")
  )


ggsave(filename = "03-output/evolucion-poblacion-entidad.png",
       width = 16,
       height = 8,
       dpi = 600,
       bg = "#fafafa")
