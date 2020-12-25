'use strict';

const AWS = require('aws-sdk');
const converter = AWS.DynamoDB.Converter;
const moment = require('moment');

moment.locale('pt-br');

module.exports.listen = async event => {
  for (let record of event.Records) {
    if (record.eventName === 'INSERT') {
      const booking = converter.unmarshall(record.dynamodb.NewImage);
      console.log(
        `Booking created: the user ${booking.user.name} (${booking.user.email}) created a booking on: ${moment(booking.date).format('LLLL')}`
      );
    }
  }

  return {  message: 'Go Serverless v1.0! Your function executed successfully!' };
};
