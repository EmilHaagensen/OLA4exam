#############################################
### indhentning af luft data for ANHOLT ### 
#############################################


# step 1 get request for at få header + csrf token

get_response.Anholt <- GET("https://envs2.au.dk/Luftdata/Presentation/table/Rural/ANHO")

response_headers.Anholt <- headers(get_response.Anholt)


formatted_headers.Anholt <- c(
  "content-type" = response_headers.Anholt$`content-type`,
  "content-length" = response_headers.Anholt$`content-length`,
  "cache-control" = response_headers.Anholt$`cache-control`,
  "server" = response_headers.Anholt$server,
  "x-aspnet-version" = response_headers.Anholt$`x-aspnet-version`,
  "x-aspnetmvc-version" = response_headers.Anholt$`x-aspnetmvc-version`,
  "x-frame-options" = response_headers.Anholt$`x-frame-options`,
  "x-powered-by" = response_headers.Anholt$`x-powered-by`,
  "date" = response_headers.Anholt$date
)

print(response_headers.Anholt)

pagecontent.Anholt =content(get_response.Anholt,"text")
print(pagecontent.Anholt)

page_html.Anholt <- read_html(pagecontent.Anholt)
csrf_token.Anholt <- html_attr(html_node(page_html.Anholt, 'input[name="__RequestVerificationToken"]'), "value")

purl.Anholt = "https://envs2.au.dk/Luftdata/Presentation/table/MainTable/Rural/ANHO"

payload.Anholt <- list(
  `__RequestVerificationToken` = csrf_token.Anholt
)

post_response.Anholt = POST(
  url = purl.Anholt,
  body = payload.Anholt,
  encode = "form",
  headers = formatted_headers.Anholt
)

post_response.Anholt$status_code

page_content.Anholt = content(post_response.Anholt, "text")

page_content_html.Anholt = read_html(page_content.Anholt)

html_structure(page_content_html.Anholt)

table.Anholt <- page_content_html.Anholt %>%
  html_node("table") %>%
  html_table()

  # dag senere
table.Anholt2 <- page_content_html.Anholt %>%
  html_node("table") %>%
  html_table()








