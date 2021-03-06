#' Apportion CDI and MSSA records
#'
#' Apportions records to apportioning algorithm.
#' Includes a clause whereby records created prior to 26th October 2015 are not trust apportioned if patient location is Unknown.
#' This is to ensure consistency with previous reports. See p 47 of Mandatory Surveillance protocol.
#' Prior to the launch of the new DCS, users could create records where the patient location was Null and these cases would not have been apportioned automatically.
#'
#' @param collection The collection (MRSA, MSSA, CDI, E. coli) to which the record belongs.
#' @param patient_location The patient's location at time of sample
#' @param patient_category The patient's category at time of sample
#' @param date_admitted The date the patient was admitted for records from inpatients
#' @param specimen_date The date of the specimen (POSIXct, POSIXt or Date format)
#' @param date_entered Date record created normally 'data collection date' (POSIXct, POSIXt or Date format)
#' @return A binary vector giving 1 for Trust-apportioned records and 0 for non-Trust apportioned records
#' @examples
#' apportion("mssa", "NHS Acute Trust", "In-patient",
#' date_admitted = lubridate::dmy("01-01-2015"), specimen_date =
#' lubridate::dmy("05-01-2015"), date_entered = lubridate::dmy("26-10-2015"))
#' \dontrun{
#' apportion("mssa", "NHS Acute Trust", "In-patient",
#' date_admitted = as.Date(NA_real_, origin = "01-01-1970"),
#' specimen_date = lubridate::dmy("01-01-2015"), date_entered =
#' lubridate::dmy("26-10-2015"))
#' apportion("mssa", "NHS Acute Trust", "In-patient", date_admitted =
#' lubridate::dmy(""), specimen_date = lubridate::dmy("01-01-2015"),
#' date_entered = lubridate::dmy("26-10-2015"))
#' }
#' apportion("mssa", "NHS Acute Trust", "In-patient", date_admitted =
#' lubridate::dmy("01-01-2015"),  specimen_date = lubridate::dmy("01-01-2015"),
#' date_entered = lubridate::dmy("26-10-2015"))
#' apportion("mssa", "NHS Acute Trust", "Outpatient", date_admitted =
#' lubridate::dmy("01-01-2015"),  specimen_date = lubridate::dmy("05-01-2015"),
#' date_entered = lubridate::dmy("26-10-2015"))
#' apportion("cdi", "NHS Acute Trust", "In-patient", date_admitted =
#' lubridate::dmy("01-01-2015"),  specimen_date = lubridate::dmy("05-01-2015"),
#' date_entered = lubridate::dmy("26-10-2015"))
#' @export


apportion <- function (collection, patient_location, patient_category, date_admitted,
                       specimen_date, date_entered)
{
  if (!requireNamespace("lubridate", quietly = TRUE)) {
    stop("lubridate is needed for this function to work. Please install it.",
         call. = FALSE)
  }
  collection <- tolower(collection)
  assertthat::assert_that(assertthat::is.date(date_admitted))
  assertthat::assert_that(assertthat::is.date(specimen_date))
  assertthat::assert_that(assertthat::is.date(date_entered))
  assertthat::assert_that(all(collection %in%
                                c("mssa", "mrsa", "e. coli", "cdi",
                                  "c. difficile", "klebsiella spp",
                                  "klebsiella spp.", "pseudomonas aeruginosa", "p. aeruginosa")),
                          msg = "Collection must be one of MRSA, MSSA, E. coli, C. difficile,\n
                          CDI, Klebsiella spp, Pseudomonas aeruginosa or P. aeruginosa")
  if (length(collection) == 1) {
    collection <- rep(collection, length(patient_location))
  }
  trust <- ifelse(collection %in% c("mssa", "mrsa", "e. coli",
                                    "klebsiella spp", "klebsiella spp.", "pseudomonas aeruginosa", "p. aeruginosa"),
                  mssa_appt(patient_location, patient_category, date_admitted,
                            specimen_date, date_entered), cdi_appt(patient_location,
                                                                   patient_category, date_admitted, specimen_date,
                                                                   date_entered))
  return(trust)
}

mssa_appt <- function (patient_location, patient_category, date_admitted,
                       specimen_date, date_entered)
{
  trust_cats <- c("In-patient", "Day patient", "Emergency Assessment",
                  "Unknown", "", NA_character_)
  trust_locs <- c("NHS Acute Trust", "", NA_character_)
  z <- ifelse(is.na(date_admitted) == TRUE,
              ifelse((patient_location %in%
                        trust_locs |
                        (patient_location == "Unknown" & date_entered >= lubridate::dmy("26-10-2015"))) & (patient_category %in% trust_cats |
                                                                                                             is.na(patient_category)), 1, 0),
              ifelse((specimen_date - date_admitted + 1 >= 3) & (patient_location %in% trust_locs |
                                                                   (patient_location == "Unknown" & date_entered >= lubridate::dmy("26-10-2015"))) & patient_category %in% trust_cats, 1, 0))
  return(z)
}

cdi_appt <- function (patient_location, patient_category, date_admitted,
                      specimen_date, date_entered)
{
  trust_cats <- c("In-patient", "Day patient", "Emergency Assessment",
                  "Unknown", "", NA_character_)
  trust_locs <- c("NHS Acute Trust", "", NA_character_)
  z <- ifelse(is.na(date_admitted) == TRUE,
              ifelse((patient_location %in% trust_locs |
                        (patient_location == "Unknown" &
                           date_entered >= lubridate::dmy("26-10-2015"))) &
                       (patient_category %in% trust_cats | is.na(patient_category)), 1, 0),
              ifelse((specimen_date - date_admitted + 1 >= 4) & (patient_location %in% trust_locs |
                                                                   (patient_location == "Unknown" &
                                                                      date_entered >= lubridate::dmy("26-10-2015"))) &
                       patient_category %in% trust_cats, 1, 0))
  return(z)
}
