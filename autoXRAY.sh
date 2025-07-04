#!/bin/bash

echo "Обновление и установка необходимых пакетов..."
apt update && apt install sudo -y
#sudo apt update && sudo apt upgrade -y
sudo apt update && sudo apt install -y jq

echo "Настройка DNS..."
echo -e "nameserver 8.8.4.4\nnameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null

# Установка Xray
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install

# Определяем директорию скрипта
#SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
SCRIPT_DIR=/usr/local/etc/xray

# Генерируем переменные
xray_uuid_vrv=$(xray uuid)
domains=(www.theregister.com www.20minutes.fr www.dealabs.com www.manomano.fr www.caradisiac.com www.techadvisor.com www.computerworld.com teamdocs.su wikiportal.su docscenter.su www.bing.com github.com tradingview.com)
xray_dest_vrv=${domains[$RANDOM % ${#domains[@]}]}
xray_dest_vrv1=${domains[$RANDOM % ${#domains[@]}]}
xray_dest_vrv2=${domains[$RANDOM % ${#domains[@]}]}
xray_dest_vrv3=${domains[$RANDOM % ${#domains[@]}]}
xray_dest_vrv4=${domains[$RANDOM % ${#domains[@]}]}
xray_dest_vrv5=${domains[$RANDOM % ${#domains[@]}]}
xray_dest_vrv222=${domains[$RANDOM % ${#domains[@]}]}

key_output=$(xray x25519)
xray_privateKey_vrv=$(echo "$key_output" | awk -F': ' '/Private key/ {print $2}')
xray_publicKey_vrv=$(echo "$key_output" | awk -F': ' '/Public key/ {print $2}')

xray_shortIds_vrv=$(openssl rand -hex 8)

xray_sspasw_vrv=$(openssl rand -base64 15 | tr -dc 'A-Za-z0-9' | head -c 20)

ipserv=$(hostname -I | awk '{print $1}')



# Экспортируем переменные для envsubst
export xray_uuid_vrv xray_dest_vrv xray_dest_vrv1 xray_dest_vrv2 xray_dest_vrv3 xray_dest_vrv4 xray_dest_vrv5 xray_dest_vrv222 xray_privateKey_vrv xray_publicKey_vrv xray_shortIds_vrv xray_sspasw_vrv

# Создаем JSON конфигурацию на основе шаблона
#cat << 'EOF' | envsubst > output.json
# Создаем JSON конфигурацию на основе шаблона и сохраняем в папку скрипта
cat << 'EOF' | envsubst > "$SCRIPT_DIR/config.json"
{
    "dns": {
        "servers": [
            "https+local://8.8.4.4/dns-query",
            "https+local://8.8.8.8/dns-query",
            "localhost"
        ]
    },
    "log": {
        "loglevel": "none",
        "dnsLog": false
    },
    "routing": {
        "rules": [
            {
                "domain": [
                    "geosite:category-ads",
                    "geosite:win-spy"
                ],
                "outboundTag": "block"
            },
            {
                "ip": [
                    "geoip:private"
                ],
                "outboundTag": "block",
                "type": "field"
            }
        ]
    },
    "inbounds": [
        {
            "tag": "VLESStcpREALITY",
            "listen": "0.0.0.0",
            "port": 443,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "flow": "xtls-rprx-vision",
                        "id": "${xray_uuid_vrv}"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "tcp",
                "security": "reality",
                "realitySettings": {
                    "show": false,
                    "target": "${xray_dest_vrv}:443",
                    "xver": 0,
                    "serverNames": [
                        "${xray_dest_vrv}"
                    ],
                    "privateKey": "${xray_privateKey_vrv}",
                    "publicKey": "${xray_publicKey_vrv}",
                    "shortIds": [
                        "${xray_shortIds_vrv}"
                    ]
                }
            },
            "sniffing": {
                "enabled": true,
                "destOverride": [
                    "http",
                    "tls",
                    "quic"
                ]
            }
        },

 # Мои правки Пользователь 1
 {
            "tag": "VlessUser1",
            "listen": "0.0.0.0",
            "port": 443,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "flow": "xtls-rprx-vision",
                        "id": "${xray_uuid_vrv}"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "tcp",
                "security": "reality",
                "realitySettings": {
                    "show": false,
                    "target": "${xray_dest_vrv1}:443",
                    "xver": 0,
                    "serverNames": [
                        "${xray_dest_vrv1}"
                    ],
                    "privateKey": "${xray_privateKey_vrv}",
                    "publicKey": "${xray_publicKey_vrv}",
                    "shortIds": [
                        "${xray_shortIds_vrv}"
                    ]
                }
            },
            "sniffing": {
                "enabled": true,
                "destOverride": [
                    "http",
                    "tls",
                    "quic"
                ]
            }
        },
 # Конец правок

  # Мои правки Пользователь 2
 {
            "tag": "VlessUser2",
            "listen": "0.0.0.0",
            "port": 443,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "flow": "xtls-rprx-vision",
                        "id": "${xray_uuid_vrv}"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "tcp",
                "security": "reality",
                "realitySettings": {
                    "show": false,
                    "target": "${xray_dest_vrv2}:443",
                    "xver": 0,
                    "serverNames": [
                        "${xray_dest_vrv2}"
                    ],
                    "privateKey": "${xray_privateKey_vrv}",
                    "publicKey": "${xray_publicKey_vrv}",
                    "shortIds": [
                        "${xray_shortIds_vrv}"
                    ]
                }
            },
            "sniffing": {
                "enabled": true,
                "destOverride": [
                    "http",
                    "tls",
                    "quic"
                ]
            }
        },
 # Конец правок
  # Мои правки Пользователь 3
 {
            "tag": "VlessUser3",
            "listen": "0.0.0.0",
            "port": 443,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "flow": "xtls-rprx-vision",
                        "id": "${xray_uuid_vrv}"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "tcp",
                "security": "reality",
                "realitySettings": {
                    "show": false,
                    "target": "${xray_dest_vrv3}:443",
                    "xver": 0,
                    "serverNames": [
                        "${xray_dest_vrv3}"
                    ],
                    "privateKey": "${xray_privateKey_vrv}",
                    "publicKey": "${xray_publicKey_vrv}",
                    "shortIds": [
                        "${xray_shortIds_vrv}"
                    ]
                }
            },
            "sniffing": {
                "enabled": true,
                "destOverride": [
                    "http",
                    "tls",
                    "quic"
                ]
            }
        },
 # Конец правок
  # Мои правки Пользователь 4
 {
            "tag": "VlessUser4",
            "listen": "0.0.0.0",
            "port": 443,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "flow": "xtls-rprx-vision",
                        "id": "${xray_uuid_vrv}"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "tcp",
                "security": "reality",
                "realitySettings": {
                    "show": false,
                    "target": "${xray_dest_vrv4}:443",
                    "xver": 0,
                    "serverNames": [
                        "${xray_dest_vrv4}"
                    ],
                    "privateKey": "${xray_privateKey_vrv}",
                    "publicKey": "${xray_publicKey_vrv}",
                    "shortIds": [
                        "${xray_shortIds_vrv}"
                    ]
                }
            },
            "sniffing": {
                "enabled": true,
                "destOverride": [
                    "http",
                    "tls",
                    "quic"
                ]
            }
        },
 # Конец правок
  # Мои правки Пользователь 5
 {
            "tag": "VlessUser5",
            "listen": "0.0.0.0",
            "port": 443,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "flow": "xtls-rprx-vision",
                        "id": "${xray_uuid_vrv}"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "tcp",
                "security": "reality",
                "realitySettings": {
                    "show": false,
                    "target": "${xray_dest_vrv5}:443",
                    "xver": 0,
                    "serverNames": [
                        "${xray_dest_vrv5}"
                    ],
                    "privateKey": "${xray_privateKey_vrv}",
                    "publicKey": "${xray_publicKey_vrv}",
                    "shortIds": [
                        "${xray_shortIds_vrv}"
                    ]
                }
            },
            "sniffing": {
                "enabled": true,
                "destOverride": [
                    "http",
                    "tls",
                    "quic"
                ]
            }
        },
 # Конец правок
        {
            "tag": "Vless8443",
            "listen": "0.0.0.0",
            "port": 8443,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "flow": "xtls-rprx-vision",
                        "id": "${xray_uuid_vrv}"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "tcp",
                "security": "reality",
                "realitySettings": {
                    "show": false,
                    "target": "${xray_dest_vrv222}:443",
                    "xver": 0,
                    "serverNames": [
                        "${xray_dest_vrv222}"
                    ],
                    "privateKey": "${xray_privateKey_vrv}",
                    "publicKey": "${xray_publicKey_vrv}",
                    "shortIds": [
                        "${xray_shortIds_vrv}"
                    ]
                }
            },
            "sniffing": {
                "enabled": true,
                "destOverride": [
                    "http",
                    "tls",
                    "quic"
                ]
            }
        },
        {
            "tag": "ShadowsocksTCP",
            "listen": "0.0.0.0",
            "port": 2040,
            "protocol": "shadowsocks",
            "settings": {
                "clients": [
                    {
                        "password": "${xray_sspasw_vrv}",
                        "method": "chacha20-ietf-poly1305"
                    }
                ],
                "network": "tcp,udp"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "tag": "direct"
        },
        {
            "protocol": "blackhole",
            "tag": "block"
        }
    ]
}

EOF

# Перезапуск Xray
echo "Перезапуск Xray..."
sudo systemctl restart xray

echo "Готово!
"
# Формирование ссылок для ТГ
link1="vless://${xray_uuid_vrv}@${ipserv}:443?security=reality%26sni=${xray_dest_vrv}%26fp=chrome%26pbk=${xray_publicKey_vrv}%26sid=${xray_shortIds_vrv}%26type=tcp%26flow=xtls-rprx-vision%26encryption=none#VPN-vless-443"

link2="vless://${xray_uuid_vrv}@${ipserv}:8443?security=reality%26sni=${xray_dest_vrv222}%26fp=chrome%26pbk=${xray_publicKey_vrv}%26sid=${xray_shortIds_vrv}%26type=tcp%26flow=xtls-rprx-vision%26encryption=none#VPN-vless-8443"

ENCODED_STRING=$(echo -n "chacha20-ietf-poly1305:${xray_sspasw_vrv}" | base64)
link3="ss://$ENCODED_STRING@${ipserv}:2040#VPN-ShadowS-2040"


userID=$1
tgTOKEN=$2

if [ -n "$userID" ]; then
# Формируем сообщение (в Markdown для красивого вида)
message="<b>VPN конфиги:</b>
 
1) <code>$link1</code>
 
2) <code>$link2</code>
 
3) <code>$link3</code>

4) <code>$link4</code>
 
5) <code>$link5</code>
 
6) <code>$link6</code>

7) <code>$link7</code>
 
8) <code>$link8</code>



№1 - самый надежный, остальные резервные!

Клиентские приложения для работы VPN (куда нужно вставить конфиг):

- <b>iOS</b>: <a href='https://apps.apple.com/us/app/happ-proxy-utility/id6504287215?l=ru'>Happ</a> или <a href='https://apps.apple.com/us/app/v2raytun/id6476628951?l=ru'>v2rayTun</a> или FoXray

- <b>Android</b>: <a href='https://play.google.com/store/apps/details?id=com.happproxy'>Happ</a> или <a href='https://play.google.com/store/apps/details?id=com.v2raytun.android'>v2rayTun</a> или <a href='https://play.google.com/store/apps/details?id=com.v2ray.ang'>v2rayNG</a>

- <b>Windows</b>: <a href='https://github.com/hiddify/hiddify-next/releases/latest/download/Hiddify-Windows-Setup-x64.exe'>Hiddify</a> или <a href='https://github.com/MatsuriDayo/nekoray/releases'>Nekoray</a>

Сайт с инструкциями: <a href='https://blog.skybridge.run/'>blog.skybridge.run</a>.

<a href='https://github.com/xVRVx/autoXRAY'>Поддержать автора</a>.
"

# Отправка сообщения в Telegram
curl -s -X POST "https://api.telegram.org/bot$tgTOKEN/sendMessage" \
    -d chat_id="$userID" \
    -d text="$message" \
    -d parse_mode="HTML" \
    -d disable_web_page_preview=true
fi	

# Формирование ссылок для вывода
link1="vless://${xray_uuid_vrv}@${ipserv}:443?security=reality&sni=${xray_dest_vrv}&fp=chrome&pbk=${xray_publicKey_vrv}&sid=${xray_shortIds_vrv}&type=tcp&flow=xtls-rprx-vision&encryption=none#VPN-vless-443"
link4="vless://${xray_uuid_vrv}@${ipserv}:443?security=reality&sni=${xray_dest_vrv1}&fp=chrome&pbk=${xray_publicKey_vrv}&sid=${xray_shortIds_vrv}&type=tcp&flow=xtls-rprx-vision&encryption=none#VPN-vless-443"
link5="vless://${xray_uuid_vrv}@${ipserv}:443?security=reality&sni=${xray_dest_vrv2}&fp=chrome&pbk=${xray_publicKey_vrv}&sid=${xray_shortIds_vrv}&type=tcp&flow=xtls-rprx-vision&encryption=none#VPN-vless-443"
link6="vless://${xray_uuid_vrv}@${ipserv}:443?security=reality&sni=${xray_dest_vrv3}&fp=chrome&pbk=${xray_publicKey_vrv}&sid=${xray_shortIds_vrv}&type=tcp&flow=xtls-rprx-vision&encryption=none#VPN-vless-443"
link7="vless://${xray_uuid_vrv}@${ipserv}:443?security=reality&sni=${xray_dest_vrv4}&fp=chrome&pbk=${xray_publicKey_vrv}&sid=${xray_shortIds_vrv}&type=tcp&flow=xtls-rprx-vision&encryption=none#VPN-vless-443"
link8="vless://${xray_uuid_vrv}@${ipserv}:443?security=reality&sni=${xray_dest_vrv5}&fp=chrome&pbk=${xray_publicKey_vrv}&sid=${xray_shortIds_vrv}&type=tcp&flow=xtls-rprx-vision&encryption=none#VPN-vless-443"

link2="vless://${xray_uuid_vrv}@${ipserv}:8443?security=reality&sni=${xray_dest_vrv222}&fp=chrome&pbk=${xray_publicKey_vrv}&sid=${xray_shortIds_vrv}&type=tcp&flow=xtls-rprx-vision&encryption=none#VPN-vless-8443"

ENCODED_STRING=$(echo -n "chacha20-ietf-poly1305:${xray_sspasw_vrv}" | base64)
link3="ss://$ENCODED_STRING@${ipserv}:2040#VPN-ShadowS-2040"
	
echo -e "

Ваши VPN конфиги. Первый - самый надежный, остальные резервные!

\033[32m$link1\033[0m
"
echo -e "\033[32m$link2\033[0m
"
echo -e "\033[32m$link3\033[0m
"
echo -e "\033[32m$link4\033[0m
"
echo -e "\033[32m$link5\033[0m
"
echo -e "\033[32m$link6\033[0m
"
echo -e "\033[32m$link7\033[0m
"
echo -e "\033[32m$link8\033[0m
Скопируйте конфиг в специализированное приложение:
- iOS: Happ или v2rayTun или FoXray
- Android: Happ или v2rayTun или v2rayNG
- Windows: Hiddify или Nekoray

Сайт с инструкциями: blog.skybridge.run

Поддержать автора: https://github.com/xVRVx/autoXRAY

"
