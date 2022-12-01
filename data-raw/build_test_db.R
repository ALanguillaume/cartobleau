library(DBI)

test_db <- dbConnect(RSQLite::SQLite(), "my-db.sqlite")

lorem_ipsum <- paste(
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit,",
  "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi",
  "ut aliquip ex ea commodo consequat.",
  "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore",
  "eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,",
  "sunt in culpa qui officia deserunt mollit anim id est laborum."
)

l_card_template <- list(
  data.frame(
    lat = 48.3773651432161,
    long = 2.81810581684113,
    title = "Une péniche",
    description = lorem_ipsum,
    raw_image_path = "./data-raw/images/halte_fluviale_msl.jpg"
  ),
  data.frame(
    lat = 48.3739942801645,
    long = 2.81742453575134,
    title = "Un camion de pompier",
    description = lorem_ipsum,
    raw_image_path = "./data-raw/images/caserne_msl.jpg"
  ),
  data.frame(
    lat = 48.3719488485481,
    long = 2.81808435916901,
    title = "Une église",
    description = lorem_ipsum,
    raw_image_path = "./data-raw/images/eglise_msl.jpg"
  )
)

# Add id column by computing md5

df_card_template <- lapply(
  l_card_template,
  function(df) {
    df[["id"]] <- digest::digest(
      object = df,
      algo = "md5"
    )
    return(df)
  }
) |> Reduce(rbind, x = _)


file.copy(
  from = df_card_template[["raw_image_path"]],
  to = "inst/images/"
)
file.rename(
  from = file.path(
    "inst/images/",
    basename(df_card_template[["raw_image_path"]])
  ),
  to = file.path(
    "inst/images/",
    paste0(df_card_template[["id"]], ".jpg")
  )
)

dbWriteTable(
  conn = test_db,
  name = "data",
  value = df_card_template
)
dbDisconnect(test_db)
