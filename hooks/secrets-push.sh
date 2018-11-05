#!/bin/bash
#
# This hook uses gdrive to save secret.yaml file to Google Drive.  You may
# need to run 'gdrive list' to setup auth.
#

# check if the secrets.yaml file has change
if ! sha1sum -sc /config/secrets.sha1sum; then
	id=$(/config/hooks/gdrive list | grep secrets.yaml | awk '{print $1}')

	if ! /config/hooks/gdrive update $id /config/secrets.yaml; then
		echo "Google Drive update failed"
		exit 1
	fi

	sha1sum /config/secrets.yaml > /config/secrets.sha1sum
	git add secrets.sha1sum
fi

exit 0
