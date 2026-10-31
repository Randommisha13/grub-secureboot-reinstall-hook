# grub-secureboot-reinstall-hook

A simple pacman hook to automatically reinstall and sign GRUB after an update.

Script embeds modules into GRUB EFI executable because you would need to sign
all them yourself otherwise.

Only `sbctl` is supported for signing the resulting EFI executable.

# Installation

Installation procedure is similar to other Arch user packages:

```
git clone https://github.com/Randommisha13/grub-secureboot-reinstall-hook
cd grub-secureboot-reinstall-hook
makepkg -i
```
