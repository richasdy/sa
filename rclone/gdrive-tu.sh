# rclone command
rclone \
mount \
--verbose \
--progress \
--buffer-size 32M \
--vfs-cache-mode full \
--vfs-read-chunk-size 32M \
--vfs-read-chunk-size-limit 10G \
--fast-list \
--cache-dir ~/.gdrive-tu \
gdrive-tu: ~/gdrive-tu



# cache location
#--cache-dir ~/.gdrive-tu \

# doubles the receive buffer to reduce buffering issues.
#--buffer-size 32M \

# for watching movie sequencial read
#--max-read-ahead 200M \

#--progress \
#--progress-terminal-title \

#--daemon \
#--log-file ~/.rclone.log \ # not found
#--log-level INFO \


