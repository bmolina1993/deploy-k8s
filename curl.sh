#!/bin/bash
for i in $(seq 10); do curl -s http://localhost:3000/ | jq .HOSTNAME ;done
