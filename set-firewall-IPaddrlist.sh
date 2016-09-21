#!/bin/sh

NODE="firewall group network-group JP"
LEAF="network"

# environments
SHELL_API=/bin/cli-shell-api
vyatta_sbindir=/opt/vyatta/sbin
SET=${vyatta_sbindir}/my_set
DELETE=${vyatta_sbindir}/my_delete
COPY=${vyatta_sbindir}/my_copy
MOVE=${vyatta_sbindir}/my_move
RENAME=${vyatta_sbindir}/my_rename
ACTIVATE=${vyatta_sbindir}/my_activate
DEACTIVATE=${vyatta_sbindir}/my_activate
COMMENT=${vyatta_sbindir}/my_comment
COMMIT=${vyatta_sbindir}/my_commit
DISCARD=${vyatta_sbindir}/my_discard
SAVE=${vyatta_sbindir}/vyatta-save-config.pl


# setup session
session_env=$($SHELL_API getSessionEnv $PPID)
eval $session_env
${SHELL_API} setupSession

# config set
$DELETE $NODE
$COMMIT
echo "[`date +'%Y/%m/%d %H:%M:%S'`] Deleted existing node"

while read x; do
    $SET $NODE $LEAF $x
done

# config commit/save
$COMMIT
$SAVE
echo "[`date +'%Y/%m/%d %H:%M:%S'`] Script done"
