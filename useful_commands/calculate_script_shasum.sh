#!/bin/bash
pbpaste | openssl dgst -sha256 -binary | openssl base64
