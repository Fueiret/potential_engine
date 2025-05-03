#!/bin/bash

# Если вызван с аргументом "list", выводим список устройств
if [ "$1" = "list" ]; then
    # Получаем список известных устройств с их статусом подключения
    bluetoothctl devices | while read -r line; do
        mac=$(echo "$line" | awk '{print $2}')
        alias=$(echo "$line" | cut -d ' ' -f 3-)
        connected=$(bluetoothctl info "$mac" | grep "Connected:" | awk '{print $2}')
        echo "$alias - $( [ "$connected" = "yes" ] && echo "Connected" || echo "Disconnected" )"
    done
    exit 0
fi

# Иначе выводим статус Bluetooth (вкл/выкл)
status=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')
if [ "$status" = "yes" ]; then
    echo " ON"
else
    echo " OFF"
fi

