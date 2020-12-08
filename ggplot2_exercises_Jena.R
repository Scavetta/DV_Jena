# ggplot exercises
# Rick Scavetta
# 8 dec 2020
# Exercises for our workshop

# Load packages
library(ggplot2)
library(RColorBrewer) # for color palettes
library(Hmisc) # for additional functions

# Using colors
# plots the colors
display.brewer.all(type = "qual")
display.brewer.pal(9, "Blues")

# show the hex code for the colors
brewer.pal(9, "Blues")

# To geth the 4th, 6th, 8th colors:
myBlues <- brewer.pal(9, "Blues")[c(4,6,8)]

# Hex color 
# #9ECAE1 = #RRGGBB

# Hexideimal counting (base 16)
# 1-digit numbers: 0-9A-F, 16 (16^1)
# 2-digit numbers: 00-FF, 256 (16^2)

# Decimal counting (base 10)
# 1-digit numbers: 0-9, 10 (10^1)
# 2-digit numbers: 00-99, 100  (10^2)

256*256*256 # 16 777 216 possible combinations

#What are these colors
#000000 # no color is black
#FFFFFF # All color is white
#00FF00 # pure green
#FF00FF # violet

munsell::plot_hex("#FF00FF")

# ggplot2

# Layer 1: Data
iris

# 1 - Make base layer (data & aesthetics)
# Sepal Width vs Sepal Length (Y vs X, Y ~ X)
# Colored according to Species
# Aesthetics == scales == axes
p <- ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species))

# 2 - Add the geometries layer
# Create basic scatter plot
p +
  geom_point()
# This is mostly perfectly fine, but it doesn't
# guarantee there will be no over-plotting,
# so always consider if it's the right choice.

# Causes for over-plotting:
# low-precision data (here)
# Integer data (on X and Y)
# A lot of observations
# All points on one axis (i.e. cont Y, categorical X)

# A short aside on integer data:
library(car) # Companion to Applied Regression
str(Vocab)
g <- ggplot(Vocab, aes(education, vocabulary))
g

# Default
g +
  geom_point()

# Solutions:

g +
  geom_jitter(shape = ".",
              alpha = 0.2)

# Alternatively, just plot the number of observations
g +
  stat_sum()

# Solutions:
# size, alpha, shape, position

# our solution: Jittering
# 1 - Use the position argument
# Convenient and inflexible
p +
  geom_point(position = "jitter")

# 2 - Use the geom_jitter()
# Convenient and somewhat flexible
p +
  geom_jitter()

# 3 - Use a position_*() function
# Full-featured and most flexible
posn_j <- position_jitter(seed = 1)

p +
  geom_point(position = posn_j,
             shape = 16,
             alpha = 0.65)

# Modifying the plot ----
# 3 - Add linear models, without background (error, 95%CI)
# 4 - Change the colors - use Dark2 from color brewer
# Recall: aesthetics == scales == axes
# So to modify an aesthetic, use a scale_*_*() function

# Define a named vector of colors to use the consistently
# in many plots
myColors <- c("virginica" = "#377eb8",
              "setosa" = "#4daf4a",
              "versicolor" = "#984ea3")

# 5 - Remove non-data ink
# 6 - Re-position the legend to the upper left corner
# legend position is in units of npc
# 7 - Relabel the axes (names and units), add a title or caption
# Title: "The Iris Dataset, again!"
# Caption: "Anderson, 1931"

# 8 - Change the aspect ratio to 1:1
# 9 - Set limits on the x and y axes

ggplot(iris, aes(Sepal.Length, 
                 Sepal.Width, 
                 color = Species)) +
  geom_point(position = posn_j,
             shape = 16,
             alpha = 0.65) +
  geom_smooth(method = "lm", se = FALSE) +
  coord_fixed(xlim = c(4, 8), 
              ylim = c(2, 4.5), 
              expand = 0) +
  scale_color_manual(values = myColors) +
  labs(title = "The Iris Dataset, again!",
       caption = "Anderson, 1931",
       x = "Sepal Length (cm)",
       y = "Sepal Width (cm)",
       color = "Iris Species") +
  theme_classic() +
  theme(rect = element_blank(),
        text = element_text(family = "serif"),
        legend.position = c(0.15, 0.85))

# Extra notes:
# LOESS default
# geom_smooth(span = 0.4, se = FALSE)

# use color brewer for colors
# scale_color_brewer(palette = "Dark2")

# use a chr vector for colors
# scale_color_manual(values = myBlues)

# This filters our data not in the range
# i.e. be careful
# scale_x_continuous(limits = c(4,8), expand = c(0,0)) +

# Saving plots

# two basic kinds of image 
# Raster (have pixels & resolution)
# jpg, png, tiff, gif, bmp

# Vector images (instructions to make an image)
# pdf, svg, ps, eps, il

ggsave("myPlot.pdf", height = 6, width = 6, units = "in")
ggsave("myPlot.png", height = 6, width = 6, units = "in")


