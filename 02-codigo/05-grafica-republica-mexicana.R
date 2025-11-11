source("02-codigo/01-codigo.R")

# Identificar períodos clave
pico_poblacion <- republica %>% slice_max(total, n = 1)
inicio_decrecimiento <- republica %>% 
  filter(variacion_porcentual < 0) %>% 
  slice_min(ano, n = 1)

republica %>%
  ggplot(aes(x = ano, y = total)) +
  # Área bajo la curva con gradiente
  geom_ribbon(aes(ymin = 0, ymax = total), 
              fill = "#DD8D29", alpha = 0.15) +
  # Línea principal más gruesa
  geom_line(color = "#DD8D29", linewidth = 1.5, alpha = 0.9) +
  # Marcar el pico poblacional
  geom_point(data = pico_poblacion, 
             aes(x = ano, y = total),
             color = "#E15759", size = 4, shape = 21, 
             fill = "white", stroke = 2) +
  # Línea vertical en el inicio del decrecimiento
  geom_vline(data = inicio_decrecimiento,
             aes(xintercept = ano),
             color = "#E15759", linetype = "dashed", 
             linewidth = 1, alpha = 0.7) +
  # Anotación del pico
  annotate("text", 
           x = pico_poblacion$ano, 
           y = pico_poblacion$total * 1.05,
           label = paste0("Pico poblacional\n", 
                          round(pico_poblacion$total/1e6, 1), "M hab.",
                          ")"),
           size = 3.5, fontface = "bold", color = "#E15759") +
  # Anotación del decrecimiento
  annotate("text",
           x = inicio_decrecimiento$ano + 5,
           y = max(republica$total) * 0.3,
           label = paste0("Inicio del\ndecrecimiento\n(", inicio_decrecimiento$ano, ")"),
           size = 3.5, fontface = "bold", color = "#E15759",
           hjust = 0) +
  scale_x_continuous(breaks = seq(1950, 2070, by = 10),
                     expand = c(0.02, 0)) +
  scale_y_continuous(labels = scales::label_number(scale = 1e-6, suffix = "M"),
                     expand = c(0, 0),
                     limits = c(0, max(republica$total) * 1.12)) +
  labs(
    title = "La transición demográfica de México",
    x = NULL,
    y = "Población (millones de habitantes)",
    caption = "Fuente: CONAPO Conciliación Demográfica de 1950 a 2019 y Proyecciones de la población 2020 - 2070, mitad de año"
  ) +
  theme_minimal(base_family = "sans", base_size = 13) +
  theme(
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "#fafafa", color = NA),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_line(color = "white", linewidth = 0.8),
    plot.title = element_text(face = "bold", size = 20, 
                              margin = margin(b = 8), hjust = 0.5),
    plot.subtitle = element_text(size = 12, color = "gray40",
                                 margin = margin(b = 20), lineheight = 1.3),
    plot.caption = element_text(color = "gray50", size = 9,
                                margin = margin(t = 20)),
    axis.text = element_text(size = 11),
    axis.title.y = element_text(size = 12, margin = margin(r = 15), 
                                face = "bold"),
    plot.margin = margin(25, 25, 25, 25)
  )

ggsave(filename = "03-output/global-México.png",
       width = 6012,
       height = 3006,
       units = "px",
       dpi = 300,
       bg = "#fafafa")