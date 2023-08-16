const nodemailer = require('nodemailer');

class MailService {
  constructor() {
    this.transporter = nodemailer.createTransport({
      service: 'gmail',
      host: 'smtp.gmail.com',
      port: 587,
      secure: false,
      auth: {
        user: process.env.MAIL_SERVICE_EMAIL,
        pass: process.env.MAIL_SERVICE_PASSWORD,
      },
    });
  }

  async sendMail({
    from = process.env.MAIL_SERVICE_EMAIL,
    to,
    subject,
    text,
    html,
  }) {
    const mailOptions = {
      from,
      to,
      subject,
      text,
      html,
    };

    return this.transporter.sendMail(mailOptions);
  }
}

module.exports = new MailService();
