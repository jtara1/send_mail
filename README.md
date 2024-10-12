# send_mail
Simple command-line for sending an email with remote auth. Python 3 with stdlib only.

## Run
```shell
python send_mail.py
```

See `cat test.sh` for example usage.

### Options
```shell
usage: send_mail.py [-h] --sender-email SENDER_EMAIL [--sender-password SENDER_PASSWORD] [--config CONFIG] --receiver-email RECEIVER_EMAIL [--subject SUBJECT]
                    [--msg MSG] --smtp-server SMTP_SERVER [--smtp-port SMTP_PORT]
send_mail.py: error: the following arguments are required: --sender-email, --receiver-email, --smtp-server
```

## Build
```shell
nix build
```

which creates `./result/bin/send-mail`

## Import
To install in NixOS, add `send-mail.url = "github:jtara1/send_mail";` to your inputs optionally 
having send-mail flake nixpkgs input following your nixpkgs. Include `send-mail` in your `modules`
or `imports`.