import { S3Client, PutObjectCommand } from "@aws-sdk/client-s3";
import { createReadStream } from "fs";

const s3Client = new S3Client({
  forcePathStyle: true,
  region: "bucket-region",
  endpoint: "https://xxxxxxxxxxxx.supabase.co/storage/v1/s3",
  credentials: {
    accessKeyId: "xxxxxxxxxxxxxxxxxxxxxxxxx",
    secretAccessKey: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  },
});

const file = createReadStream("path/to/file.jpg");

const uploadCommand = new PutObjectCommand({
  Bucket: "bucket-name",
  Key: "path/to/file.jpg",
  Body: file,
  ContentType: "image/jpeg",
});

await s3Client.send(uploadCommand);
