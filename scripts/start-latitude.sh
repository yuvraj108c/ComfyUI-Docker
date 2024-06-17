#!/bin/sh

mkdir -p /workspace/ComfyUI
mv /temp/ComfyUI/* /workspace/ComfyUI

cd /workspace/ComfyUI/venv/bin
sed -i "s|/temp/ComfyUI|/workspace/ComfyUI|g" *

cd /workspace/ComfyUI

. venv/bin/activate && nohup jupyter-lab --allow-root --ip  0.0.0.0 --NotebookApp.token='' --notebook-dir /workspace/ComfyUI --NotebookApp.allow_origin=* --NotebookApp.allow_remote_access=1 &

. venv/bin/activate && python /workspace/ComfyUI/main.py --listen