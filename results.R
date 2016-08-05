read_html("https://www.google.co.za/search?q=olympics+medal+count&oq=olympics+medal+co&aqs=chrome.0.0j69i57j0l4.6290j0j4&sourceid=chrome&ie=UTF-8#mie=oly%2C%5B%22%2Fm%2F03tnk7%22%2C1%2C%22m%22%2C1%2Cnull%2Cnull%2Cnull%2Cnull%2Cnull%2Cnull%2Cnull%2Cnull%2Cnull%2Cnull%2Cnull%2Cnull%2Cnull%2Cnull%2Cnull%2C0%5D") -> medal_count
medal_count_df <- medal_count %>% html_nodes("div") %>% html_table(trim = FALSE, fil = TRUE)


