#!/bin/sh
set -eux

BASE_DIR=$(dirname "$0")

# Kernel settings
cp "$BASE_DIR/90-kubelet.conf" /etc/sysctl.d/90-kubelet.conf
sysctl -p /etc/sysctl.d/90-kubelet.conf

# Pod Security Policy and Network Policy
mkdir -p /var/lib/rancher/k3s/server/manifests
cp "$BASE_DIR/policy.yaml" /var/lib/rancher/k3s/server/manifests/policy.yaml

# Audit policies
mkdir -p /var/lib/rancher/k3s/server/logs
chmod 700 /var/lib/rancher/k3s/server/logs
cp "$BASE_DIR/audit.yaml" /var/lib/rancher/k3s/server
