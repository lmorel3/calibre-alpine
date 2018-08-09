#/bin/sh

# Creates a database
if [ ! -f /library/metadata.db ]; then
    echo "Creating calibre library"
    xvfb-run /opt/calibre/calibredb add "/tmp/test.mobi" --library-path /library  #--add 
fi

echo "===================================="
echo "======= Starting Calibre ==========="
echo "==================================="

# Runs server
/opt/calibre/calibre-server --daemonize --log /dev/stdout --port 8080 --listen-on 0.0.0.0 --disable-auth --enable-local-write /library

# Enables cron jobs
crond -f -c /opt/crontabs -l 0 2>&1 -L /dev/stdout
