#!/bin/sh
SSH_USER=${SSH_USER:-root}

# Check if SSH_USER exists, if not create it
if ! id "$SSH_USER" &>/dev/null; then
    useradd -m $SSH_USER
fi

# Enable or disable password authentication based on SSH_PASSWORD_AUTH environment variable
if [ -n "$SSH_PASSWORD" ]; then
    sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    echo "$SSH_USER:$SSH_PASSWORD" | chpasswd
fi

exec /usr/sbin/sshd -D & 

nohup jupyter-lab --allow-root --ip  0.0.0.0 --NotebookApp.token='' --notebook-dir /workspace/ComfyUI --NotebookApp.allow_origin=* --NotebookApp.allow_remote_access=1 &

python /workspace/ComfyUI/main.py --listen