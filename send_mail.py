#!/usr/bin/env python
import argparse
import json
import smtplib
import sys
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

SMTP_PORT_DEFAULT = 587


def send_email(sender_email, password, receiver_email, subject, msg, smtp_server, smtp_port=SMTP_PORT_DEFAULT):
	# Create a multipart message
	message = MIMEMultipart()
	message['From'] = sender_email
	message['To'] = receiver_email
	message['Subject'] = subject
	message.attach(MIMEText(msg, 'plain'))

	try:
		with smtplib.SMTP(smtp_server, smtp_port) as server:
			server.starttls()
			server.login(sender_email, password)
			server.send_message(message)
	except Exception as e:
		stderr(f'An error occurred while sending the email: {str(e)}')


def parse_password(file_path) -> str | None:
	""":return: sender-password property value from JSON parsed file_path"""
	try:
		with open(file_path, 'r') as file:
			data = json.load(file)
			if isinstance(data, dict) and 'sender-password' in data:
				return data['sender-password']
			else:
				stderr("Error: JSON file does not contain 'sender-password' property")
				return None
	except FileNotFoundError:
		stderr(f"Error: File '{file_path}' not found")
	except json.JSONDecodeError as e:
		stderr(f"Error parsing JSON file: {e}")
	except Exception as e:
		stderr(f"An unexpected error occurred: {e}")
	return None


def stderr(*args, **kwargs):
	kwargs['file'] = sys.stderr
	print(*args, **kwargs)


def parse_args():
	parser = argparse.ArgumentParser(description='Send an email using Python std lib')
	parser.add_argument('--sender-email', type=str, required=True,
						help='Sender email address')
	parser.add_argument('--sender-password', type=str, required=False,
						help='Sender email password')
	parser.add_argument('--config', type=str, required=False,
						help='Configuration file')
	parser.add_argument('--receiver-email', type=str, required=True,
						help='Receivers email address')
	parser.add_argument('--subject', type=str, required=False,
						help='Email subject', default='Test Email')
	parser.add_argument('--msg', type=str, required=False,
						help='Email message', default='test message')
	parser.add_argument('--smtp-server', type=str, required=True,
						help='Endpoint of the SMTP server')
	parser.add_argument('--smtp-port', type=int, required=False,
						help='Port of the SMTP server', default=SMTP_PORT_DEFAULT)

	args = parser.parse_args()
	if args.config:
		if not args.sender_password:
			args.sender_password = parse_password(args.config)

	if not args.sender_password:
		stderr('Either set --sender-password <str> or --config <path> which contains the password in the '
			   'form of {"sender-password": "my pw"}')
		exit(1)

	return args


def command_line():
	args = parse_args()
	send_email(args.sender_email, args.sender_password, args.receiver_email, args.subject, args.msg, args.smtp_server,
			   args.smtp_port)


if __name__ == "__main__":
	command_line()
