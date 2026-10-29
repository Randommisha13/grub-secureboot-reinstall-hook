#!/usr/bin/env bash

set -eu -o pipefail

load_config() {
    set +u
    if [[ -f "/etc/default/grub-reinstall-hook" ]]
    then
        source "/etc/default/grub-reinstall-hook"
    fi

    BOOT_DIRECTORY="${BOOT_DIRECTORY:-/boot}"
    EFI_DIRECTORY="${EFI_DIRECTORY:-/efi}"
    GRUB_BOOTLOADER_ID="${GRUB_BOOTLOADER_ID:-GRUB}"
    GRUB_TARGET="${GRUB_TARGET:-x86_64-efi}"
    GRUB_CONFIG_FILE="${GRUB_CONFIG_FILE:-${BOOT_DIRECTORY}/grub/grub.cfg}"
    GRUB_EFI_FILE="${GRUB_EFI_FILE:-${EFI_DIRECTORY}/EFI/${GRUB_BOOTLOADER_ID}/grubx64.efi}"
    GRUB_MODULE_DIR="${GRUB_MODULE_DIR:-/usr/lib/grub/${GRUB_TARGET}}"

    # if [[ -z "${GRUB_LOCALES}" ]]
    # then
    #     GRUB_LOCALES=(
    #         "en_US"
    #     )
    # fi
    set -u
}

# Default modules are from this list:
# https://git.launchpad.net/~ubuntu-core-dev/grub/+git/ubuntu/tree/debian/build-efi-images?h=debian/2.06-2ubuntu12
load_default_modules() {
    set +u
    if [[ -z "${BASIC_MODULES}" ]]
    then
        BASIC_MODULES=(
            "all_video"
            "argon2.mod"
            "boot"
            "btrfs"
            "cat"
            "chain"
            "configfile"
            "echo"
            "efifwsetup"
            "efinet"
            "ext2"
            "fat"
            "font"
            "gettext"
            "gfxmenu"
            "gfxterm"
            "gfxterm_background"
            "gzio"
            "halt"
            "help"
            "hfsplus"
            "iso9660"
            "jpeg"
            "keystatus"
            "linux"
            "loadenv"
            "loopback"
            "ls"
            "lsefi"
            "lsefimmap"
            "lsefisystab"
            "lssal"
            "memdisk"
            "minicmd"
            "normal"
            "ntfs"
            "part_apple"
            "part_gpt"
            "part_msdos"
            "password_argon2.mod"
            "password_pbkdf2"
            "png"
            "probe"
            "reboot"
            "regexp"
            "search"
            "search_fs_file"
            "search_fs_uuid"
            "search_label"
            "sleep"
            "smbios"
            "squash4"
            "test"
            "true"
            "video"
            "xfs"
            "zfs"
            "zfscrypt"
            "zfsinfo"
        )
    fi

    if [[ -z "${PLATFORM_MODULES}" ]]
    then
        PLATFORM_MODULES=(
            "cpuid"
            "play"
            "tpm"
        )
    fi

    if [[ -z "${ADVANCED_MODULES}" ]]
    then
        ADVANCED_MODULES=(
            "cryptodisk"
            "gcry_arcfour"
            "gcry_blowfish"
            "gcry_camellia"
            "gcry_cast5"
            "gcry_crc"
            "gcry_des"
            "gcry_dsa"
            "gcry_idea"
            "gcry_md4"
            "gcry_md5"
            "gcry_rfc2268"
            "gcry_rijndael"
            "gcry_rmd160"
            "gcry_rsa"
            "gcry_seed"
            "gcry_serpent"
            "gcry_sha1"
            "gcry_sha256"
            "gcry_sha512"
            "gcry_tiger"
            "gcry_twofish"
            "gcry_whirlpool"
            "luks"
            "lvm"
            "mdraid09"
            "mdraid1x"
            "raid5rec"
            "raid6rec"
        )
    fi

    set -u
}

main() {
    load_config
    load_default_modules

    local -a GRUB_MODULES
    GRUB_MODULES=("${BASIC_MODULES[@]}" "${PLATFORM_MODULES[@]}" "${ADVANCED_MODULES[@]}")

    grub-install --target="${GRUB_TARGET}" \
        --boot-directory="${BOOT_DIRECTORY}" \
        --efi-directory="${EFI_DIRECTORY}" \
        --modules="${GRUB_MODULES[*]}" \
        --bootloader-id="${GRUB_BOOTLOADER_ID}" \
        --disable-shim-lock \
        --no-nvram

    grub-mkconfig -o "${GRUB_CONFIG_FILE}"

    sbctl sign "${GRUB_EFI_FILE}"
}

main "$@"
