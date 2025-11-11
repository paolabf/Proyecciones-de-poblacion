source("02-codigo/01-paquetes-datos.R")

#Calcular el primer año de decrecimiento por entidad
primer_decrecimiento <- pob_variacion %>%
  filter(variacion_porcentual < 0) %>%
  group_by(entidad) %>%
  summarise(primer_ano = min(ano))


# Calcular el primer año de decrecimiento por entidad
primer_decrecimiento <- pob_variacion %>%
  filter(variacion_porcentual < 0) %>%
  group_by(entidad) %>%
  summarise(primer_ano = min(ano))

pob_variacion %>%
  filter(variacion_porcentual < 0, 
         ano > 1979) %>%
  left_join(primer_decrecimiento, by = "entidad") %>%
  ggplot(aes(x = ano, y = reorder(entidad, primer_ano))) +
  # Líneas de fondo para guiar la vista
  geom_segment(aes(x = min(ano), xend = max(ano), 
                   y = entidad, yend = entidad),
               color = "gray90", linewidth = 0.3) +
  # Puntos de decrecimiento
  geom_point(color = "#46818E", size = 2, alpha = 0.7) +
  # Marcar el primer año de decrecimiento
  geom_point(data = . %>% filter(ano == primer_ano),
             color = "#DD8D29", size = 4) +
  scale_x_continuous(breaks = seq(1980, 2070, by = 5),
                     minor_breaks = seq(1980, 2070, by = 5),
                     limits = c(1980, 2072)) +
  # Etiquetas
  labs(
    title = "El declive poblacional en México",
    subtitle = "Años con decrecimiento poblacional por entidad",
    x = NULL,
    y = NULL,
    caption = "Nota: El punto grande marca el primer año de decrecimiento\nFuente: CONAPO Conciliación Demográfica de 1950 a 2019 y Proyecciones de la población 2020 - 2070, mitad de año"
  ) +
  # Tema
  theme_minimal(base_family = "sans", base_size = 11) +
  theme(
    # Fondo y grilla
    plot.background = element_rect(fill = "#fafafa", color = NA),
    panel.grid.major.y = element_blank(),
    panel.grid.minor.x = element_line(color = "gray95", linewidth = 0.3),
    panel.grid.major.x = element_line(color = "gray90", linewidth = 0.5),
    
    # Títulos
    plot.title = element_text(face = "bold", size = 16, 
                              margin = margin(b = 5), hjust = 0.5),
    plot.subtitle = element_text(size = 11, color = "gray30",
                                 margin = margin(b = 15), hjust = 0.5),
    plot.caption = element_text(color = "gray50", size = 8,
                                hjust = 1, margin = margin(t = 15),
                                lineheight = 1.3),
    
    # Ejes
    axis.text.y = element_text(size = 9),
    axis.text.x = element_text(size = 9),
    
    # Márgenes
    plot.margin = margin(20, 20, 20, 20)
  )

ggsave(filename = "03-output/decrecimiento_poblacional_mexico.png",
       width = 6012,
       height = 3006,
       units = "px",
       dpi = 300,
       bg = "#fafafa")
