#############################################
### indhentning af luft data for Risø ### 
#############################################


# step 1 get request for at få header + csrf token

get_response.risø <- GET("https://envs2.au.dk/Luftdata/Presentation/table/Rural/RISOE")

response_headers.risø <- headers(get_response.risø)


formatted_headers.risø <- c(
  "content-type" = response_headers.risø$`content-type`,
  "content-length" = response_headers.risø$`content-length`,
  "cache-control" = response_headers.risø$`cache-control`,
  "server" = response_headers.risø$server,
  "x-aspnet-version" = response_headers.risø$`x-aspnet-version`,
  "x-aspnetmvc-version" = response_headers.risø$`x-aspnetmvc-version`,
  "x-frame-options" = response_headers.risø$`x-frame-options`,
  "x-powered-by" = response_headers.risø$`x-powered-by`,
  "date" = response_headers.risø$date
)

print(response_headers.risø)

pagecontent.risø =content(get_response.risø,"text")
print(pagecontent.risø)

page_html.risø <- read_html(pagecontent.risø)
csrf_token.risø <- html_attr(html_node(page_html.risø, 'input[name="__RequestVerificationToken"]'), "value")

purl.risø = "https://envs2.au.dk/Luftdata/Presentation/table/MainTable/Rural/RISOE"

payload.risø <- list(
  `__RequestVerificationToken` = csrf_token.risø
)

post_response.risø = POST(
  url = purl.risø,
  body = payload.risø,
  encode = "form",
  headers = formatted_headers.risø
)

post_response.risø$status_code

page_content.risø = content(post_response.risø, "text")

page_content_html.risø = read_html(page_content.risø)

html_structure(page_content_html.risø)

table.risø <- page_content_html.risø %>%
  html_node("table") %>%  # If there is a specific table, refine selector, e.g., "table#id" or "table.class"
  html_table()

    # dag senere

table.risø2 <- page_content_html.risø %>%
  html_node("table") %>%  # If there is a specific table, refine selector, e.g., "table#id" or "table.class"
  html_table()

