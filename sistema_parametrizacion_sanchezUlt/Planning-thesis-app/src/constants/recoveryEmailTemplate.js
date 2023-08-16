const RESET_PASSWORD_TEMPLATE = (token, appUrl) => {
  const resetUrl = `${appUrl}/?token=${token}`;

  return `
    <!DOCTYPE html>
    <html>
      <head>
        <meta charset="utf-8">
        <title>Recuperación contraseña</title>
        <style>
          .container {
            width: 100%;
            padding: 20px;
            background-color: #f4f4f4;
            font-family: Arial, sans-serif;
          }
          .email {
            width: 80%;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0px 10px 20px rgba(0,0,0,0.1);
          }
          .email-header {
            background-color: #333;
            color: #fff;
            padding: 20px;
            text-align: center;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
          }
          .email-body {
            padding: 20px;
            line-height: 1.5;
            color: #333;
          }
          .email-footer {
            background-color: #333;
            color: #fff;
            padding: 20px;
            text-align: center;
            border-bottom-left-radius: 15px;
            border-bottom-right-radius: 15px;
          }
          .button {
            display: inline-block;
            font-weight: bold;
            color: #ffffff;
            background-color: #007BFF;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 15px;
            text-align: center;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="email">
            <div class="email-header">
              <h1>Restablecer contraseña - Tésis PlaneacionApp</h1>
            </div>
            <div class="email-body">
              <p>Has solicitado restablecer tu contraseña. Haz clic en el botón de abajo para continuar.</p>
              <a href="${resetUrl}" class="button">Restablecer contraseña</a>
            </div>
            <div class="email-footer">
              <p>Si no solicitaste restablecer tu contraseña, por favor ignora este correo electrónico o contacta con soporte si tienes alguna pregunta.</p>
            </div>
          </div>
        </div>
      </body>
    </html>
  `;
};

module.exports = RESET_PASSWORD_TEMPLATE;
