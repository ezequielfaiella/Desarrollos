# sudo touch /etc/systemd/system/telegram_servicio_bot.service

cat <<EOF > /tmp/telegram_comandos_servicio_bot.service

[Unit]
Description=Bot de Telegram de Comandos Remotos
After=multi-user.target

[Service]
Type=simple
User=ezequiel
WorkingDirectory=/media/trabajo/Trabajo/scripts/
ExecStart=/home/ezequiel/.pyenv/versions/3.6.9/bin/python /media/trabajo/Trabajo/scripts/weme_comandos_telegram_bot.py


Restart=always
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

sudo mv /tmp/telegram_comandos_servicio_bot.service /etc/systemd/system/telegram_comandos_servicio_bot.service
sudo systemctl daemon-reload
sudo systemctl start telegram_comandos_servicio_bot
sudo systemctl status telegram_comandos_servicio_bot
#sudo systemctl enable telegram_comandos_servicio_bot.service
#sudo rm /etc/systemd/system/telegram_comandos_servicio_bot.service
