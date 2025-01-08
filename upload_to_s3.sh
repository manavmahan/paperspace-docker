#!/bin/bash\

FILE_PATH="/Users/manav/repos/gen-api/weights/"
BUCKET_NAME="genai-weigths-s7odk6uw4scth9hffiqeiqrz1fmyeeuw1a-s3alias"
OBJECT_NAME="transformer.pt"

aws s3 cp "$FILE_PATH/$OBJECT_NAME" "s3://$BUCKET_NAME/$OBJECT_NAME"
