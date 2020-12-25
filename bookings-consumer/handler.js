'use strict';

const AWS = require('aws-sdk');
AWS.config.update({
  region: process.env.AWS_REGION,
});
const SNS = new AWS.SNS();
const converter = AWS.DynamoDB.Converter;
const moment = require('moment');

moment.locale('pt-br');

module.exports.listen = async event => {
  const snsPromises = [];

  for (let record of event.Records) {
    if (record.eventName === 'INSERT') {
      const booking = converter.unmarshall(record.dynamodb.NewImage);

      snsPromises.push(SNS.publish({
        TopicArn: process.env.SNS_NOTIFICATIONS_TOPIC,
        Message: `Booking created: the user ${booking.user.name} (${booking.user.email}) created a booking on: ${moment(booking.date).format('LLLL')}`,
      }).promise());
    }
  }

  await Promise.all(snsPromises);

  console.log('Message(s) sent successfully to SNS topic');

  return {  message: 'Go Serverless v1.0! Your function executed successfully!' };
};
