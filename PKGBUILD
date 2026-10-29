_pkgname="grub-secureboot-reinstall-hook"
pkgname="${_pkgname}"
pkgver=1.0
pkgrel=1
pkgdesc="Pacman hook to automatically reinstall GRUB via grub-mkstandalone"
arch=('x86_64')
license=('MIT')
depends=('grub' 'sbctl')
source=(
    "default.conf"
    "grub-secureboot-reinstall.hook"
    "grub-secureboot-reinstall.sh"
)

sha256sums=('SKIP'
            'SKIP'
            'SKIP')

package() {
    install -D -m0644 "${srcdir}/default.conf" "${pkgdir}/etc/default/grub-secureboot-reinstall"
    install -D -m0644 "${srcdir}/grub-secureboot-reinstall.hook" "${pkgdir}/usr/share/libalpm/hooks/grub-secureboot-reinstall.hook"
    install -D -m0755 "${srcdir}/grub-secureboot-reinstall.sh" "${pkgdir}/usr/share/libalpm/scripts/grub-secureboot-reinstall.sh"
}

