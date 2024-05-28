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

# If a PUBLIC_KEY environment variable is provided, add the key to the SSH_USER
if [ -n "$PUBLIC_KEY" ]; then
    # Determine correct home directory
    HOME_DIR=$(getent passwd "$SSH_USER" | cut -d: -f6)
    mkdir -p $HOME_DIR/.ssh
    echo $PUBLIC_KEY > $HOME_DIR/.ssh/authorized_keys
    chown -R $SSH_USER:$SSH_USER $HOME_DIR/.ssh
    chmod 700 $HOME_DIR/.ssh
    chmod 600 $HOME_DIR/.ssh/authorized_keys
fi

exec /usr/sbin/sshd -D & 

nohup jupyter-lab --allow-root --ip  0.0.0.0 --NotebookApp.token='' --notebook-dir /workspace/ComfyUI --NotebookApp.allow_origin=* --NotebookApp.allow_remote_access=1 &

python /workspace/ComfyUI/main.py --listen