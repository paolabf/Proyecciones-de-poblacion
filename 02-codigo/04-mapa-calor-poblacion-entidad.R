source("02-codigo/02-grafica-años-con-decrecimiento.R")

#Hacer mapa de calor por entidad y año 

pob_variacion %>%
  left_join(primer_decrecimiento, by = "entidad") %>%
  ggplot(aes(x = ano, y = reorder(entidad, primer_ano), fill = variacion_porcentual)) +
  geom_tile(color = "black", linewidth = 0.2) +
  scale_fill_gradientn(
    colors = c("#08306b", "#2171b5", "#6baed6", "white", 
               "#fcbba1", "#fc9272", "#fb6a4a", "#de2d26", "#a50f15"),
    values = scales::rescale(c(-2, -1, -0.5, 0, 0.5, 1, 3, 6, 11)),
    limits = c(-2, 11),
    breaks = seq(-2, 10, by = 2),
    labels = function(x) paste0(x, "%"),
    name = "Variación\nanual"
  ) +
  scale_x_continuous(
    breaks = seq(1970, 2070, by = 10),
    minor_breaks = seq(1970, 2070, by = 5),
    expand = c(0, 0)
  ) +
  scale_y_discrete(expand = c(0, 0)) +
  labs(
    title = "Variación porcentual de la población por entidad",
    subtitle = "Del crecimiento (rojo) al decrecimiento (azul) • 1970-2070",
    x = NULL,
    y = NULL,
    caption = "Fuente: CONAPO Conciliación Demográfica de 1950 a 2019 y Proyecciones de la población 2020 - 2070, mitad de año"
  ) +
  theme_minimal(base_family = "sans", base_size = 10) +
  theme(
    plot.background = element_rect(fill = "#fafafa", color = NA),
    panel.background = element_rect(fill = NA, color = NA),
    panel.grid = element_blank(),
    plot.title = element_text(face = "bold", size = 16, 
                              margin = margin(b = 5), hjust = 0.5),
    plot.subtitle = element_text(size = 10, color = "gray30",
                                 margin = margin(b = 15), hjust = 0.5),
    plot.caption = element_text(color = "gray50", size = 8,
                                hjust = 1, margin = margin(t = 15)),
    axis.text.x = element_text(angle = 0, hjust = 0.5, size = 9),
    axis.text.y = element_text(size = 9),
    axis.ticks = element_blank(),
    legend.position = "right",
    legend.title = element_text(size = 9, face = "bold"),
    legend.text = element_text(size = 8),
    legend.key.height = unit(1.5, "cm"),
    legend.key.width = unit(0.5, "cm"),
    plot.margin = margin(20, 20, 20, 20)
  )


ggsave(filename = "03-output/mapa-de-calor-evolucion-poblacion-entidad.png",
       width = 6012,
       height = 3006,
       units = "px",
       dpi = 300,
       bg = "#fafafa")
