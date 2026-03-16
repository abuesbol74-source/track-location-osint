#!/bin/bash

# =============================================================================
# ████████╗██████╗  █████╗  ██████╗██╗  ██╗    ██╗      ██████╗  ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
# ╚══██╔══╝██╔══██╗██╔══██╗██╔════╝██║ ██╔╝    ██║     ██╔═══██╗██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
#    ██║   ██████╔╝███████║██║     █████╔╝     ██║     ██║   ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║
#    ██║   ██╔══██╗██╔══██║██║     ██╔═██╗     ██║     ██║   ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
#    ██║   ██║  ██║██║  ██║╚██████╗██║  ██╗    ███████╗╚██████╔╝╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
#    ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
# =============================================================================
#                    TRACK LOCATION - ALL FEATURES 100%
# =============================================================================
#         [[ -where anonymous - by Laksamana Dzu Nur AIN - ]]
# =============================================================================

# WARNA
R='\033[0;31m'   # MERAH
R1='\033[1;31m'  # MERAH TERANG
Y='\033[1;33m'   # KUNING
G='\033[0;32m'   # HIJAU
W='\033[1;37m'   # PUTIH
C='\033[1;36m'   # CYAN
N='\033[0m'      # RESET

show_logo() {
    clear
    echo -e "${R1}"
    echo "    ████████╗██████╗  █████╗  ██████╗██╗  ██╗    ██╗      ██████╗  ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗"
    echo "    ╚══██╔══╝██╔══██╗██╔══██╗██╔════╝██║ ██╔╝    ██║     ██╔═══██╗██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║"
    echo "       ██║   ██████╔╝███████║██║     █████╔╝     ██║     ██║   ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║"
    echo "       ██║   ██╔══██╗██╔══██║██║     ██╔═██╗     ██║     ██║   ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║"
    echo "       ██║   ██║  ██║██║  ██║╚██████╗██║  ██╗    ███████╗╚██████╔╝╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║"
    echo "       ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝"
    echo -e "${Y}===================================================================================================================="
    echo -e "${R1}                               TRACK LOCATION - ALL FEATURES 100%${N}"
    echo -e "${Y}===================================================================================================================="
}

get_google_maps() {
    local alamat="$1"
    local encoded=$(echo "$alamat" | sed 's/ /+/g')
    echo -e "\n${Y}[*] Mencari lokasi: ${W}$alamat${N}"
    echo -e "${R1}╔══════════════════════════════════════════════════════════════════════════╗${N}"
    echo -e "${R1}║  ${Y}🗺️ GOOGLE MAPS${N}"
    echo -e "${R1}║  ${W}https://www.google.com/maps/search/$encoded${N}"
    echo -e "${R1}╚══════════════════════════════════════════════════════════════════════════╝${N}"
}

track_ip() {
    show_logo
    read -p "$(echo -e ${Y}[?]${W} Masukkan IP (Kosongkan untuk IP sendiri): ${N})" ip
    [ -z "$ip" ] && ip=$(curl -s ifconfig.me)
    echo -e "${Y}[*] Mendapatkan data IP: $ip...${N}"
    RESP=$(curl -s "http://ip-api.com/json/$ip")
    echo -e "\n${R1}Status:${N} $(echo $RESP | jq -r '.status')"
    echo -e "${R1}Negara:${N} $(echo $RESP | jq -r '.country')"
    echo -e "${R1}ISP   :${N} $(echo $RESP | jq -r '.isp')"
    echo -e "${R1}Maps  :${N} http://www.google.com/maps/place/$(echo $RESP | jq -r '.lat'),$(echo $RESP | jq -r '.lon')"
    read -p "Kembali ke Menu..."
}

track_nik() {
    show_logo
    read -p "$(echo -e ${Y}[?]${W} Masukkan NIK (16 digit): ${N})" nik
    if [[ ${#nik} -eq 16 ]]; then
        prov=${nik:0:2}; kab=${nik:2:2}; kec=${nik:4:2}
        echo -e "\n${R1}HASIL PARSE NIK:${N} $nik"
        echo -e "${Y}Provinsi :${N} $prov"; echo -e "${Y}Kabupaten:${N} $kab"; echo -e "${Y}Kecamatan:${N} $kec"
    else
        echo -e "${R}[!] NIK harus 16 digit!${N}"
    fi
    read -p "Kembali ke Menu..."
}

while true; do
    show_logo
    echo -e "${Y}[01]${W} Lacak IP Address"
    echo -e "${Y}[02]${W} Lacak NIK"
    echo -e "${Y}[03]${W} Lacak Alamat Manual"
    echo -e "${Y}[00]${R1} KELUAR${N}"
    echo ""
    read -p "$(echo -e ${Y}ABU_ESBOL@Track:~# ${N})" menu
    case $menu in
        01|1) track_ip ;;
        02|2) track_nik ;;
        03|3) read -p "Alamat: " alm; get_google_maps "$alm"; read -p "..." ;;
        00|0) exit 0 ;;
    esac
done
