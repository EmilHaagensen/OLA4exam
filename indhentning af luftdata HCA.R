#############################################
### indhentning af luft data for HCA BLVD ### 
#############################################


    # step 1 get request for at få header + csrf token

get_response.HCA <- GET("https://envs2.au.dk/Luftdata/Presentation/table/Copenhagen/HCAB")

response_headers.HCA <- headers(get_response.HCA)


formatted_headers.HCA <- c(
  "content-type" = response_headers.HCA$`content-type`,
  "content-length" = response_headers.HCA$`content-length`,
  "cache-control" = response_headers.HCA$`cache-control`,
  "server" = response_headers.HCA$server,
  "x-aspnet-version" = response_headers.HCA$`x-aspnet-version`,
  "x-aspnetmvc-version" = response_headers.HCA$`x-aspnetmvc-version`,
  "x-frame-options" = response_headers.HCA$`x-frame-options`,
  "x-powered-by" = response_headers.HCA$`x-powered-by`,
  "date" = response_headers.HCA$date
)

print(response_headers.HCA)

pagecontent.HCA =content(get_response.HCA,"text")
print(pagecontent.HCA)

page_html.HCA <- read_html(pagecontent.HCA)
csrf_token.HCA <- html_attr(html_node(page_html.HCA, 'input[name="__RequestVerificationToken"]'), "value")

purl.HCA = "https://envs2.au.dk/Luftdata/Presentation/table/MainTable/Copenhagen/HCAB"

payload.HCA <- list(
  `__RequestVerificationToken` = csrf_token.HCA
)

post_response.HCA = POST(
  url = purl.HCA,
  body = payload.HCA,
  encode = "form",
  headers = formatted_headers.HCA
)

post_response.HCA$status_code

page_content.HCA = content(post_response.HCA, "text")

page_content_html.HCA = read_html(page_content.HCA)

html_structure(page_content_html.HCA)

table.HCA <- page_content_html.HCA %>%
  html_node("table") %>%  # If there is a specific table, refine selector, e.g., "table#id" or "table.class"
  html_table()

  # dag senere
table.HCA2 <- page_content_html.HCA %>%
  html_node("table") %>%  # If there is a specific table, refine selector, e.g., "table#id" or "table.class"
  html_table()

