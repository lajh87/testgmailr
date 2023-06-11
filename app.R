#' This script sends an email from a gmail account using a shiny app.
# Create the api instance following instructions
# https://developers.google.com/gmail/api/quickstart/python
# Follow https://gmailr.r-lib.org/articles/gmailr.html
# Then follow 
# https://stackoverflow.com/questions/60507013/gmailr-without-selecting-a-pre-authorised-account-in-r/62651398#62651398


library(shiny)
library(gmailr)

# gm_auth_configure(path  = Sys.getenv("GMAILR_APP"))
# gm_auth(email = TRUE, cache = ".secret")

gm_auth_configure(path  = Sys.getenv("GMAILR_APP"))
options(
  gargle_oauth_cache = ".secret",
  gargle_oauth_email = Sys.getenv("GMAILR_EMAIL")
)
gm_auth(email = Sys.getenv("GMAILR_EMAIL"))


ui <- fluidPage(
  actionButton("sendmail", "Send")
)

server <- function(input, output, session) {
  
  observeEvent(input$sendmail, {
    test_email <-
      gm_mime() %>%
      gm_to("lajh87@me.com") %>%
      gm_from(Sys.getenv("GMAILR_EMAIL")) %>%
      gm_subject("this is just a gmailr test") %>%
      gm_text_body("Can you hear me now?")
    
    # # Verify it looks correct
    # gm_create_draft(test_email)
    
    # If all is good with your draft, then you can send it
    gm_send_message(test_email)
  }, ignoreInit = TRUE)
  
}

shinyApp(ui, server)
