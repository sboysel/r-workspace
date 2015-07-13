# Retrieve and Load Data ------------------------------------------------------

# FUNCTIONS -------------------------------------------------------------------
get_data(url, destfile, unpack = NULL) {
  if (!file.exists(destfile)) {
    print("Fetching...")
    download.file(url = url,
                  destfile = destfile)
  }
  if (!is.null(unpack)) {
    print("Unpacking...")
    if (unpack == "zip") {
      unzip(zipfile = destfile,
            overwrite = TRUE)
    } else if (unpack == "gz") {
      untar(tarfile = destfile)
    } else {
      stop("Supported methods include 'zip' and 'gz'.")
    }
  }
}

# MAIN ------------------------------------------------------------------------
get_data(url = some.url,
         destfile = some.destfile,
         unpack = "zip")
