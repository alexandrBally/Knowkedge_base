import { SQSClient, SendMessageCommand } from "@aws-sdk/client-sqs";

const sqs_url = 'https://sqs.us-west-2.amazonaws.com/722095950052/dev-ops-elef10';

const sendMessagesToSqs = async () => {
  const client = new SQSClient({
    region: "us-west-2"
  });

  const request = new SendMessageCommand({
    DelaySeconds: 1,
    MessageBody: JSON.stringify({ message: "I am888888888 message"}),
    QueueUrl: sqs_url,
  });

  const res = await client.send(request);

  if (!res) {
    throw new Error("I am sqs sending error")
  }
  console.log("Success, message sent. MessageID:", res);
  return res;
};

sendMessagesToSqs();

