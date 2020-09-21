# Docker verify service

[![pipeline status](https://gitlab.com/nolim1t/docker-verify/badges/master/pipeline.svg)](https://gitlab.com/nolim1t/docker-verify/-/commits/master) 
![Docker Pulls Count](https://img.shields.io/docker/pulls/nolim1t/docker-verify.svg?style=flat)

## What it does

Verifies file hashes as well as signed hashes in case they are signed also.

This repository pushes to [docker hub](https://hub.docker.com/r/nolim1t/docker-verify) using a gitlan CI builder action.

## Usage

```bash
# Notes Filename should live in the current working directory
# For the docker command, you can also set a 64 bit GPG key using the
# GPGKEY variable
# You can get the 64-bit key of the signature doing
# gpg --keyid-format LONG --list-keys

FILENAME=filename-to-verify
docker run --rm -v $PWD:/verify nolim1t/docker-verify  -f $FILENAME
```
