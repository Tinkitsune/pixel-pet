#!/bin/bash
# Claude Code hook script - writes tool status for PixelPet
# Auto-detects its own directory for status.json
DIR="$(cd "$(dirname "$0")" && pwd)"
/usr/bin/python3 -c "
import sys,json,time
d=json.load(sys.stdin)
ev=d.get('hook_event_name','')
if ev!='PreToolUse':
    sys.exit(0)
tool=d.get('tool_name','')
m={'Write':'writing','Edit':'writing','NotebookEdit':'writing','Read':'reading','Bash':'running','Grep':'searching','Glob':'searching','Agent':'searching'}
st=m.get(tool,'thinking')
import os
p='$DIR/status.json'
with open(p+'.tmp','w') as f:
    json.dump({'state':st,'tool':tool,'ts':int(time.time()*1000)},f)
os.rename(p+'.tmp',p)
"
