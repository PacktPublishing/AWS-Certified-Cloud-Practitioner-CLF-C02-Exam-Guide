import json
import boto3
import uuid

transcribe = boto3.client('transcribe')

def lambda_handler(event, context):
    record = event['Records'][0]
    bucket = record['s3']['bucket']['name']
    key = record['s3']['object']['key']

    job_name = f"bellybrew-transcription-{uuid.uuid4()}"
    media_uri = f"s3://{bucket}/{key}"

    transcribe.start_transcription_job(
        TranscriptionJobName=job_name,
        LanguageCode="en-GB",
        MediaFormat=key.split('.')[-1],
        Media={
            'MediaFileUri': media_uri
        },
        OutputBucketName="bellybrew-transcripts",
        OutputKey=f"output/{job_name}.json"
    )

    return {
        "statusCode": 200,
        "body": f"Transcription job {job_name} started"
    }
