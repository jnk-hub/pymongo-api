#!/bin/bash

docker compose exec -T mongos_router mongosh --port 27020 --quiet <<EOF
sh.status()
EOF

docker compose exec -T mongos_router mongosh --port 27020 --quiet <<EOF
use somedb
print("router count:", db.helloDoc.countDocuments());
EOF

docker compose exec -T shard1 mongosh --port 27018 --quiet <<EOF
use somedb;
print("shard1 count:", db.helloDoc.countDocuments());
EOF

docker compose exec -T shard2 mongosh --port 27018 --quiet <<EOF
use somedb;
print("shard2 count:", db.helloDoc.countDocuments());
EOF