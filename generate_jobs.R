source("R/functions.R")

tags <- c("train", "research", "it", "floss", "r")
cv_file <- "source/jobs.md"
files <- c("head.md", "jobs.md", "tail.md")
jobs <- yaml::yaml.load_file("source/jobs.yaml")


dir <- dirname(cv_file)
jobs <- map2(jobs, names(jobs), 
             function(position, name) {
               position["position"] <- name
               position
             })

# Filter jobs by tags

selected_jobs <- jobs %>% 
  filter_positions(tags) %>%
  map(function(position, tags) {
    position$results <- filter_results(position$results, tags)
    position
  }, tags = tags) %>% 
  map(function(position, tags) {
    position$results <- map(position$results,
                            filter_tags, tags = tags)
    position
  }, tags = tags)


# Calculate position value
selected_jobs <- selected_jobs %>% 
  map(function(position) {
    position$value <- position_total_value(position)
    position
  }) 

jobs_value <- selected_jobs %>% 
  map_dbl(pluck("value")) 

time_dist <- selected_jobs %>%
  map(pluck("period")) %>%
  map_dbl(~ year(today()) - year(ymd(.x[2])) + 1) 
  
jobs_order <- tibble(job = names(jobs_value), 
                     value = jobs_value) %>% 
  left_join(tibble(job = names(time_dist),
                   years = time_dist), 
            by = "job") %>% 
  mutate(order = value / (years * 4)) %>% 
  arrange(desc(order)) %>% 
  pluck("job")

selected_jobs <- selected_jobs[jobs_order]

# Calculate each result value

selected_jobs <- selected_jobs %>% 
  map(function(position) {
    results <- map_dfr(position$results, 
                   function(rez) tibble(
                     result = names(rez),
                     value = result_total_value(rez)))
    
    results_order <- results %>% 
      arrange(desc(value)) %>% 
      pluck("result")
    
    position$results_ord <- results_order
    position
  }) 


# Build markdown file

if (file.exists(cv_file)) file.remove(cv_file) 

selected_jobs %>% 
  walk(function(p) {
    add_elem(p$position, 
             nafter = 0,
             symbefore = "#### ", 
             symafter = " at ")
    add_elem(p$org, nbefore = 0, nafter = 2)
    add_elem(pluck(p, "period", 1) %>% 
               lubridate::ymd() %>% 
               format("%Y %B"), 
             symafter = " - ", 
             nafter = 0)
    add_elem(pluck(p, "period", 2) %>% 
               lubridate::ymd() %>% 
               format("%Y %B"), 
             symafter = ". ",
             nbefore = 0,
             nafter = 0)
    add_elem(p$desc, nbefore = 0, nafter = 2, symafter = ". ")
    # walk(pluck(p, "results"), 
    #      ~ add_elem(names(.x),
    #                 nbefore = 0,
    #                 symbefore = "  * ", 
    #                 symafter = ". "))
    walk(pluck(p, "results_ord"),
         ~ walk(.x, 
                ~ add_elem(.x, symbefore = "  * ", symafter = ".", 
         nafter = 1,
         nbefore = 0)))
    })

 # browseURL(generate_pdf("markdown-cv"))

