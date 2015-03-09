library(rpart)
library(grid)
library(partykit)
library(RWeka)

rtree <- rpart(yield ~ sacchariflorus + sinensis + sinensis.Hybrid + giganteus +
                 lat + lon + fertilizer_n + stand_age + irrigated + planting_density, 
               data = dataigb2_rtree)
plot(as.party(rtree),tp_args=list(id=FALSE))

print(rtree$cptable)

opt <- which.min(rtree$cptable[,"xerror"])
cp <- rtree$cptable[opt,"CP"]

rtree_prune <- prune(rtree,cp=cp)
libaraplot(as.party(rtree_prune),tp_args=list(id=FALSE))

fit <- rpart(yield~., method="anova", data=dataigb2_rtree)

summary(rtree)
