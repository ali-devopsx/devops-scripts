#!/bin/bash

# ==========================================
# Script to install some common devops tools
# Works on Debian/Ubuntu/Kali based systems
# ==========================================

echo "Setting up the development tools..."
echo "This will install git, docker, kubectl, helm and more."
echo ""

# Update package lists first
echo "--- Updating package lists ---"
sudo apt-get update

# --- Install basic tools ---
echo "--- Installing basic tools ---"
sudo apt-get install -y git curl wget vim htop

# --- Install docker if not present ---
if ! command -v docker > /dev/null; then
    echo "--- Installing Docker ---"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    rm get-docker.sh
    echo "Adding user to docker group..."
    sudo usermod -aG docker $USER
else
    echo "Docker already installed: $(docker --version)"
fi

# --- Install kubectl if not present ---
if ! command -v kubectl > /dev/null; then
    echo "--- Installing kubectl ---"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
else
    echo "kubectl already installed: $(kubectl version --client)"
fi

# --- Install helm if not present ---
if ! command -v helm > /dev/null; then
    echo "--- Installing helm ---"
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    rm get_helm.sh
else
    echo "helm already installed: $(helm version --short)"
fi

echo ""
echo "======================================="
echo "Installation finished!"
echo "Note: log out and back in to use docker without sudo"
