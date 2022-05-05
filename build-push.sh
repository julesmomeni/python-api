#!/bin/bash
AWS_ACCOUNT_ID="755901782347"
REPOSITORY="demo-app"
IMAGE=$REPOSITORY:latest
AWS_REGION="us-east-1"

# ecr login

aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# docker build
docker build . -t $IMAGE

# forming string to name new image
REMOTE_REPOSITORY=$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPOSITORY

# docker tag.
docker tag $IMAGE $REMOTE_REPOSITORY

# docker push to ecr 
docker push $REMOTE_REPOSITORY

# find old image
OLD_IMAGE_DIGESTS=`aws ecr --region $AWS_REGION list-images --repository-name $REPOSITORY --filter tagStatus=UNTAGGED | jq '.imageIds | map({imageDigest: .imageDigest})'`

# deleet old images if they exist
if [ ! "$OLD_IMAGE_DIGESTS" = '[]' ]; then
  aws ecr --region $AWS_REGION batch-delete-image --repository-name $REPOSITORY --image-ids "$OLD_IMAGE_DIGESTS"
fi