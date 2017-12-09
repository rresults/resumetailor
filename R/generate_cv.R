#' Generate CV
#' @import purrr
#' @import tibble
#' @import dplyr
#' @export

generate_cv <- function(jobs, tags, head, tail) {
  
  # Add position from item title
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
  
  
   
}