pkgname="whatsdesk-deb"
gives="whatsdesk"
pkgver="0.3.15"
pkgrel=2
pkgdesc="Unofficial client of Whatsapp"
maintainer=("chrisb09 <christian.brinkmann09@gmail.com>")
arch=('amd64')
source_amd64=("https://zerkc.gitlab.io/whatsdesk/downloads/whatsdesk_${pkgver}_amd64.deb")
sha256sums_amd64=("ce1d579ebb3a7919b248737258860afe676b95a1bd456219de85a833067a9284")
url='https://gitlab.com/zerkc/whatsdesk'

post_install() {
  local icon status
  icon="$(mktemp)"
  download "https://gitlab.com/zerkc/whatsdesk/-/raw/cc1d9c3a3115827fc67dc42fc71b74710103d3d9/src/icon/logo.png" "${icon}" \
    && sha256sum -c <<< "ffa9fad8f2fb1937c458a53792fccc339f9011a0da6aca384282d82308c32e3a  ${icon}" \
    && sudo rm -f /usr/share/icons/hicolor/{16x16,32x32,48x48,64x64,128x128,256x256}/apps/whatsdesk.png \
    && sudo install -Dm644 "${icon}" /usr/share/icons/hicolor/512x512/apps/whatsdesk.png
  status=$?
  rm -f "${icon}"
  ((status == 0)) || return "${status}"
  if command -v update-icon-caches > /dev/null; then
    sudo update-icon-caches /usr/share/icons/hicolor
  fi
}

post_remove() {
  sudo rm -f /usr/share/icons/hicolor/512x512/apps/whatsdesk.png
  if command -v update-icon-caches > /dev/null; then
    sudo update-icon-caches /usr/share/icons/hicolor
  fi
}
