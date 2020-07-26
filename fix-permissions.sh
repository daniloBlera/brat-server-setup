#!/bin/sh
# Fix permission issues on newly-created data
# Place this script on the annotator's root directory then run it
sudo chgrp -R "$(./apache-group.sh)" data work
chmod -R g+rwx data work 2> /dev/null
