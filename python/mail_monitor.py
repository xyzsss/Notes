"""A mail sender for monitor ."""
# Author: exuxu
import smtplib

version = '0.1'


class mail_monitor():
    """
    mm = mail_monitor.mail_monitor()
    mail_msg = "mail content here"
    subject = 'Test Object'
    send_status = mm.send_mail(mail_msg, subject)
    Return True if mail send success,else would be False.
    """
    def __init__(self):
        self.mail_host = "smtp.sina.com"
        self.mail_user = "pythonsss"
        self.mail_user_ssap = "pythonsina"
        self.mail_sender = "pythonsss@sina.com"
        self.mail_receiver = "929742009@qq.com"
        self.mail_smtp_port = 25

    def send_mail(self, mail_msg, subject):
        if mail_msg is not None and subject is not None:
            mail_host = self.mail_host
            mail_user = self.mail_user
            mail_ssap = self.mail_user_ssap
            sender = self.mail_sender
            receivers = self.mail_receiver
            message = 'From:' + sender + '\rSubject:' +\
                subject + '\r\n\r\n\n' + mail_msg
            try:
                smtpObj = smtplib.SMTP()
                smtpObj.connect(mail_host, self.mail_smtp_port)
                smtpObj.login(mail_user, mail_ssap)
                smtpObj.sendmail(sender, receivers, message)
                return True
            except smtplib.SMTPException:
                return False
