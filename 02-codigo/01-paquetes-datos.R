#Cargar paquetes
pacman::p_load(tidyverse, paletteer, reshape2, pals, wesanderson, ggtext)

#Cargar datos

poblacion <- readxl::read_excel("01-datos/Proyecciones-CONAPO-Pob_Mitad_1950_2070 (1).xlsx") %>% 
  janitor::clean_names()

pob_agrupada <- poblacion %>% 
  group_by(ano, entidad) %>% 
  mutate(total = sum(poblacion)) %>%
  ungroup() %>% 
  distinct(ano, entidad, total) %>% 
  filter(entidad != "República Mexicana")

pob_variacion <- pob_agrupada %>% 
  arrange(entidad) %>% 
  group_by(entidad) %>% 
  mutate(variacion_porcentual =((total - lag(total)) / lag(total)) *100)

#clipr::write_clip(pob_variacion)


#Análisis total República Mexicana 
republica <- poblacion %>% 
  filter(entidad == "República Mexicana") %>% 
  group_by(ano, entidad) %>% 
  mutate(total = sum(poblacion)) %>%
  distinct(ano, entidad, total) %>%  
  ungroup() %>% 
  arrange(ano) %>% 
  mutate(variacion_porcentual = ((total - lag(total)) / lag(total)) * 100)


