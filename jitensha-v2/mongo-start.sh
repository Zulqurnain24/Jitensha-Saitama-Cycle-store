#
# Copyright (c) 2016, Crossover and/or its affiliates. All rights reserved.
# CROSSOVER PROPRIETARY/CONFIDENTIAL.
#
#     https://www.crossover.com/
#
if [ ! -d "$HOME/MongoData" ]; then
    mkdir $HOME/MongoData
fi
mongod --dbpath $HOME/MongoData
