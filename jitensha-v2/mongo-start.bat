@echo off
REM
REM Copyright (c) 2016, Crossover and/or its affiliates. All rights reserved.
REM CROSSOVER PROPRIETARY/CONFIDENTIAL.
REM
REM     https://www.crossover.com/
REM

if not exist C:\MongoData (
    cd C:\
    mkdir MongoData
)
mongod --dbpath C:\MongoData