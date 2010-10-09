library(ggplot2)
library(maps)

biostar <- read.table("../../data/biostar.tab", header = F, stringsAsFactors = F, sep = "\t")
colnames(biostar) <- c("country", "code", "city", "lat", "long")
world <- map_data("world")

png(file = "biostar.png", width = 1024, height = 768)
print(ggplot(world, aes(long, lat)) + geom_polygon(aes(group = group), fill = "darkslategrey") + geom_point(data = biostar, aes(long, lat), colour = "red") + scale_colour_discrete(legend = FALSE))
dev.off()
