#!/bin/bash

PROJECT_NAME=order-service
TAG_NAME=1.0.0
docker build -t ${PROJECT_NAME}:${TAG_NAME} .
