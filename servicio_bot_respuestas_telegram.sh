# sudo touch /etc/systemd/system/telegram_servicio_bot.service

cat <<EOF > /tmp/telegram_respuestas_servicio_bot.service

[Unit]
Description=Bot de Telegram de Servicios
After=multi-user.target

[Service]
WorkingDirectory=/media/trabajo/Trabajo/scripts/
Type=simple
User=ezequiel
ExecStart=/home/ezequiel/.pyenv/versions/3.6.9/bin/python /media/trabajo/Trabajo/scripts/weme_respuestas_telegram_bot.py


Restart=always
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

sudo mv /tmp/telegram_respuestas_servicio_bot.service /etc/systemd/system/telegram_respuestas_servicio_bot.service
sudo systemctl daemon-reload
sudo systemctl start telegram_respuestas_servicio_bot
sudo systemctl status telegram_respuestas_servicio_bot
#sudo systemctl enable telegram_respuestas_servicio_bot.service
#sudo rm /etc/systemd/system/telegram_respuestas_servicio_bot.service
