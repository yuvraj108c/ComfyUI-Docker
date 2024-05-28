<div align="center">

# Docker image for ComfyUI

[![python](https://img.shields.io/badge/python-3.12-green)](https://www.python.org/downloads/)
[![cuda](https://img.shields.io/badge/cuda-12.4-green)](https://developer.nvidia.com/cuda-downloads)
[![mit](https://img.shields.io/badge/license-MIT-blue)](LICENSE)

<img src="assets/comfyui.PNG" />

</div>

## Tags
| Tag  | Description                    | Size     |
| ---- | ------------------------------ | -------- |
| lite | ComfyUI + Manager, Jupyter Lab | ~ 8.3 GB |

## Ports

| Connect Port | Internal Port | Description |
| ------------ | ------------- | ----------- |
| 22           | 22            | SSH Server  |
| 8188         | 8188          | ComfyUI     |
| 8888         | 8888          | Jupyter Lab |

## Environment Variables

Each of the following environment variable is optional, set either `SSH_PASSWORD` or `PUBLIC_KEY` for ssh access

| Variable     | Description               |
| ------------ | ------------------------- |
| SSH_PASSWORD | Password for ssh access   |
| PUBLIC_KEY   | Public Key for ssh access |
| SSH_USER     | Username for ssh access   |


## Running locally
```bash
docker run -d \
  --gpus all \
  -p 22:22 \
  -p 8188:8188 \
  -p 8888:8888 \
  yuvraj108c/comfyui:lite
```

## Building the docker image
```bash
git clone https://github.com/yuvraj108c/ComfyUI-Docker
cd ComfyUI-Docker
docker-compose build lite
```

## License
MIT