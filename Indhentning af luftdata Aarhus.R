#############################################
### indhentning af luft data for Aarhus ### 
#############################################


# step 1 get request for at få header + csrf token

get_response.ah <- GET("https://envs2.au.dk/Luftdata/Presentation/table/Aarhus/AARH3")

response_headers.ah <- headers(get_response.ah)


formatted_headers.ah <- c(
  "content-type" = response_headers.ah$`content-type`,
  "content-length" = response_headers.ah$`content-length`,
  "cache-control" = response_headers.ah$`cache-control`,
  "server" = response_headers.ah$server,
  "x-aspnet-version" = response_headers.ah$`x-aspnet-version`,
  "x-aspnetmvc-version" = response_headers.ah$`x-aspnetmvc-version`,
  "x-frame-options" = response_headers.ah$`x-frame-options`,
  "x-powered-by" = response_headers.ah$`x-powered-by`,
  "date" = response_headers.ah$date
)

print(response_headers.ah)

pagecontent.ah =content(get_response.ah,"text")
print(pagecontent.ah)

page_html.ah <- read_html(pagecontent.ah)
csrf_token.ah <- html_attr(html_node(page_html.ah, 'input[name="__RequestVerificationToken"]'), "value")

purl.ah = "https://envs2.au.dk/Luftdata/Presentation/table/MainTable/Aarhus/AARH3"

payload.ah <- list(
  `__RequestVerificationToken` = csrf_token.ah
)

post_response.ah = POST(
  url = purl.ah,
  body = payload.ah,
  encode = "form",
  headers = formatted_headers.ah
)

post_response.ah$status_code

page_content.ah = content(post_response.ah, "text")

page_content_html.ah = read_html(page_content.ah)

html_structure(page_content_html.ah)

table.ah <- page_content_html.ah %>%
  html_node("table") %>%  # If there is a specific table, refine selector, e.g., "table#id" or "table.class"
  html_table()

    ## dag senere; samme kode ny tabel

table.ah2 <- page_content_html.ah %>%
  html_node("table") %>%  # If there is a specific table, refine selector, e.g., "table#id" or "table.class"
  html_table()


