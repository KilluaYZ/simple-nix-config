{
  ##################################################################################################################
  #
  # NixOS Configuration
  #
  ##################################################################################################################

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ziyang = {
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCYA4Ox5ljYsh/x6dozk59Ov7FvEJbUgDRq9OwmQiDAHZY4UnBgk67dYjDpkRYzoRNmNA5MKtF3A6hCraeFGtGsCaSAJSXZgPZRvXWpPUVbKhBnV7B5esGxGRHW3NQGusQrRJHyxhY7pUDDozoxipquN2EsuGA7zLiQCZ/kYc1I0ruyyjlVE8ILSFD8CUPp9Oy4BTie2bF6RzxX0slYbx8OARm2N/aNNnyM9bLWtAMtfidgkghhu6Qh9MCoEQpnYgGDcwzGtEVhGzWm5s1szga1qTKDRhnK5T7mexsgSiAdENsc6xYjDgPZKftBDFh3QFOSYYliWeYXFonAE9qs9VHBxo+w89iEz9DzR0sLy3aKRmaDtgNAP5jKAnmu6MDMLBp+nzkocdd2TK4ZwRqbWqlc+44L9zGz+yLS9WhGQZ0LA4TcjGlQsIQeinEfbZls+zabDGV4lRv4QNBdSYgdERG5Sfmsbz0xf+XGcBZvEWhmsprIy2gF6NR0DaMgUkwSCvE= ziyang@DESKTOP-IAESBB8"
    ];
  };
}
