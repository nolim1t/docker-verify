# Docker verify service

## What it does

Verifies file hashes as well as signed hashes in case they are signed also

## Usage

```bash
# Notes Filename should live in the current working directory
# For the docker command, you can also set a 64 bit GPG key using the
# GPGKEY variable
# You can get the 64-bit key of the signature doing
# gpg --keyid-format LONG --list-keys

FILENAME=filename-to-verify
docker run --rm -v $PWD:/verify nolim1t/verify:latest -f $FILENAME
```
