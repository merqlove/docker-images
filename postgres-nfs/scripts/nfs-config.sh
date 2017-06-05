#!/bin/bash
set -e

sed -i -e 's/#wal_log_hints = off/wal_log_hints = on/g' "$PGDATA/postgresql.conf"
sed -i -e 's/#synchronous_commit = on/synchronous_commit = off/g' "$PGDATA/postgresql.conf"
sed -i -e 's/synchronous_commit = on/synchronous_commit = off/g' "$PGDATA/postgresql.conf"
cat "$PGDATA/postgresql.conf" | grep wal_log_hints
cat "$PGDATA/postgresql.conf" | grep synchronous_commit
