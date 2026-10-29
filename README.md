# grub-secureboot-reinstall-hook

A simple pacman hook to automatically reinstall and sign GRUB after an update.

Uses `grub-mkstandalone` because you would need to sign all the grub modules
yourself otherwise.

Only `sbctl` is supported for signing the resulting EFI executable.
