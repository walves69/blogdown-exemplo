blogdown::serve_site()
blogdown::stop_server()


blogdown.subdir = 'posts'

blogdown::build_site()


blogdown::new_post(title = 'testando novo post cmd2')



blogdown::check_site()

blogdown::new_content(path = "content", open = interactive())
