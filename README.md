# Asterisk SMS-forwarding via SIP trunk (Docker)

This project routes incoming SMS received on a GSM USB dongle (chan_dongle)
through a SIP trunk by using Asterisk's MessageSend() application.

What is included:
- docker-compose.yml (Asterisk + optional MySQL)
- Dockerfile to build Asterisk with chan_dongle and ODBC support
- configs/ with dongle.conf, pjsip.conf, extensions.conf (sms-incoming uses MessageSend)
- entrypoint.sh that substitutes env vars into conf files before starting Asterisk

How it works:
- chan_dongle receives SMS and delivers it to context `sms-incoming` with extension `sms`.
- `extensions.conf` extracts `${SMS_BODY}` and calls `MessageSend(sip:${TRUNK_USER}@${TRUNK_HOST},${SMS_BODY})`
  which sends a SIP MESSAGE to the provider URI. Provider must support SIP MESSAGE for SMS-to-SMPP or similar.

Notes & troubleshooting:
- Verify provider supports SIP MESSAGE and check authentication/format requirements (some providers require specific headers).
- Ensure dongle is not in storage mode (use usb_modeswitch on the host if needed).
- Run `asterisk -rvvv` and `dongle show devices` to confirm dongle is seen.
- Check network reachability from container to provider host.
