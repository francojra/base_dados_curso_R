
# Base de dados - Curso R ------------------------------------------------------------------------------------------------------------------
# Autoria do script: Jeanne Franco ---------------------------------------------------------------------------------------------------------
# Data: 02/07/22 ---------------------------------------------------------------------------------------------------------------------------
# Referência: https://blog.curso-r.com/posts/2022-06-11-bases-de-dados/ --------------------------------------------------------------------

# Baixar pacote ----------------------------------------------------------------------------------------------------------------------------

library("devtools")
devtools::install_github("curso-r/basesCursoR")

# Identificar bases disponíveis ------------------------------------------------------------------------------------------------------------

basesCursoR::bases_disponiveis()

# Carregar base do pacote ------------------------------------------------------------------------------------------------------------------

pokemon <- basesCursoR::pegar_base("pokemon")
dplyr::glimpse(pokemon)
View(pokemon)

# Análises ---------------------------------------------------------------------------------------------------------------------------------

library(magrittr)

pok <- pokemon %>%
  dplyr::select(altura, peso, tipo_1) %>%
  dplyr::filter(tipo_1 %in% c("grama", "inseto", "terrestre", "elétrico",
                              "lutador", "psíquico", "água"))

View(pok)

library(ggplot2)

ggplot(pok, aes(x = tipo_1, y = altura)) +
  geom_boxplot()

ggplot(pok, aes(x = tipo_1, y = peso)) +
  geom_boxplot()

library(dplyr)

pok1 <- pok %>%
  group_by(tipo_1) %>%
  summarise(media_alt = mean(altura), media_peso = mean(peso))

ggplot(pok1, aes(x = tipo_1, y = media_alt)) +
  geom_col()

ggplot(pok1, aes(x = tipo_1, y = media_peso)) +
  geom_col()

pok2 <- pok %>%
  group_by(tipo_1) %>%
  summarise(media_alt = mean(altura), media_peso = mean(peso),
            sd_alt = sd(altura), sd_peso = sd(peso),
            n_alt = n(), se_alt = sd_alt / sqrt(n_alt),
            n_peso = n(), se_peso = sd_peso / sqrt(n_peso))

ggplot(pok2, aes(x = tipo_1, y = media_alt)) +
  geom_col() +
  geom_errorbar(aes(x = tipo_1, y = media_alt,
                    ymax = media_alt + se_alt, ymin = media_alt - se_alt),
                    width = 0.2)

ggplot(pok2, aes(x = tipo_1, y = media_peso)) +
  geom_col() +
  geom_errorbar(aes(x = tipo_1, y = media_peso,
                    ymax = media_peso + se_peso, ymin = media_peso - se_peso),
                    width = 0.2)

library(forcats)

ggplot(pok2, aes(x = fct_reorder(tipo_1, media_alt), y = media_alt)) +
  geom_col() +
  geom_errorbar(aes(x = tipo_1, y = media_alt,
                    ymax = media_alt + se_alt, ymin = media_alt - se_alt),
                    width = 0.2)

ggplot(pok2, aes(x = fct_reorder(tipo_1, media_peso), y = media_peso)) +
  geom_col() +
  geom_errorbar(aes(x = tipo_1, y = media_peso,
                    ymax = media_peso + se_peso, ymin = media_peso - se_peso),
                    width = 0.2)
