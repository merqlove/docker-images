# PostgreSQL Docker image for NFS

Several nfs optimizations:

- wal_log_hints: on
- synchronous_commit: off
- auto `--data-checksums`
