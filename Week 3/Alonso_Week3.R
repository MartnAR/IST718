# Association rules 
require(arules)
require(arulesViz)
require(ggplot2)

# Import the Groceciers dataset 
data('Groceries')
dim(Groceries)

# Review the data levels that we're dealing with to understand what to look for. 
head(itemInfo(Groceries))

# How many different item tyes are there and how frequent are they? 
itemsLevel1 <- itemInfo(Groceries)['level1']
itemsLevel1 <- itemsLevel1 %>% 
  group_by(level1) %>% 
  summarise(count = n()) %>% 
  arrange(count)

# Bar plot showing Level 1 Item frequency 
ggplot(itemsLevel1, aes(x=reorder(level1, -count), y=count)) + 
  geom_bar(stat='identity', fill='blue') +
  theme(axis.text.x = element_text(angle = 15)) +
  labs(x='Item (Level 1)', y='Frequency')

# Create a set of rules and compare results. 
# Low support with high confidence
firstRules <- apriori(Groceries, parameter = list(supp=0.001, conf=0.9, target='rules'))
summary(firstRules)
plot(firstRules, jitter = 1)

# High support and low confidence
secondRules <- apriori(Groceries, parameter = list(supp=0.05, conf=0.01, target='rules'))
summary(secondRules)
plot(secondRules, jitter = 1)

# First set of rules generates 129 rules, all having a lift greoter than 1. Second set of rules generates
# 34 rules none with much confidence or support and only 6 having a lift greater than 1, meaning that 
# they're mostly independent. 