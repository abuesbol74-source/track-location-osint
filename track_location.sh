
#!/bin/bash

# =============================================================================
# ████████╗██████╗  █████╗  ██████╗██╗  ██╗    ██╗      ██████╗  ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
# ╚══██╔══╝██╔══██╗██╔══██╗██╔════╝██║ ██╔╝    ██║     ██╔═══██╗██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
#    ██║   ██████╔╝███████║██║     █████╔╝     ██║     ██║   ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║
#    ██║   ██╔══██╗██╔══██║██║     ██╔═██╗     ██║     ██║   ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
#    ██║   ██║  ██║██║  ██║╚██████╗██║  ██╗    ███████╗╚██████╔╝╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
#    ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
# =============================================================================
#                    TRACK LOCATION - ALL FEATURES
# =============================================================================
#        [[ -where anonymous - by Laksamana Dzu Nur AIN - ]]
# =============================================================================
# 🌍  FITUR LENGKAP 100%:
#     ✅ Propinsi, Kabupaten, Kecamatan, Desa, Kelurahan
#     ✅ RT/RW (paling detail)
#     ✅ Nomor Telepon (info provider + kode area)
#     ✅ IP Address (geolokasi real)
#     ✅ NIK (parse kode wilayah + tanggal lahir)
#     ✅ SIM (info via Korlantas)
#     ✅ KK (parse kode wilayah)
#     ✅ Paspor (info via Imigrasi)
#     ✅ Google Maps untuk SEMUA lokasi
# =============================================================================

# ============================================================
# WARNA (MERAH & KUNING)
# ============================================================
R='\033[0;31m'        # MERAH
R1='\033[1;31m'       # MERAH TERANG
R2='\033[5;31m'       # MERAH KEDIP
Y='\033[1;33m'        # KUNING
Y1='\033[5;33m'       # KUNING KEDIP
G='\033[0;32m'        # HIJAU (untuk sukses)
B='\033[1;34m'        # BIRU (untuk info)
P='\033[1;35m'        # UNGU
C='\033[1;36m'        # CYAN
W='\033[1;37m'        # PUTIH
N='\033[0m'           # RESET

# ============================================================
# LOGO TRACK LOCATION (MERAH & KUNING)
# ============================================================
show_logo() {
    clear
    echo -e "${R1}"
    echo "    ████████╗██████╗  █████╗  ██████╗██╗  ██╗    ██╗      ██████╗  ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗"
    echo "    ╚══██╔══╝██╔══██╗██╔══██╗██╔════╝██║ ██╔╝    ██║     ██╔═══██╗██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║"
    echo "       ██║   ██████╔╝███████║██║     █████╔╝     ██║     ██║   ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║"
    echo "       ██║   ██╔══██╗██╔══██║██║     ██╔═██╗     ██║     ██║   ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║"
    echo "       ██║   ██║  ██║██║  ██║╚██████╗██║  ██╗    ███████╗╚██████╔╝╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║"
    echo "       ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝"
    echo -e "${Y}"
    echo "===================================================================================================================="
    echo -e "${R1}                              TRACK LOCATION - ALL FEATURES 100%${N}"
    echo -e "${Y}===================================================================================================================="
    echo -e "${R1}        [[ -where anonymous - by Laksamana Dzu Nur AIN - ]]${N}"
    echo -e "${Y}===================================================================================================================="
    echo -e "${R1}🌍  FITUR LENGKAP: Propinsi, Kabupaten, Kecamatan, Desa, Kelurahan, RT/RW,${N}"
    echo -e "${R1}   NIK, SIM, KK, Paspor, Nomor HP, IP Address + Google Maps${N}"
    echo -e "${Y}===================================================================================================================="
    echo ""
}

# ============================================================
# CEK DEPENDENCIES
# ============================================================
check_deps() {
    echo -e "${Y}[*] Memeriksa dependencies...${N}"
    
    if ! command -v curl &> /dev/null; then
        echo -e "  ${R}✗ curl tidak ditemukan, menginstall...${N}"
        sudo apt install curl -y > /dev/null 2>&1
        echo -e "  ${G}✓ curl terinstall${N}"
    else
        echo -e "  ${G}✓ curl tersedia${N}"
    fi
    
    sleep 1
}

# ============================================================
# FUNGSI ENCODE URL
# ============================================================
url_encode() {
    local string="$1"
    local encoded=""
    local pos c o
    
    for (( pos=0 ; pos<${#string} ; pos++ )); do
        c=${string:$pos:1}
        case "$c" in
            [-_.~a-zA-Z0-9] ) o="${c}" ;;
            * ) printf -v o '%%%02x' "'$c"
        esac
        encoded+="${o}"
    done
    echo "${encoded}"
}

# ============================================================
# FUNGSI GOOGLE MAPS (CORE)
# ============================================================
get_google_maps() {
    local alamat="$1"
    local encoded=$(url_encode "$alamat")
    
    echo -e "\n${Y}[*] Mencari lokasi: ${W}$alamat${N}"
    echo -e "${R}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
    
    # Nominatim OpenStreetMap API (GRATIS)
    local response=$(curl -s "https://nominatim.openstreetmap.org/search?q=$encoded&format=json&limit=1" -A "Mozilla/5.0")
    
    local lat=$(echo $response | grep -o '"lat":"[^"]*"' | head -1 | cut -d'"' -f4)
    local lon=$(echo $response | grep -o '"lon":"[^"]*"' | head -1 | cut -d'"' -f4)
    local display=$(echo $response | grep -o '"display_name":"[^"]*"' | head -1 | cut -d'"' -f4 | sed 's/\\//g')
    
    if [ ! -z "$lat" ] && [ ! -z "$lon" ]; then
        echo -e "${R1}╔══════════════════════════════════════════════════════════════════════════╗${N}"
        echo -e "${R1}║              ✅ LOKASI DITEMUKAN!                                        ║${N}"
        echo -e "${R1}╠══════════════════════════════════════════════════════════════════════════╣${N}"
        echo -e "${R1}║${N}"
        echo -e "${R1}║  ${Y}Alamat Lengkap:${N}"
        echo -e "${R1}║  ${W}$display${N}"
        echo -e "${R1}║${N}"
        echo -e "${R1}║  ${Y}Latitude   : ${W}$lat${N}"
        echo -e "${R1}║  ${Y}Longitude  : ${W}$lon${N}"
        echo -e "${R1}║${N}"
        echo -e "${R1}║  ${Y}🗺️ GOOGLE MAPS${N}"
        echo -e "${R1}║  ${W}https://www.google.com/maps?q=$lat,$lon${N}"
        echo -e "${R1}║${N}"
        echo -e "${R1}╚══════════════════════════════════════════════════════════════════════════╝${N}"
        
        # Simpan history
        echo "$alamat|$lat|$lon|$display" >> /tmp/track_location_history.txt
        return 0
    else
        echo -e "${R1}╔══════════════════════════════════════════════════════════════════════════╗${N}"
        echo -e "${R1}║              ❌ LOKASI TIDAK DITEMUKAN                                   ║${N}"
        echo -e "${R1}╠══════════════════════════════════════════════════════════════════════════╣${N}"
        echo -e "${R1}║${N}"
        echo -e "${R1}║  ${Y}Coba dengan alamat yang lebih spesifik${N}"
        echo -e "${R1}║  ${Y}Contoh: tambahkan provinsi atau kode pos${N}"
        echo -e "${R1}║${N}"
        echo -e "${R1}╚══════════════════════════════════════════════════════════════════════════╝${N}"
        return 1
    fi
}

# ============================================================
# FUNGSI KONVERSI KODE PROVINSI
# ============================================================
provinsi_from_code() {
    local code=$1
    case $code in
        11) echo "ACEH" ;;
        12) echo "SUMATERA UTARA" ;;
        13) echo "SUMATERA BARAT" ;;
        14) echo "RIAU" ;;
        15) echo "JAMBI" ;;
        16) echo "SUMATERA SELATAN" ;;
        17) echo "BENGKULU" ;;
        18) echo "LAMPUNG" ;;
        19) echo "KEPULAUAN BANGKA BELITUNG" ;;
        21) echo "KEPULAUAN RIAU" ;;
        31) echo "DKI JAKARTA" ;;
        32) echo "JAWA BARAT" ;;
        33) echo "JAWA TENGAH" ;;
        34) echo "DI YOGYAKARTA" ;;
        35) echo "JAWA TIMUR" ;;
        36) echo "BANTEN" ;;
        51) echo "BALI" ;;
        52) echo "NUSA TENGGARA BARAT" ;;
        53) echo "NUSA TENGGARA TIMUR" ;;
        61) echo "KALIMANTAN BARAT" ;;
        62) echo "KALIMANTAN TENGAH" ;;
        63) echo "KALIMANTAN SELATAN" ;;
        64) echo "KALIMANTAN TIMUR" ;;
        65) echo "KALIMANTAN UTARA" ;;
        71) echo "SULAWESI UTARA" ;;
        72) echo "SULAWESI TENGAH" ;;
        73) echo "SULAWESI SELATAN" ;;
        74) echo "SULAWESI TENGGARA" ;;
        75) echo "GORONTALO" ;;
        76) echo "SULAWESI BARAT" ;;
        81) echo "MALUKU" ;;
        82) echo "MALUKU UTARA" ;;
        91) echo "PAPUA BARAT" ;;
        92) echo "PAPUA" ;;
        *) echo "PROVINSI TIDAK DIKENAL" ;;
    esac
}

# ============================================================
# FUNGSI KONVERSI KODE KABUPATEN (CONTOH UNTUK JAWA BARAT)
# ============================================================
kabupaten_jabar() {
    local code=$1
    case $code in
        01) echo "BOGOR" ;;
        02) echo "SUKABUMI" ;;
        03) echo "CIANJUR" ;;
        04) echo "BANDUNG" ;;
        05) echo "GARUT" ;;
        06) echo "TASIKMALAYA" ;;
        07) echo "CIAMIS" ;;
        08) echo "KUNINGAN" ;;
        09) echo "CIREBON" ;;
        10) echo "MAJALENGKA" ;;
        11) echo "SUMEDANG" ;;
        12) echo "INDRAMAYU" ;;
        13) echo "SUBANG" ;;
        14) echo "PURWAKARTA" ;;
        15) echo "KARAWANG" ;;
        16) echo "BEKASI" ;;
        17) echo "BANDUNG BARAT" ;;
        18) echo "PANGANDARAN" ;;
        71) echo "KOTA BOGOR" ;;
        72) echo "KOTA SUKABUMI" ;;
        73) echo "KOTA BANDUNG" ;;
        74) echo "KOTA CIREBON" ;;
        75) echo "KOTA BEKASI" ;;
        76) echo "KOTA DEPOK" ;;
        77) echo "KOTA CIMAHI" ;;
        78) echo "KOTA TASIKMALAYA" ;;
        79) echo "KOTA BANJAR" ;;
        *) echo "KABUPATEN/KOTA $code" ;;
    esac
}

# ============================================================
# 1. LACAK DARI PROPINSI
# ============================================================
track_provinsi() {
    show_logo
    echo -e "${R1}╔══════════════════════════════════════════════════════════╗${N}"
    echo -e "${R1}║              LACAK DARI PROPINSI                        ║${N}"
    echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
    echo ""
    
    read -p "$(echo -e "${Y}[?]${W} Nama Provinsi: ${N}")" provinsi
    
    if [ ! -z "$provinsi" ]; then
        get_google_maps "$provinsi, Indonesia"
    fi
}

# ============================================================
# 2. LACAK DARI KABUPATEN
# ============================================================
track_kabupaten() {
    show_logo
    echo -e "${R1}╔══════════════════════════════════════════════════════════╗${N}"
    echo -e "${R1}║              LACAK DARI KABUPATEN/KOTA                  ║${N}"
    echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
    echo ""
    
    read -p "$(echo -e "${Y}[?]${W} Nama Kabupaten/Kota: ${N}")" kabupaten
    read -p "$(echo -e "${Y}[?]${W} Provinsi (opsional): ${N}")" provinsi
    
    if [ ! -z "$provinsi" ]; then
        get_google_maps "$kabupaten, $provinsi, Indonesia"
    else
        get_google_maps "$kabupaten, Indonesia"
    fi
}

# ============================================================
# 3. LACAK DARI KECAMATAN
# ============================================================
track_kecamatan() {
    show_logo
    echo -e "${R1}╔══════════════════════════════════════════════════════════╗${N}"
    echo -e "${R1}║              LACAK DARI KECAMATAN                       ║${N}"
    echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
    echo ""
    
    read -p "$(echo -e "${Y}[?]${W} Nama Kecamatan: ${N}")" kecamatan
    read -p "$(echo -e "${Y}[?]${W} Kabupaten: ${N}")" kabupaten
    read -p "$(echo -e "${Y}[?]${W} Provinsi: ${N}")" provinsi
    
    get_google_maps "$kecamatan, $kabupaten, $provinsi, Indonesia"
}

# ============================================================
# 4. LACAK DARI DESA/KELURAHAN
# ============================================================
track_desa() {
    show_logo
    echo -e "${R1}╔══════════════════════════════════════════════════════════╗${N}"
    echo -e "${R1}║              LACAK DARI DESA/KELURAHAN                  ║${N}"
    echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
    echo ""
    
    read -p "$(echo -e "${Y}[?]${W} Nama Desa/Kelurahan: ${N}")" desa
    read -p "$(echo -e "${Y}[?]${W} Kecamatan: ${N}")" kecamatan
    read -p "$(echo -e "${Y}[?]${W} Kabupaten: ${N}")" kabupaten
    read -p "$(echo -e "${Y}[?]${W} Provinsi: ${N}")" provinsi
    
    get_google_maps "$desa, $kecamatan, $kabupaten, $provinsi, Indonesia"
}

# ============================================================
# 5. LACAK DARI RT/RW
# ============================================================
track_rtrw() {
    show_logo
    echo -e "${R1}╔══════════════════════════════════════════════════════════╗${N}"
    echo -e "${R1}║              LACAK DARI RT/RW                           ║${N}"
    echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
    echo ""
    
    read -p "$(echo -e "${Y}[?]${W} RT: ${N}")" rt
    read -p "$(echo -e "${Y}[?]${W} RW: ${N}")" rw
    read -p "$(echo -e "${Y}[?]${W} Desa/Kelurahan: ${N}")" desa
    read -p "$(echo -e "${Y}[?]${W} Kecamatan: ${N}")" kecamatan
    read -p "$(echo -e "${Y}[?]${W} Kabupaten: ${N}")" kabupaten
    read -p "$(echo -e "${Y}[?]${W} Provinsi: ${N}")" provinsi
    
    get_google_maps "RT $rt RW $rw, $desa, $kecamatan, $kabupaten, $provinsi, Indonesia"
}

# ============================================================
# 6. LACAK DARI NOMOR HP
# ============================================================
track_phone() {
    show_logo
    echo -e "${R1}╔══════════════════════════════════════════════════════════╗${N}"
    echo -e "${R1}║              LACAK DARI NOMOR HP                        ║${N}"
    echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
    echo ""
    
    read -p "$(echo -e "${Y}[?]${W} Masukkan nomor HP (62xx): ${N}")" nomor
    
    if [[ ! $nomor =~ ^[0-9]+$ ]] || [[ ${#nomor} -lt 10 ]]; then
        echo -e "${R}[✗] Nomor HP tidak valid!${N}"
        return
    fi
    
    # Deteksi provider
    if [[ $nomor == 62* ]]; then
        local prefix=${nomor:2:3}
        local provider=""
        local wilayah=""
        
        case $prefix in
            811|812|813|814|815|816|817|818|819) 
                provider="Telkomsel (SimPATI/KartuHalo)"
                wilayah="Jabodetabek, Jawa Barat, Banten"
                ;;
            821|822|823|824|825|826|827|828|829) 
                provider="Telkomsel (Loop)"
                wilayah="Jawa Tengah, DI Yogyakarta, Jawa Timur"
                ;;
            831|832|833|834|835|836|837|838|839) 
                provider="XL/Axiata"
                wilayah="Nasional"
                ;;
            851|852|853|854|855|856|857|858|859) 
                provider="Telkomsel (By.U)"
                wilayah="Jabodetek, Bandung, Surabaya, Medan"
                ;;
            881|882|883|884|885|886|887|888|889) 
                provider="Smartfren"
                wilayah="Jabodetabek, Bandung, Surabaya"
                ;;
            895|896|897|898|899) 
                provider="Three (Tri)"
                wilayah="Jabodetabek, Surabaya, Medan, Makassar"
                ;;
            *) 
                provider="Provider tidak diketahui"
                wilayah="Tidak diketahui"
                ;;
        esac
        
        local area_code=${nomor:2:2}
        local kota=""
        case $area_code in
            21) kota="Jakarta, Tangerang, Bekasi, Depok" ;;
            22) kota="Bandung, Cimahi" ;;
            24) kota="Semarang" ;;
            27) kota="Surakarta, Yogyakarta" ;;
            31) kota="Surabaya, Gresik" ;;
            34) kota="Malang" ;;
            61) kota="Medan" ;;
            62) kota="Batam, Tanjungpinang" ;;
            *) kota="Tidak dapat ditentukan" ;;
        esac
        
        echo -e "\n${R1}╔══════════════════════════════════════════════════════════╗${N}"
        echo -e "${R1}║              INFORMASI NOMOR HP                         ║${N}"
        echo -e "${R1}╠══════════════════════════════════════════════════════════╣${N}"
        echo -e "${R1}║${N}"
        echo -e "${R1}║  ${Y}Nomor HP       : ${W}$nomor${N}"
        echo -e "${R1}║  ${Y}Provider       : ${W}$provider${N}"
        echo -e "${R1}║  ${Y}Kode Area      : ${W}0$area_code${N}"
        echo -e "${R1}║  ${Y}Wilayah Operasi: ${W}$wilayah${N}"
        echo -e "${R1}║  ${Y}Kota (estimasi): ${W}$kota${N}"
        echo -e "${R1}║${N}"
        echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
        
        if [ "$kota" != "Tidak dapat ditentukan" ]; then
            echo ""
            read -p "$(echo -e "${Y}[?]${W} Cari lokasi $kota di Google Maps? (y/n): ${N}")" cari
            if [ "$cari" == "y" ]; then
                get_google_maps "$kota, Indonesia"
            fi
        fi
    else
        echo -e "${R}[✗] Saat ini hanya mendukung nomor Indonesia (62xx)${N}"
    fi
}

# ============================================================
# 7. LACAK DARI IP ADDRESS
# ============================================================
track_ip() {
    show_logo
    echo -e "${R1}╔══════════════════════════════════════════════════════════╗${N}"
    echo -e "${R1}║              LACAK DARI IP ADDRESS                      ║${N}"
    echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
    echo ""
    
    read -p "$(echo -e "${Y}[?]${W} Masukkan IP (kosongkan untuk IP sendiri): ${N}")" ip
    
    if [ -z "$ip" ]; then
        ip=$(curl -s ifconfig.me)
        echo -e "${W}  Menggunakan IP Anda: ${C}$ip${N}"
    fi
    
    # ip-api.com (GRATIS)
    local response=$(curl -s "http://ip-api.com/json/$ip?fields=status,country,regionName,city,district,zip,lat,lon,isp,org,mobile,proxy,query")
    local status=$(echo $response | grep -o '"status":"[^"]*"' | head -1 | cut -d'"' -f4)
    
    if [ "$status" == "success" ]; then
        local country=$(echo $response | grep -o '"country":"[^"]*"' | head -1 | cut -d'"' -f4)
        local region=$(echo $response | grep -o '"regionName":"[^"]*"' | head -1 | cut -d'"' -f4)
        local city=$(echo $response | grep -o '"city":"[^"]*"' | head -1 | cut -d'"' -f4)
        local district=$(echo $response | grep -o '"district":"[^"]*"' | head -1 | cut -d'"' -f4)
        local zip=$(echo $response | grep -o '"zip":"[^"]*"' | head -1 | cut -d'"' -f4)
        local lat=$(echo $response | grep -o '"lat":[^,]*' | head -1 | cut -d':' -f2)
        local lon=$(echo $response | grep -o '"lon":[^,]*' | head -1 | cut -d':' -f2)
        local isp=$(echo $response | grep -o '"isp":"[^"]*"' | head -1 | cut -d'"' -f4)
        local org=$(echo $response | grep -o '"org":"[^"]*"' | head -1 | cut -d'"' -f4)
        local mobile=$(echo $response | grep -o '"mobile":true' && echo "Ya" || echo "Tidak")
        local proxy=$(echo $response | grep -o '"proxy":true' && echo "Ya" || echo "Tidak")
        
        echo -e "\n${R1}╔══════════════════════════════════════════════════════════╗${N}"
        echo -e "${R1}║              LOKASI DARI IP                             ║${N}"
        echo -e "${R1}╠══════════════════════════════════════════════════════════╣${N}"
        echo -e "${R1}║${N}"
        echo -e "${R1}║  ${Y}🌐 INFORMASI IP${N}"
        echo -e "${R1}║  ${Y}  IP Address : ${W}$ip${N}"
        echo -e "${R1}║  ${Y}  ISP        : ${W}$isp${N}"
        echo -e "${R1}║  ${Y}  Organisasi : ${W}$org${N}"
        echo -e "${R1}║  ${Y}  Mobile     : ${W}$mobile${N}"
        echo -e "${R1}║  ${Y}  Proxy/VPN  : ${W}$proxy${N}"
        echo -e "${R1}║${N}"
        echo -e "${R1}║  ${Y}📍 LOKASI${N}"
        echo -e "${R1}║  ${Y}  Negara     : ${W}$country${N}"
        echo -e "${R1}║  ${Y}  Provinsi   : ${W}$region${N}"
        echo -e "${R1}║  ${Y}  Kota       : ${W}$city${N}"
        echo -e "${R1}║  ${Y}  Kecamatan  : ${W}${district:-Tidak tersedia}${N}"
        echo -e "${R1}║  ${Y}  Kode Pos   : ${W}${zip:-Tidak tersedia}${N}"
        echo -e "${R1}║  ${Y}  Latitude   : ${W}$lat${N}"
        echo -e "${R1}║  ${Y}  Longitude  : ${W}$lon${N}"
        echo -e "${R1}║${N}"
        echo -e "${R1}║  ${Y}🗺️ GOOGLE MAPS${N}"
        echo -e "${R1}║  ${W}https://www.google.com/maps?q=$lat,$lon${N}"
        echo -e "${R1}║${N}"
        echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
        
        # Simpan history
        echo "IP:$ip|$lat|$lon|$region, $city" >> /tmp/track_location_history.txt
    else
        echo -e "${R}[✗] Gagal mendapatkan data IP${N}"
    fi
}

# ============================================================
# 8. LACAK DARI NIK
# ============================================================
track_nik() {
    show_logo
    echo -e "${R1}╔══════════════════════════════════════════════════════════╗${N}"
    echo -e "${R1}║              LACAK DARI NIK                             ║${N}"
    echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
    echo ""
    
    read -p "$(echo -e "${Y}[?]${W} Masukkan NIK (16 digit): ${N}")" nik
    
    if [[ ${#nik} -ne 16 || ! $nik =~ ^[0-9]+$ ]]; then
        echo -e "${R}[✗] NIK harus 16 digit angka!${N}"
        return
    fi
    
    # Parse kode wilayah
    local prov_code=${nik:0:2}
    local kab_code=${nik:2:2}
    local kec_code=${nik:4:2}
    
    # Parse tanggal lahir
    local tgl=${nik:6:2}
    local bln=${nik:8:2}
    local thn=${nik:10:2}
    
    # Koreksi gender
    if [ $tgl -gt 40 ]; then
        tgl_aktual=$((tgl - 40))
        gender="PEREMPUAN"
    else
        tgl_aktual=$tgl
        gender="LAKI-LAKI"
    fi
    
    # Dapatkan nama provinsi
    local provinsi=$(provinsi_from_code $prov_code)
    
    # Dapatkan nama kabupaten (contoh untuk Jawa Barat)
    local kabupaten=""
    if [ "$prov_code" == "32" ]; then
        kabupaten=$(kabupaten_jabar $kab_code)
    else
        kabupaten="Kode $kab_code"
    fi
    
    # Tampilkan hasil
    echo -e "\n${R1}╔══════════════════════════════════════════════════════════╗${N}"
    echo -e "${R1}║              HASIL PARSE NIK                             ║${N}"
    echo -e "${R1}╠══════════════════════════════════════════════════════════╣${N}"
    echo -e "${R1}║${N}"
    echo -e "${R1}║  ${Y}NIK              : ${W}$nik${N}"
    echo -e "${R1}║  ${Y}Jenis Kelamin    : ${W}$gender${N}"
    echo -e "${R1}║  ${Y}Tanggal Lahir    : ${W}$tgl_aktual/$bln/19$thn${N}"
    echo -e "${R1}║${N}"
    echo -e "${R1}║  ${Y}Kode Provinsi    : ${W}$prov_code ($provinsi)${N}"
    echo -e "${R1}║  ${Y}Kode Kabupaten   : ${W}$kab_code ($kabupaten)${N}"
    echo -e "${R1}║  ${Y}Kode Kecamatan   : ${W}$kec_code${N}"
    echo -e "${R1}║${N}"
    echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
    
    # Tanya cari lokasi
    echo ""
    read -p "$(echo -e "${Y}[?]${W} Cari lokasi $provinsi di Google Maps? (y/n): ${N}")" cari
    if [ "$cari" == "y" ]; then
        get_google_maps "$provinsi, Indonesia"
    fi
}

# ============================================================
# 9. LACAK DARI KK
# ============================================================
track_kk() {
    show_logo
    echo -e "${R1}╔══════════════════════════════════════════════════════════╗${N}"
    echo -e "${R1}║              LACAK DARI KK (Kartu Keluarga)             ║${N}"
    echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
    echo ""
    
    read -p "$(echo -e "${Y}[?]${W} Masukkan 6 digit pertama KK (kode wilayah): ${N}")" kode
    
    if [[ ${#kode} -ne 6 || ! $kode =~ ^[0-9]+$ ]]; then
        echo -e "${R}[✗] Kode wilayah harus 6 digit angka!${N}"
        return
    fi
    
    # Parse kode wilayah
    local prov_code=${kode:0:2}
    local kab_code=${kode:2:2}
    local kec_code=${kode:4:2}
    
    # Dapatkan nama provinsi
    local provinsi=$(provinsi_from_code $prov_code)
    
    # Dapatkan nama kabupaten (contoh untuk Jawa Barat)
    local kabupaten=""
    if [ "$prov_code" == "32" ]; then
        kabupaten=$(kabupaten_jabar $kab_code)
    else
        kabupaten="Kode $kab_code"
    fi
    
    echo -e "\n${R1}╔══════════════════════════════════════════════════════════╗${N}"
    echo -e "${R1}║              INFORMASI KK                               ║${N}"
    echo -e "${R1}╠══════════════════════════════════════════════════════════╣${N}"
    echo -e "${R1}║${N}"
    echo -e "${R1}║  ${Y}Kode Wilayah    : ${W}$kode${N}"
    echo -e "${R1}║  ${Y}Provinsi        : ${W}$provinsi ($prov_code)${N}"
    echo -e "${R1}║  ${Y}Kabupaten/Kota  : ${W}$kabupaten ($kab_code)${N}"
    echo -e "${R1}║  ${Y}Kecamatan       : ${W}Kode $kec_code${N}"
    echo -e "${R1}║${N}"
    echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
    
    # Tanya cari lokasi
    echo ""
    read -p "$(echo -e "${Y}[?]${W} Cari lokasi $provinsi di Google Maps? (y/n): ${N}")" cari
    if [ "$cari" == "y" ]; then
        get_google_maps "$provinsi, Indonesia"
    fi
}

# ============================================================
# 10. LACAK DARI SIM
# ============================================================
track_sim() {
    show_logo
    echo -e "${R1}╔══════════════════════════════════════════════════════════╗${N}"
    echo -e "${R1}║              LACAK DARI SIM                             ║${N}"
    echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
    echo ""
    
    echo -e "${Y}Pilih metode:${N}"
    echo "1. Cek via Website Korlantas (online)"
    echo "2. Info call center"
    echo "0. Kembali"
    echo ""
    
    read -p "$(echo -e "${Y}[?]${W} Pilih [0-2]: ${N}")" metode
    
    case $metode in
        1)
            read -p "$(echo -e "${Y}[?]${W} Masukkan nomor SIM: ${N}")" no_sim
            echo -e "\n${R1}╔══════════════════════════════════════════════════════════╗${N}"
            echo -e "${R1}║              INFORMASI CEK SIM                          ║${N}"
            echo -e "${R1}╠══════════════════════════════════════════════════════════╣${N}"
            echo -e "${R1}║${N}"
            echo -e "${R1}║  ${Y}Langkah-langkah:${N}"
            echo -e "${R1}║  ${W}1. Buka website: ${C}http://sim.korlantas.polri.go.id${N}"
            echo -e "${R1}║  ${W}2. Pilih menu 'Cek SIM'${N}"
            echo -e "${R1}║  ${W}3. Masukkan nomor SIM: $no_sim${N}"
            echo -e "${R1}║  ${W}4. Akan muncul data status berlaku dan masa berlaku${N}"
            echo -e "${R1}║${N}"
            echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
            ;;
        2)
            echo -e "\n${R1}╔══════════════════════════════════════════════════════════╗${N}"
            echo -e "${R1}║              LAYANAN RESMI SIM                          ║${N}"
            echo -e "${R1}╠══════════════════════════════════════════════════════════╣${N}"
            echo -e "${R1}║${N}"
            echo -e "${R1}║  ${Y}Call Center Korlantas: ${W}(021) 7001000${N}"
            echo -e "${R1}║  ${Y}Website: ${W}http://korlantas.polri.go.id${N}"
            echo -e "${R1}║  ${Y}Kantor Satpas terdekat untuk cek manual${N}"
            echo -e "${R1}║${N}"
            echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
            ;;
        0) return ;;
        *) echo -e "${R}Pilihan tidak valid!${N}" ;;
    esac
}

# ============================================================
# 11. LACAK DARI PASPOR
# ============================================================
track_paspor() {
    show_logo
    echo -e "${R1}╔══════════════════════════════════════════════════════════╗${N}"
    echo -e "${R1}║              LACAK DARI PASPOR                          ║${N}"
    echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
    echo ""
    
    echo -e "${Y}Pilih metode:${N}"
    echo "1. Cek via Website Imigrasi (online)"
    echo "2. Cek via Aplikasi M-Paspor"
    echo "3. Info call center"
    echo "0. Kembali"
    echo ""
    
    read -p "$(echo -e "${Y}[?]${W} Pilih [0-3]: ${N}")" metode
    
    case $metode in
        1)
            echo -e "\n${R1}╔══════════════════════════════════════════════════════════╗${N}"
            echo -e "${R1}║              CEK STATUS PASPOR ONLINE                   ║${N}"
            echo -e "${R1}╠══════════════════════════════════════════════════════════╣${N}"
            echo -e "${R1}║${N}"
            echo -e "${R1}║  ${Y}Langkah-langkah:${N}"
            echo -e "${R1}║  ${W}1. Buka ${C}https://www.imigrasi.go.id${N}"
            echo -e "${R1}║  ${W}2. Pilih menu 'Layanan' → 'Pelacakan Status'${N}"
            echo -e "${R1}║  ${W}3. Masukkan nomor pendaftaran/identitas${N}"
            echo -e "${R1}║  ${W}4. Akan muncul status permohonan paspor${N}"
            echo -e "${R1}║${N}"
            echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
            ;;
        2)
            echo -e "\n${R1}╔══════════════════════════════════════════════════════════╗${N}"
            echo -e "${R1}║              APLIKASI M-PASPOR                         ║${N}"
            echo -e "${R1}╠══════════════════════════════════════════════════════════╣${N}"
            echo -e "${R1}║${N}"
            echo -e "${R1}║  ${Y}Cara cek via M-Paspor:${N}"
            echo -e "${R1}║  ${W}1. Download aplikasi M-Paspor di Play Store/App Store${N}"
            echo -e "${R1}║  ${W}2. Login dengan akun Anda${N}"
            echo -e "${R1}║  ${W}3. Masuk ke menu 'Riwayat Permohonan'${N}"
            echo -e "${R1}║  ${W}4. Akan muncul daftar pengajuan paspor${N}"
            echo -e "${R1}║${N}"
            echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
            ;;
        3)
            echo -e "\n${R1}╔══════════════════════════════════════════════════════════╗${N}"
            echo -e "${R1}║              CALL CENTER IMIGRASI                       ║${N}"
            echo -e "${R1}╠══════════════════════════════════════════════════════════╣${N}"
            echo -e "${R1}║${N}"
            echo -e "${R1}║  ${Y}Call Center: ${W}(021) 1500-765${N}"
            echo -e "${R1}║  ${Y}Website: ${W}https://www.imigrasi.go.id${N}"
            echo -e "${R1}║  ${Y}Aplikasi: ${W}Sahabat Imigrasi${N}"
            echo -e "${R1}║${N}"
            echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
            ;;
        0) return ;;
        *) echo -e "${R}Pilihan tidak valid!${N}" ;;
    esac
}

# ============================================================
# 12. LACAK DARI ALAMAT MANUAL
# ============================================================
track_manual() {
    show_logo
    echo -e "${R1}╔══════════════════════════════════════════════════════════╗${N}"
    echo -e "${R1}║              LACAK DARI ALAMAT LENGKAP                  ║${N}"
    echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
    echo ""
    
    echo -e "${Y}Masukkan alamat lengkap (semakin detail semakin baik)${N}"
    echo ""
    read -p "$(echo -e "${Y}[?]${W} Alamat: ${N}")" alamat
    
    if [ ! -z "$alamat" ]; then
        get_google_maps "$alamat"
    fi
}

# ============================================================
# 13. LIHAT HISTORY
# ============================================================
lihat_history() {
    show_logo
    echo -e "${R1}╔══════════════════════════════════════════════════════════╗${N}"
    echo -e "${R1}║              HISTORY PENCARIAN                          ║${N}"
    echo -e "${R1}╚══════════════════════════════════════════════════════════╝${N}"
    echo ""
    
    if [ -f /tmp/track_location_history.txt ]; then
        local count=1
        while IFS='|' read query lat lon display; do
            echo -e "${R1}$count.${Y} Query: ${W}$query${N}"
            echo -e "   ${Y}→ ${W}$display${N}"
            echo -e "   ${Y}📌 ${W}https://www.google.com/maps?q=$lat,$lon${N}"
            echo ""
            count=$((count+1))
        done < /tmp/track_location_history.txt
    else
        echo -e "${Y}Belum ada history pencarian${N}"
    fi
}

# ============================================================
# MAIN MENU
# ============================================================
main_menu() {
    check_deps
    
    while true; do
        show_logo
        
        echo -e "${R1}╔══════════════════════════════════════════════════════════════════════════╗${N}"
        echo -e "${R1}║                         🌍 TRACK LOCATION - MENU                         ║${N}"
        echo -e "${R1}╠══════════════════════════════════════════════════════════════════════════╣${N}"
        echo -e "${R1}║                                                                          ║${N}"
        echo -e "${R1}║  ${Y}[1]${R1}  LACAK DARI PROPINSI         ${Y}[8]${R1}  LACAK DARI NIK           ${R1}║${N}"
        echo -e "${R1}║  ${Y}[2]${R1}  LACAK DARI KABUPATEN        ${Y}[9]${R1}  LACAK DARI KK            ${R1}║${N}"
        echo -e "${R1}║  ${Y}[3]${R1}  LACAK DARI KECAMATAN        ${Y}[10]${R1} LACAK DARI SIM           ${R1}║${N}"
        echo -e "${R1}║  ${Y}[4]${R1}  LACAK DARI DESA/KELURAHAN   ${Y}[11]${R1} LACAK DARI PASPOR        ${R1}║${N}"
        echo -e "${R1}║  ${Y}[5]${R1}  LACAK DARI RT/RW            ${Y}[12]${R1} LACAK DARI ALAMAT MANUAL ${R1}║${N}"
        echo -e "${R1}║  ${Y}[6]${R1}  LACAK DARI NOMOR HP         ${Y}[13]${R1} LIHAT HISTORY            ${R1}║${N}"
        echo -e "${R1}║  ${Y}[7]${R1}  LACAK DARI IP ADDRESS       ${Y}[0]${R1}  KELUAR                   ${R1}║${N}"
        echo -e "${R1}║                                                                          ║${N}"
        echo -e "${R1}╚══════════════════════════════════════════════════════════════════════════╝${N}"
        echo ""
        read -p "$(echo -e "${Y}[?]${W} Pilih menu [0-13]: ${N}")" choice
        
        case $choice in
            1) track_provinsi ;;
            2) track_kabupaten ;;
            3) track_kecamatan ;;
            4) track_desa ;;
            5) track_rtrw ;;
            6) track_phone ;;
            7) track_ip ;;
            8) track_nik ;;
            9) track_kk ;;
            10) track_sim ;;
            11) track_paspor ;;
            12) track_manual ;;
            13) lihat_history ;;
            0)
                echo -e "\n${Y}[[ -where anonymous - by Laksamana Dzu Nur AIN - ]]${N}"
                echo -e "${R1}Sampai jumpa!${N}"
                exit 0
                ;;
            *)
                echo -e "${R}Pilihan tidak valid!${N}"
                ;;
        esac
        
        echo -e "\n${Y}Tekan Enter untuk kembali ke menu...${N}"
        read
    done
}

# ============================================================
# START
# ============================================================
main_menu
