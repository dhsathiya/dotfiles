 #!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

apt update && \
apt install -y \
  git \
  tmux \
  zsh

fallocate -l 2G /swapfile && 
chmod 600 /swapfile && 
mkswap /swapfile && 
swapon /swapfile && 
swapon --show && 
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab && 
sysctl vm.swappiness=10 && 
echo 'vm.swappiness=10' >> /etc/sysctl.conf && 
sysctl vm.vfs_cache_pressure=50 && 
echo 'vm.vfs_cache_pressure = 50' >> /etc/sysctl.conf

cat <<EOF >> /etc/security/limits.conf
*         hard    nofile      500000
*         soft    nofile      500000
root      hard    nofile      500000
root      soft    nofile      500000
EOF

echo 'session required pam_limits.so' >> /etc/pam.d/common-session
sysctl -p

cat <<EOF >> /etc/sysctl.conf
### IMPROVE SYSTEM MEMORY MANAGEMENT ###

# Increase size of file handles and inode cache
fs.file-max = 2097152

# Do less swapping
vm.swappiness = 10
vm.dirty_ratio = 60
vm.dirty_background_ratio = 2

### GENERAL NETWORK SECURITY OPTIONS ###

# Number of times SYNACKs for passive TCP connection.
net.ipv4.tcp_synack_retries = 2

# Allowed local port range
net.ipv4.ip_local_port_range = 2000 65535

# Protect Against TCP Time-Wait
net.ipv4.tcp_rfc1337 = 1

# Decrease the time default value for tcp_fin_timeout connection
net.ipv4.tcp_fin_timeout = 15

# Decrease the time default value for connections to keep alive
net.ipv4.tcp_keepalive_time = 300
net.ipv4.tcp_keepalive_probes = 5
net.ipv4.tcp_keepalive_intvl = 15

### TUNING NETWORK PERFORMANCE ###

# Default Socket Receive Buffer
net.core.rmem_default = 31457280

# Maximum Socket Receive Buffer
net.core.rmem_max = 12582912

# Default Socket Send Buffer
net.core.wmem_default = 31457280

# Maximum Socket Send Buffer
net.core.wmem_max = 12582912

# Increase number of incoming connections
net.core.somaxconn = 4096

# Increase number of incoming connections backlog
net.core.netdev_max_backlog = 65536

# Increase the maximum amount of option memory buffers
net.core.optmem_max = 25165824

# Increase the maximum total buffer-space allocatable
# This is measured in units of pages (4096 bytes)
net.ipv4.tcp_mem = 65536 131072 262144
net.ipv4.udp_mem = 65536 131072 262144

# Increase the read-buffer space allocatable
net.ipv4.tcp_rmem = 8192 87380 16777216
net.ipv4.udp_rmem_min = 16384

# Increase the write-buffer-space allocatable
net.ipv4.tcp_wmem = 8192 65536 16777216
net.ipv4.udp_wmem_min = 16384

# Increase the tcp-time-wait buckets pool size to prevent simple DOS attacks
net.ipv4.tcp_max_tw_buckets = 1440000
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1
EOF

sysctl -p


curl -o $HOME/.tmux/ https://raw.githubusercontent.com/dhsathiya/dotfiles/master/Vagrant/.tmux.conf
curl -o $HOME/.tmux/ https://raw.githubusercontent.com/dhsathiya/dotfiles/master/Vagrant/.tmux.conf.local
bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
curl -o $HOME/.zshrc https://raw.githubusercontent.com/dhsathiya/dotfiles/master/Vagrant/.zshrc

mkdir -p /root/.ssh
rm -rf /root/.vim
rm -rf /root/.vimrc
mkdir /root/.vim
git clone https://github.com/sjl/badwolf.git /root/.vim/

touch /root/.vimrc
echo 'colorscheme badwolf         " awesome colorscheme    
" Spacing                                                         
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces

" UI Config
set number              " show line numbers
set cursorline          " highlight current line
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]

" Searching
set incsearch           " search as characters are entered
" set hlsearch            " highlight matches
" turn off search highlight
" nnoremap <leader><space> :nohlsearch<CR>
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
set background=dark
set t_Co=256
' > /root/.vimrc

users=(
  dhsathiya
)

for user in "${users[@]}"; do
  curl -fsSL https://github.com/$user.keys | tee -a /root/.ssh/authorized_keys
done


if [[ ! -f "$HOME/.ssh/id_rsa" ]]; then
    ssh-keygen -t rsa -b 4096 -C "$(hostname)" -f "$HOME/.ssh/id_rsa" -N ""
fi


chsh -s $(which zsh)
