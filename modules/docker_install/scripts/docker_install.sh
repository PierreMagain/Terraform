#!/bin/bash

# Assurez-vous que vous avez les droits root pour exécuter ce script
if [ "$(id -u)" -ne "0" ]; then
  echo "Ce script doit être exécuté avec les privilèges root."
  exit 1
fi

# Désinstaller les versions antérieures de Docker
echo "Désinstallation des anciennes versions de Docker..."
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
  sudo apt-get remove -y $pkg
done

# Supprimer les éventuelles versions de Docker existantes
echo "Suppression des paquets existants de Docker..."
sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Mettre à jour la liste des paquets
echo "Mise à jour des listes de paquets..."
sudo apt-get update -y

# Installer les paquets requis
echo "Installation des paquets requis..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Ajouter la clé GPG officielle de Docker
echo "Ajout de la clé GPG de Docker..."
sudo mkdir -m 0755 -p /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Ajouter le dépôt Docker à Apt sources
echo "Ajout du dépôt Docker..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Mettre à jour la liste des paquets à nouveau
echo "Mise à jour des listes de paquets après ajout du dépôt Docker..."
sudo apt-get update -y

# Installer Docker Engine et ses composants
echo "Installation de Docker Engine et de ses composants..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Assurer que Docker démarre au démarrage
echo "Activation de Docker pour démarrer au démarrage..."
sudo systemctl enable docker

# Démarrer le service Docker
echo "Démarrage du service Docker..."
sudo systemctl start docker

# Ajouter l'utilisateur actuel au groupe Docker
echo "Ajout de l'utilisateur au groupe Docker..."
sudo usermod -aG docker $USER

echo "Installation de Docker terminée avec succès !"