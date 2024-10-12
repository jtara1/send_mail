#!/usr/bin/env bash

python ./send_mail.py \
  --sender-email "nah@elk.gg" \
  --config ./send_mail.json \
  --subject "Email Test" \
  --msg "Hello!" \
  --receiver-email "nah@elk.gg" \
  --smtp-server "mail.elk.gg"

# optionally,
#  --sender-password "my plaintext password"  \
