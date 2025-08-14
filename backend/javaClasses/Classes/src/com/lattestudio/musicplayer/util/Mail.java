package com.lattestudio.musicplayer.util;

import jakarta.mail.*;
import jakarta.mail.Message;
import jakarta.mail.internet.*;
import java.util.Properties;

/**
 * Utility class for sending styled verification emails for Latte Studio music player application.
 * <p>
 * This class handles creating and sending an HTML email with embedded background and logo images,
 * and includes a randomly generated 4-digit verification code.
 * </p>
 *
 * @author ChatGPT
 * @since v0.1.8
 */
public class Mail {

    // Sends a styled verification email with background images and logo
    /**
     * Sends a verification email to the specified recipient email address.
     * <p>
     * The email contains a styled HTML message with background image, logo, and a 4-digit verification code.
     * </p>
     *
     * @param to Recipient email address to which the verification email will be sent.
     * <p> from : Sender email address used to authenticate with the SMTP server.</p>
     * <p>appPassword :  Application-specific password or SMTP password for the sender email.</p>
     * @return it returns the random number as a String
     * @throws Exception If there is any failure during email sending process (e.g., authentication or messaging issues).
     * @since v0.1.8
     * @author GPT
     */
    public static String sendVerificationEmail(String to ) throws Exception {
        String code = Math.generateCode();
        String from = "lattestudio.contact@gmail.com";
        String appPassword = "afyauewxzmwooeko";
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, appPassword);
            }
        });

        // URLs or base64 encode your images if hosting online
        // Since you uploaded files here, you'll need to host them on your server or CDN.
        // For demo, I assume you host them somewhere and replace the URLs below.

        String bgNormalUrl = "https://i.ibb.co/FkJsYymj/loginblured.jpg";
        String logoUrl = "https://i.ibb.co/SDH1PWJm/photo-2025-08-09-16-59-38.jpg";

        String htmlContent = """
                    <html>
                                                      <head>
                                                        <meta charset="UTF-8" />
                                                        <title>Latte Studio Verification</title>
                                                      </head>
                                                      <body style="margin:0; padding:0; font-family: Arial, sans-serif;">
                                                        <table role="presentation" border="0" cellpadding="0" cellspacing="0" width="100%%" height="100%%" style="background: none;">
                                                          <tr>
                                                            <td align="center" valign="middle" style="background: none; padding: 0;">
                                                              <table role="presentation" border="0" cellpadding="0" cellspacing="0" width="600" style="
                                                                background: url('%s') no-repeat center center / cover;
                                                                border-radius: 15px;
                                                                box-shadow: 0 0 30px rgba(0,0,0,0.3);
                                                                color: #4B3832;
                                                                ">
                                                                <tr>
                                                                  <td style="background: rgba(255, 255, 255, 0.95); border-radius: 15px; padding: 30px 40px; text-align: center;">
                                                                    <img src="%s" alt="Latte Studio Logo" width="80" style="margin-bottom: 15px;" />
                                                                    <h2 style="color: #6f4e37; margin-bottom: 5px;">Welcome to Latte Studio!</h2>
                                                                    <p style="font-size: 18px; margin: 15px 0;">Your gateway to the best of Iranian & International music, carefully brewed just for you.</p>
                                                                    <p style="font-size: 18px; margin: 15px 0;">Use the code below to verify your account and keep the rhythm going!</p>
                                                                    <h1 style="color: #6f4e37; letter-spacing: 10px; font-weight: bold; font-size: 48px; margin: 20px 0;"><b>%s</b></h1>
                                                                    <p style="font-size: 18px; margin: 15px 0;">Please redeem this code inside the app to continue.</p>
                                                                    <hr style="margin: 30px 0; border: none; border-top: 1px solid #ddd;" />
                                                                    <small style="color: #999; font-size: 12px;">For your safety, please do not reply to this email.</small><br/>
                                                                    <small style="color: #999; font-size: 12px;">If you have questions, email us at <b>%s</b><br/></small>
                                                                    <small style="color: #999; font-size: 12px;">This HTML page is created via gpt-5</small>
                                                                  </td>
                                                                </tr>
                                                              </table>
                                                            </td>
                                                          </tr>
                                                        </table>
                                                      </body>
                                                      </html>
                """.formatted(bgNormalUrl, logoUrl, code, from);

        jakarta.mail.Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(from, "Latte Studio"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject("Your Latte Studio Verification Code");
        message.setContent(htmlContent, "text/html; charset=utf-8");

        Transport.send(message);
        com.lattestudio.musicplayer.util.Message.cyanServerMessage("Verification code sent: " + code);
        return code ;
    }




    // Sends a styled verification email with background images and logo
    /**
     * Sends a verification email to the specified recipient email address.
     * <p>
     * The email contains a styled HTML message with background image, logo, and a 4-digit verification code.
     * </p>
     *
     * @param to Recipient email address to which the verification email will be sent.
     * <p> from : Sender email address used to authenticate with the SMTP server.</p>
     * <p>appPassword :  Application-specific password or SMTP password for the sender email.</p>
     * @return it returns the random number as a String
     * @throws Exception If there is any failure during email sending process (e.g., authentication or messaging issues).
     * @since v0.1.8
     * @author GPT
     */
    public static String sendRecoveryEmail(String to ) throws Exception {
        String code = Math.generateCode();
        String from = "lattestudio.contact@gmail.com";
        String appPassword = "afyauewxzmwooeko";
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, appPassword);
            }
        });

        // URLs or base64 encode your images if hosting online
        // Since you uploaded files here, you'll need to host them on your server or CDN.
        // For demo, I assume you host them somewhere and replace the URLs below.

        String bgNormalUrl = "https://i.ibb.co/FkJsYymj/loginblured.jpg";
        String logoUrl = "https://i.ibb.co/SDH1PWJm/photo-2025-08-09-16-59-38.jpg";

        String htmlContent = """
                    <html>
                                                             <head>
                                                               <meta charset="UTF-8" />
                                                               <title>Latte Studio Password Recovery</title>
                                                             </head>
                                                             <body style="margin:0; padding:0; font-family: Arial, sans-serif;">
                                                               <table role="presentation" border="0" cellpadding="0" cellspacing="0" width="100%%" height="100%%" style="background: none;">
                                                                 <tr>
                                                                   <td align="center" valign="middle" style="background: none; padding: 0;">
                                                                     <table role="presentation" border="0" cellpadding="0" cellspacing="0" width="600" style="
                                                                       background: url('%s') no-repeat center center / cover;
                                                                       border-radius: 15px;
                                                                       box-shadow: 0 0 30px rgba(0,0,0,0.3);
                                                                       color: #4B3832;
                                                                       ">
                                                                       <tr>
                                                                         <td style="background: rgba(255, 255, 255, 0.95); border-radius: 15px; padding: 30px 40px; text-align: center;">
                                                                           <img src="%s" alt="Latte Studio Logo" width="80" style="margin-bottom: 15px;" />
                                                                           <h2 style="color: #6f4e37; margin-bottom: 5px;">Password Recovery Request</h2>
                                                                           <p style="font-size: 18px; margin: 15px 0;">We received a request to reset your Latte Studio account password.</p>
                                                                           <p style="font-size: 18px; margin: 15px 0;">Use the verification code below to reset your password:</p>
                                                                           <h1 style="color: #6f4e37; letter-spacing: 10px; font-weight: bold; font-size: 48px; margin: 20px 0;"><b>%s</b></h1>
                                                                           <p style="font-size: 18px; margin: 15px 0;">Enter this code in the app to create a new password.</p>
                                                                           <p style="font-size: 16px; margin: 15px 0; color: #777;">If you didn't request this, please ignore this email or contact support.</p>
                                                                           <hr style="margin: 30px 0; border: none; border-top: 1px solid #ddd;" />
                                                                           <small style="color: #999; font-size: 12px;">For your security, please do not reply to this email.</small><br/>
                                                                           <small style="color: #999; font-size: 12px;">If you need assistance, email us at <b>%s</b><br/></small>
                                                                           <small style="color: #999; font-size: 12px;">This HTML page is created via gpt-5</small>
                                                                         </td>
                                                                       </tr>
                                                                     </table>
                                                                   </td>
                                                                 </tr>
                                                               </table>
                                                             </body>
                                                             </html>
                """.formatted(bgNormalUrl, logoUrl, code, from);

        jakarta.mail.Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(from, "Latte Studio"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject("Your Latte Studio Verification Code");
        message.setContent(htmlContent, "text/html; charset=utf-8");

        Transport.send(message);
        com.lattestudio.musicplayer.util.Message.cyanServerMessage("Verification code sent: " + code);
        return code ;
    }

}