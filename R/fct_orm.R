#' orm
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @importFrom R6 R6Class
#' @noRd

CardORM <- R6::R6Class(
  classname = "CardORM",
  public = list(
    initialize = function(
  lat,
  long,
  title,
  description,
  image_path
    ) {
      # TODO: sanitize input
      card <- data.frame(
        lat = lat,
        long = long,
        title = title,
        description = description,
        image_path = image_path
      )
      self$card_bank <- rbind(
        card,
        self$card_bank
      )
    },
    card_bank = data.frame(
      lat = numeric(0),
      long = numeric(0),
      title = character(0),
      description = character(0),
      image_path = character(0)
    )
  )
)
