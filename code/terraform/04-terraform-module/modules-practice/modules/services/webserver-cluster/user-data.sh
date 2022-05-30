#!/bin/bash

cat > index.html <<EOF
<h1><center>Hello, Meow World</center></h1>
<hr>
<br>
<h2>Environment: ${env}</h2>
<br>
<h2>DB IP/PORT:</h2>
<p>DB address: ${db_address}</p>
<p>DB port: ${db_port}</p>
EOF

nohup busybox httpd -f -p ${server_port} &
