# Docker verify service

## What it does

Verifies file hashes as well as signed hashes in case they are signed also

## Usage

```bash
# Notes Filename should live in the current working directory

FILENAME=filename-to-verify
docker run --rm -v $PWD:/verify nolim1t/verify:latest -f $FILENAME
```
