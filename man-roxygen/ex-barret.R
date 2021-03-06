
ir <- iris
ir$glyph_val <- as.numeric(ir$Species)
ir$glyph_col <- c("red", "green", "blue")[ ir$glyph_val ]
ir$random_group <- sample(c("A", "B"), nrow(ir), replace = TRUE)

rescale <- function(x) {
  (x - min(x)) / diff(range(x))
}

b_fig <- figure(width = 480*1.5,height = 520*1.5)

# test evaluation function
(test_b_eval = function(){
  match_val = ir$Species
  attr(match_val, "stringName") <- "Species"
  load_all(); require(testthat); require(lazyeval)
  b <- b_eval(ir); a <- function(x){ b(lazy(x)) };
  col = 5; expect_equivalent(a(col), 5)
  expect_equivalent(a("Species"), match_val)
  z = "Species"; expect_equivalent(a(z), match_val)
  z = I("Species"); expect_equivalent(a(z), I("Species"))
  expect_equivalent(a(Species), match_val)
  expect_error(a(DOES_NOT_EXIST))

  TRUE
})()


# ly_points
load_all(); b_fig %>% ly_points(ir$Sepal.Length) -> a; a
load_all(); b_fig %>% ly_points(Sepal.Length, data = ir) -> a; a
load_all(); b_fig %>% ly_points(Sepal.Length, data = ir, color = glyph_col) -> a; a
load_all(); b_fig %>% ly_points(Sepal.Length, data = ir, glyph = glyph_val, hover = Species) -> a; a
load_all(); b_fig %>% ly_points(Sepal.Length, data = ir, color = Species) -> a; a

# ly_annular_wedge
load_all(); b_fig %>% ly_annular_wedge(Sepal.Length, Sepal.Width, data = iris, end_angle = rescale(Petal.Length)*2*pi, inner_radius = 0.1, outer_radius = 0.15, alpha = 0.5, hover = Species, color = Species) -> a; a

# ly_annulus
# Hover does not work.  It did not work beforehand
load_all(); b_fig %>% ly_annulus(Sepal.Length, Sepal.Width, data = ir, inner_radius = 0.1, outer_radius = 0.15, alpha = 0.5, hover = Species) -> a; a
load_all(); b_fig %>% ly_annulus(Sepal.Length, Sepal.Width, data = ir, inner_radius = 0.1, outer_radius = 0.15, alpha = 0.5, hover = Species, color = Species) -> a; a


# ly_arc
load_all(); b_fig %>% ly_arc(Sepal.Length, Sepal.Width, data = ir, end_angle = rescale(Petal.Length)*2*pi, color = Species, alpha = 0.5) -> a; a

# ly_wedge
load_all(); b_fig %>% ly_wedge(Sepal.Length, Sepal.Width, data = ir, end_angle = rescale(Petal.Length)*2*pi, color = Species, radius = 0.15, alpha = 0.5, hover = Species) -> a; a




xx <- rnorm(10000)
yy <- rnorm(10000)

# ly_polygon
load_all(); b_fig %>% ly_hexbin(xx, yy) -> a; a


# ly_crect, # ly_text
a <- function() {
  warn_original <- options()$warn

  options(warn = 1)
  load_all()
  options(warn = 2)

  p <- figure(title = "Periodic Table", tools = c("resize", "hover"),
    ylim = as.character(c(7:1)), xlim = as.character(1:18),
    xgrid = FALSE, ygrid = FALSE, xlab = "", ylab = "",
    height = 600, width = 1200) %>%

  # plot rectangles
  ly_crect(group, period, data = elements, 0.9, 0.9,
    fill_color = color, line_color = color, fill_alpha = 0.6,
    hover = list(name, atomic.number, type, atomic.mass,
      electronic.configuration)) %>%

  # add symbol text
  ly_text(symx, period, text = symbol, data = elements,
    font_style = "bold", font_size = "15pt",
    align = "left", baseline = "middle") %>%

  # add atomic number text
  ly_text(symx, numbery, text = atomic.number, data = elements,
    font_size = "9pt", align = "left", baseline = "middle") %>%

  # add name text
  ly_text(symx, namey, text = name, data = elements,
    font_size = "6pt", align = "left", baseline = "middle") %>%

  # add atomic mass text
  ly_text(symx, massy, text = atomic.mass, data = elements,
    font_size = "6pt", align = "left", baseline = "middle")

  options(warn = warn_original)

  p
}; a()


# ly_oval
# legend looks funny
load_all(); b_fig %>% ly_oval(Sepal.Length, Sepal.Width, data = ir, color = Species, alpha = 0.5) -> a; a

# ly_patch
# color doesn't work
load_all(); b_fig %>% ly_patch(Sepal.Length, Sepal.Width, data = ir, color = Species, alpha = 0.5) -> a; a
load_all(); b_fig %>% ly_patch(Sepal.Length, Sepal.Width, data = ir, color = "blue", alpha = 0.5) -> a; a





# ly_bar
load_all(); b_fig %>% ly_bar(variety, yield, data = lattice::barley) %>% theme_axis("x", major_label_orientation = 90) -> a; a



# ly_image_url
# the top half of the R is being cut off. :-(
a <- function() {
  load_all()
  url <- c("http://bokeh.pydata.org/en/latest/_static/bokeh-transparent.png",
    "http://developer.r-project.org/Logo/Rlogo-4.png")

  ss <- seq(0, 2*pi, length = 13)[-1]
  ws <- runif(12, 2.5, 5) * rep(c(1, 0.8), 6)

  imgdat <- data.frame(
    x = sin(ss) * 10, y = cos(ss) * 10,
    w = ws, h = ws * rep(c(1, 0.76), 6),
    image_url = rep(url, 6)
  )

  p <- figure(xlab = "x", ylab = "y") %>%
    ly_image_url(x, y, w = w, h = h, image_url = image_url, data = imgdat,
      anchor = "center") %>%
    ly_lines(sin(c(ss, ss[1])) * 10, cos(c(ss, ss[1])) * 10,
      width = 15, alpha = 0.1)
  p
}; a()


# ly_image, ly_contour
load_all(); figure(xlim = c(0, 1), ylim = c(0, 1), title = "Volcano") %>% ly_image(volcano) %>% ly_contour(volcano) -> a; a


# ly_lines, ly_abline
a <- function() {
  load_all()
  z <- lm(Sepal.Width ~ Sepal.Length, data = ir)
  ir_lowess <- list(
    lowess(ir[ir$Species == "setosa" & ir$random_group == "A", c("Sepal.Length", "Sepal.Width")]),
    lowess(ir[ir$Species == "setosa" & ir$random_group == "B", c("Sepal.Length", "Sepal.Width")]),
    lowess(ir[ir$Species == "versicolor" & ir$random_group == "A", c("Sepal.Length", "Sepal.Width")]),
    lowess(ir[ir$Species == "versicolor" & ir$random_group == "B", c("Sepal.Length", "Sepal.Width")]),
    lowess(ir[ir$Species == "virginica" & ir$random_group == "A", c("Sepal.Length", "Sepal.Width")]),
    lowess(ir[ir$Species == "virginica" & ir$random_group == "B", c("Sepal.Length", "Sepal.Width")])
  )
  lowess_dt <- data.frame(
    x = unlist(lapply(ir_lowess, "[[", "x")),
    y = unlist(lapply(ir_lowess, "[[", "y")),
    Species = rep(rep(c("setosa", "versicolor", "virginica"), each = 2), times = unlist(lapply(lapply(ir_lowess, "[[", "x"), length))),
    random_group = rep(rep(c("A", "B"), 3), times = unlist(lapply(lapply(ir_lowess, "[[", "x"), length)))
  )
  lowess_dt$lowess_color <- paste(lowess_dt$Species, lowess_dt$random_group, sep = ":")

  b_fig %>%
    ly_points(Sepal.Length, Sepal.Width, color = Species, hover = Species, glyph = random_group, data = ir) %>%
    ly_lines(x, y, color = Species, group = random_group, data = lowess_dt) %>%
    ly_abline(z, type = 2, legend = "lm", width = 2)
}; a()


# ly_curve
chippy <- function(x) sin(cos(x)*exp(-x/2))
load_all(); b_fig %>% ly_curve(chippy, -8, 7, n = 2001) -> a; a

# ly_ray
load_all(); b_fig %>% ly_ray(Sepal.Length, Sepal.Width, data = ir, length = runif(150), angle = runif(150, max = 2 * pi), color = Species) %>% ly_points(Sepal.Length, Sepal.Width, data = ir, color = Species) -> a; a

# ly_bezier
a <- function() {
  load_all()

  b_fig %>%
    ly_bezier(
      x0 = Sepal.Length,
      x1 = Sepal.Length + runif(150),
      cx0 = Sepal.Length + runif(150),
      cx1 = Sepal.Length + runif(150),
      y0 = Sepal.Width,
      y1 = Sepal.Width + runif(150),
      cy0 = Sepal.Width + runif(150),
      cy1 = Sepal.Width + runif(150),
      color = Species,
      data = ir,
    ) %>%
    ly_points(Sepal.Length, Sepal.Width, data = ir, color = Species)

}; a()

# ly_quadratic
a <- function() {
  load_all()
  b_fig %>%
    ly_quadratic(
      x0 = Sepal.Length,
      x1 = Sepal.Length + runif(150),
      cx = Sepal.Length + runif(150),
      y0 = Sepal.Width,
      y1 = Sepal.Width + runif(150),
      cy = Sepal.Width + runif(150),
      color = Species,
      data = ir,
    ) %>%
    ly_points(Sepal.Length, Sepal.Width, data = ir, color = Species)

}; a()


# ly_multi_line
a <- function() {
  load_all()

  xs <- list()
  ys <- list()
  for (i in 1:500) {
    count <- sample(1:10, 1)
    angles <- runif(count + 1, 0, 2*pi)
    x_dists <- (1/2)^(0:count) * cos(angles)
    y_dists <- (1/2)^(0:count) * sin(angles)

    xs[[length(xs) + 1]] <- c(cumsum(x_dists))
    ys[[length(ys) + 1]] <- c(cumsum(y_dists))
  }

  b_fig %>%
    ly_multi_line(
      xs = xs, ys = ys
    )
}; a()


# ly_map
# this doesn't work unless you "library(maps)" first
load_all(); b_fig %>% ly_map()


# ly_hist
load_all(); b_fig %>% ly_hist(Sepal.Length, data = ir)


# ly_density
load_all(); b_fig %>% ly_density(Sepal.Length, data = ir)

# ly_quantile
load_all(); b_fig %>% ly_quantile(Sepal.Length, data = ir)

# ly_segments, ly_boxplot
load_all(); b_fig %>% ly_boxplot(voice.part, height, data = lattice::singer) %>% theme_axis("x", major_label_orientation = 90) -> a; a



# hover with data.frame
d <- data.frame(x = 1:10, y = 1:10, random = rnorm(10))
load_all(); b_fig %>% ly_points(x, y, data = d[,c("x","y")], hover = d) -> a




# Figure Data
load_all(); figure() %>% ly_points(Sepal.Length, Sepal.Width, data = iris) -> a

# but also support
load_all(); figure(data = iris) %>% ly_points(Sepal.Length, Sepal.Width) -> a

# if this happens, honor data provided in layer first, then look in figure data if it's not there
iris2 <- iris
iris2$Sepal.Length <- 1
load_all(); figure(data = iris) %>% ly_points(Sepal.Length, Sepal.Width, data = iris2) -> a
