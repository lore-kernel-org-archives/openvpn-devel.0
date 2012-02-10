Content-Type: multipart/mixed; boundary="========GMX119681328836168609782"
Date: Thu, 09 Feb 2012 20:09:27 -0500
From: "Kingsuk Mukherjee" <kingsuk@...1278...>
Message-ID: <20120210010928.119680@...1278...>
MIME-Version: 1.0
Subject: [Openvpn-devel] openvpn binary giving error on Android HC 3.2.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--========GMX119681328836168609782
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


 Dear openvpn developers,
   
 I am trying to configure the openvpn access to my vpn service provider CyberGhostVPN servers in last few days on non-Windows platforms. I have one laptop running Fedora 16 & one Toshiba Thrive tablet running Android HC 3.2.1 (Kernel version: 2.6.36.3-00020-g3d351b6).
 
 I have the config file which cyberghostvpn has provided me for connection. I have used successfully the config file given below on my fedora Linux machine and connected with cyberghostvpn servers without any error.
 
 However, when I'm running it on android (thrive) via the app openvpn-settings , I'm getting the error message : "Unrecognized option or missing parameter(s) in test.ovpn: 1: client(2.1.1)".
 
 I have checked that my tun.ko is being loaded properly and upon lsmod I can see :
 tun 12536 2 -Live 0xbf043000.
 
 Also on subsequent ls -l /dev/tun*, it is displayed that,
 "crw-r----- vpn vpn 10,200 2012-02-04 09:21 tun"
 
 My openvpn binary and busybox is located in /system/xbin and symlinks are created for ifconfig and route from /system/xbin to /system/xbin/bb.
 
 It seems to me that somehow the openvpn binary is failing to recognize/read my config file and hence I'm unable to connect with the server.
 
 test.ovpn config file :
 
 *************************
 client
 
 ca ca.crt
 cert myusername.crt
 key myusername.key
 
 remote ch.openvpn.cyberghostvpn.com 9081
 
 auth-user-pass
 dev tun
 proto udp
 dhcp-renew
 dhcp-release
 resolv-retry infinite
 persist-key
 persist-tun
 ping-restart 0
 nobind
 ping-timer-rem
 cipher aes-128-cbc
 comp-lzo yes
 verb 4
 script-security 2
 remote-cert-tls server
 win-sys env
 route-delay 5
 tun-mtu 1500
 fragment 1300
 mssfix
 **********************************
 
 I have then continued my trouble shooting further on Thrive with the same config file options as shown above manually (like --client --ca ca.crt --cert myusername.cert .... -- mssfix) by running them as command line arguments because the openvpn binary was not reading them from config files. Upon executing from command line the following options are shown as not valid ones.
 
 1.  --dhcp-renew
 2.  --dhcp-release
 3.  --win-sys env
 
 It needs to be mentioned here that as per openvpn man pages they are all valid command line options and in my fedora machine all of them are running without throwing incompatibility errors. They were also read from the config file in fedora as I had mentioned in my last post. This gives cause to raise my suspicion whether the openvpn binary we are getting via openvpn-installer app is perfect !
 
 I continued with my trouble shooting by removing these three options and the system starts initiating the connection and comes to the message , " Enter Auth Username: ", which should be followed by a , "Enter Auth Password : ". But this password prompt is NOT coming in thrive (android) at all though it's coming in Fedora(Linux).
 
 After entering username in thrive, the sytem continues further in initiating the connection assuming password as 'blank' (which I have verified by intentionally proving my password as blank in Fedora later) which results into a AUTH_FAILURE message slightly later and the connection is closed. I have tried to input the user name and password through text file (in 2 lines) also e,g. --auth-user-pass mypass.txt still receiving AUTH_FAILURE message. Then I had decided to log the output in a file for review by other experts which is enclosed for your review.
 
 Now, my conclusion as of this point is that the openvpn binary is DEFECTIVE....based on my understanding on the excerpt from the man page....I think it may have been built without the --enable-password-save configure option
 
 --auth-user-pass [up] Authenticate with server using username/password. up is a file containing username/password on 2 lines (Note: OpenVPN will only read passwords from a file if it has been built with the --enable-password-save configure option, or on Windows by defining ENABLE_PASSWORD_SAVE in config-win32.h). If up is omitted, username/password will be prompted from the console.
 
 I have used openvpn binary 2.1.1 as installed by the app openvpn-installer from android market. Please let me know if it's a problem of openvpn binary or I'm missing something ? 
 
 One more info, I'm not very expert in compiling my openvpn binary but willing to learn if someone kindly helps me.
 
 Warm regards,
 Kingsuk
 
 
   
 
       
  

--========GMX119681328836168609782
Content-Type: text/plain; charset="utf-8"; name="consolelog.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="consolelog.txt"
Content-Description: Attachment: consolelog.txt

Tue Feb  7 21:35:47 2012 us=357454 Current Parameter Settings:
Tue Feb  7 21:35:47 2012 us=358934   config = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=359031   mode = 0
Tue Feb  7 21:35:47 2012 us=359117   persist_config = DISABLED
Tue Feb  7 21:35:47 2012 us=359263   persist_mode = 1
Tue Feb  7 21:35:47 2012 us=359469   show_ciphers = DISABLED
Tue Feb  7 21:35:47 2012 us=359530   show_digests = DISABLED
Tue Feb  7 21:35:47 2012 us=359581   show_engines = DISABLED
Tue Feb  7 21:35:47 2012 us=359631   genkey = DISABLED
Tue Feb  7 21:35:47 2012 us=359682   key_pass_file = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=359732   show_tls_ciphers = DISABLED
Tue Feb  7 21:35:47 2012 us=359781 Connection profiles [default]:
Tue Feb  7 21:35:47 2012 us=359830   proto = udp
Tue Feb  7 21:35:47 2012 us=359879   local = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=359926   local_port = 0
Tue Feb  7 21:35:47 2012 us=359975   remote = 'ch.openvpn.cyberghostvpn.com'
Tue Feb  7 21:35:47 2012 us=360025   remote_port = 9081
Tue Feb  7 21:35:47 2012 us=360072   remote_float = DISABLED
Tue Feb  7 21:35:47 2012 us=360123   bind_defined = DISABLED
Tue Feb  7 21:35:47 2012 us=360171   bind_local = DISABLED
Tue Feb  7 21:35:47 2012 us=360218   connect_retry_seconds = 5
Tue Feb  7 21:35:47 2012 us=360265   connect_timeout = 10
Tue Feb  7 21:35:47 2012 us=360313   connect_retry_max = 0
Tue Feb  7 21:35:47 2012 us=360360   socks_proxy_server = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=360407   socks_proxy_port = 0
Tue Feb  7 21:35:47 2012 us=360454   socks_proxy_retry = DISABLED
Tue Feb  7 21:35:47 2012 us=360504 Connection profiles END
Tue Feb  7 21:35:47 2012 us=360553   remote_random = DISABLED
Tue Feb  7 21:35:47 2012 us=360601   ipchange = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=360648   dev = 'tun'
Tue Feb  7 21:35:47 2012 us=360696   dev_type = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=360743   dev_node = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=360790   lladdr = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=360837   topology = 1
Tue Feb  7 21:35:47 2012 us=360884   tun_ipv6 = DISABLED
Tue Feb  7 21:35:47 2012 us=360936   ifconfig_local = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=360984   ifconfig_remote_netmask = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=361032   ifconfig_noexec = DISABLED
Tue Feb  7 21:35:47 2012 us=361079   ifconfig_nowarn = DISABLED
Tue Feb  7 21:35:47 2012 us=361187   shaper = 0
Tue Feb  7 21:35:47 2012 us=361358   tun_mtu = 1500
Tue Feb  7 21:35:47 2012 us=361444   tun_mtu_defined = ENABLED
Tue Feb  7 21:35:47 2012 us=361482   link_mtu = 1500
Tue Feb  7 21:35:47 2012 us=361517   link_mtu_defined = DISABLED
Tue Feb  7 21:35:47 2012 us=361555   tun_mtu_extra = 0
Tue Feb  7 21:35:47 2012 us=361592   tun_mtu_extra_defined = DISABLED
Tue Feb  7 21:35:47 2012 us=361630   fragment = 1300
Tue Feb  7 21:35:47 2012 us=361665   mtu_discover_type = -1
Tue Feb  7 21:35:47 2012 us=361701   mtu_test = 0
Tue Feb  7 21:35:47 2012 us=361737   mlock = DISABLED
Tue Feb  7 21:35:47 2012 us=361773   keepalive_ping = 0
Tue Feb  7 21:35:47 2012 us=361809   keepalive_timeout = 0
Tue Feb  7 21:35:47 2012 us=361845   inactivity_timeout = 0
Tue Feb  7 21:35:47 2012 us=361884   ping_send_timeout = 0
Tue Feb  7 21:35:47 2012 us=361921   ping_rec_timeout = 0
Tue Feb  7 21:35:47 2012 us=361957   ping_rec_timeout_action = 2
Tue Feb  7 21:35:47 2012 us=361993   ping_timer_remote = ENABLED
Tue Feb  7 21:35:47 2012 us=362029   remap_sigusr1 = 0
Tue Feb  7 21:35:47 2012 us=362065   explicit_exit_notification = 0
Tue Feb  7 21:35:47 2012 us=362130   persist_tun = ENABLED
Tue Feb  7 21:35:47 2012 us=362179   persist_local_ip = DISABLED
Tue Feb  7 21:35:47 2012 us=362222   persist_remote_ip = DISABLED
Tue Feb  7 21:35:47 2012 us=362262   persist_key = ENABLED
Tue Feb  7 21:35:47 2012 us=362302   mssfix = 1300
Tue Feb  7 21:35:47 2012 us=362722   resolve_retry_seconds = 1000000000
Tue Feb  7 21:35:47 2012 us=362762   username = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=362799   groupname = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=362836   chroot_dir = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=362872   cd_dir = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=362932   writepid = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=362970   up_script = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=363007   down_script = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=363044   down_pre = DISABLED
Tue Feb  7 21:35:47 2012 us=363080   up_restart = DISABLED
Tue Feb  7 21:35:47 2012 us=363115   up_delay = DISABLED
Tue Feb  7 21:35:47 2012 us=363152   daemon = DISABLED
Tue Feb  7 21:35:47 2012 us=363207   inetd = 0
Tue Feb  7 21:35:47 2012 us=363245   log = DISABLED
Tue Feb  7 21:35:47 2012 us=363282   suppress_timestamps = DISABLED
Tue Feb  7 21:35:47 2012 us=363326   nice = 0
Tue Feb  7 21:35:47 2012 us=363363   verbosity = 4
Tue Feb  7 21:35:47 2012 us=363399   mute = 0
Tue Feb  7 21:35:47 2012 us=363435   gremlin = 0
Tue Feb  7 21:35:47 2012 us=363471   status_file = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=363507   status_file_version = 1
Tue Feb  7 21:35:47 2012 us=363543   status_file_update_freq = 60
Tue Feb  7 21:35:47 2012 us=363578   occ = ENABLED
Tue Feb  7 21:35:47 2012 us=363616   rcvbuf = 65536
Tue Feb  7 21:35:47 2012 us=363656   sndbuf = 65536
Tue Feb  7 21:35:47 2012 us=363691   sockflags = 0
Tue Feb  7 21:35:47 2012 us=363727   fast_io = DISABLED
Tue Feb  7 21:35:47 2012 us=363763   lzo = 3
Tue Feb  7 21:35:47 2012 us=363798   route_script = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=363835   route_default_gateway = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=363871   route_default_metric = 0
Tue Feb  7 21:35:47 2012 us=363907   route_noexec = DISABLED
Tue Feb  7 21:35:47 2012 us=363943   route_delay = 5
Tue Feb  7 21:35:47 2012 us=363982   route_delay_window = 30
Tue Feb  7 21:35:47 2012 us=364019   route_delay_defined = ENABLED
Tue Feb  7 21:35:47 2012 us=364055   route_nopull = DISABLED
Tue Feb  7 21:35:47 2012 us=364092   route_gateway_via_dhcp = DISABLED
Tue Feb  7 21:35:47 2012 us=364129   max_routes = 100
Tue Feb  7 21:35:47 2012 us=364166   allow_pull_fqdn = DISABLED
Tue Feb  7 21:35:47 2012 us=364203   management_addr = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=364240   management_port = 0
Tue Feb  7 21:35:47 2012 us=364279   management_user_pass = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=364317   management_log_history_cache = 250
Tue Feb  7 21:35:47 2012 us=364355   management_echo_buffer_size = 100
Tue Feb  7 21:35:47 2012 us=364392   management_write_peer_info_file = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=364429   management_client_user = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=364466   management_client_group = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=364502   management_flags = 0
Tue Feb  7 21:35:47 2012 us=364542   shared_secret_file = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=364580   key_direction = 0
Tue Feb  7 21:35:47 2012 us=364617   ciphername_defined = ENABLED
Tue Feb  7 21:35:47 2012 us=364654   ciphername = 'aes-128-cbc'
Tue Feb  7 21:35:47 2012 us=364690   authname_defined = ENABLED
Tue Feb  7 21:35:47 2012 us=364727   authname = 'SHA1'
Tue Feb  7 21:35:47 2012 us=364764   prng_hash = 'SHA1'
Tue Feb  7 21:35:47 2012 us=364801   prng_nonce_secret_len = 16
Tue Feb  7 21:35:47 2012 us=364837   keysize = 0
Tue Feb  7 21:35:47 2012 us=364876   engine = DISABLED
Tue Feb  7 21:35:47 2012 us=364913   replay = ENABLED
Tue Feb  7 21:35:47 2012 us=364949   mute_replay_warnings = DISABLED
Tue Feb  7 21:35:47 2012 us=364986   replay_window = 64
Tue Feb  7 21:35:47 2012 us=365023   replay_time = 15
Tue Feb  7 21:35:47 2012 us=365059   packet_id_file = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=365095   use_iv = ENABLED
Tue Feb  7 21:35:47 2012 us=365131   test_crypto = DISABLED
Tue Feb  7 21:35:47 2012 us=365167   tls_server = DISABLED
Tue Feb  7 21:35:47 2012 us=365206   tls_client = ENABLED
Tue Feb  7 21:35:47 2012 us=365243   key_method = 2
Tue Feb  7 21:35:47 2012 us=365281   ca_file = 'ca.crt'
Tue Feb  7 21:35:47 2012 us=365317   ca_path = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=365354   dh_file = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=365391   cert_file = 'user.crt'
Tue Feb  7 21:35:47 2012 us=365428   priv_key_file = 'user.key'
Tue Feb  7 21:35:47 2012 us=365466   pkcs12_file = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=365517   cipher_list = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=365556   tls_verify = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=365593   tls_remote = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=365630   crl_file = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=365667   ns_cert_type = 0
Tue Feb  7 21:35:47 2012 us=365704   remote_cert_ku[i] = 160
Tue Feb  7 21:35:47 2012 us=365741   remote_cert_ku[i] = 136
Tue Feb  7 21:35:47 2012 us=365778   remote_cert_ku[i] = 0
Tue Feb  7 21:35:47 2012 us=365815   remote_cert_ku[i] = 0
Tue Feb  7 21:35:47 2012 us=365853   remote_cert_ku[i] = 0
Tue Feb  7 21:35:47 2012 us=365890   remote_cert_ku[i] = 0
Tue Feb  7 21:35:47 2012 us=365927   remote_cert_ku[i] = 0
Tue Feb  7 21:35:47 2012 us=365963   remote_cert_ku[i] = 0
Tue Feb  7 21:35:47 2012 us=365998   remote_cert_ku[i] = 0
Tue Feb  7 21:35:47 2012 us=366034   remote_cert_ku[i] = 0
Tue Feb  7 21:35:47 2012 us=366071   remote_cert_ku[i] = 0
Tue Feb  7 21:35:47 2012 us=366107   remote_cert_ku[i] = 0
Tue Feb  7 21:35:47 2012 us=366145   remote_cert_ku[i] = 0
Tue Feb  7 21:35:47 2012 us=366182   remote_cert_ku[i] = 0
Tue Feb  7 21:35:47 2012 us=366219   remote_cert_ku[i] = 0
Tue Feb  7 21:35:47 2012 us=366255   remote_cert_ku[i] = 0
Tue Feb  7 21:35:47 2012 us=366293   remote_cert_eku = 'TLS Web Server Authentication'
Tue Feb  7 21:35:47 2012 us=366330   tls_timeout = 2
Tue Feb  7 21:35:47 2012 us=366366   renegotiate_bytes = 0
Tue Feb  7 21:35:47 2012 us=366402   renegotiate_packets = 0
Tue Feb  7 21:35:47 2012 us=366440   renegotiate_seconds = 3600
Tue Feb  7 21:35:47 2012 us=366479   handshake_window = 60
Tue Feb  7 21:35:47 2012 us=366517   transition_window = 3600
Tue Feb  7 21:35:47 2012 us=366554   single_session = DISABLED
Tue Feb  7 21:35:47 2012 us=366591   tls_exit = DISABLED
Tue Feb  7 21:35:47 2012 us=366627   tls_auth_file = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=366703   server_network = 0.0.0.0
Tue Feb  7 21:35:47 2012 us=366748   server_netmask = 0.0.0.0
Tue Feb  7 21:35:47 2012 us=366789   server_bridge_ip = 0.0.0.0
Tue Feb  7 21:35:47 2012 us=366832   server_bridge_netmask = 0.0.0.0
Tue Feb  7 21:35:47 2012 us=366872   server_bridge_pool_start = 0.0.0.0
Tue Feb  7 21:35:47 2012 us=366912   server_bridge_pool_end = 0.0.0.0
Tue Feb  7 21:35:47 2012 us=366949   ifconfig_pool_defined = DISABLED
Tue Feb  7 21:35:47 2012 us=366988   ifconfig_pool_start = 0.0.0.0
Tue Feb  7 21:35:47 2012 us=367028   ifconfig_pool_end = 0.0.0.0
Tue Feb  7 21:35:47 2012 us=367067   ifconfig_pool_netmask = 0.0.0.0
Tue Feb  7 21:35:47 2012 us=367106   ifconfig_pool_persist_filename = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=367144   ifconfig_pool_persist_refresh_freq = 600
Tue Feb  7 21:35:47 2012 us=367181   n_bcast_buf = 256
Tue Feb  7 21:35:47 2012 us=367219   tcp_queue_limit = 64
Tue Feb  7 21:35:47 2012 us=367256   real_hash_size = 256
Tue Feb  7 21:35:47 2012 us=367293   virtual_hash_size = 256
Tue Feb  7 21:35:47 2012 us=367329   client_connect_script = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=367365   learn_address_script = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=367405   client_disconnect_script = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=367441   client_config_dir = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=367476   ccd_exclusive = DISABLED
Tue Feb  7 21:35:47 2012 us=367512   tmp_dir = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=367548   push_ifconfig_defined = DISABLED
Tue Feb  7 21:35:47 2012 us=367587   push_ifconfig_local = 0.0.0.0
Tue Feb  7 21:35:47 2012 us=367626   push_ifconfig_remote_netmask = 0.0.0.0
Tue Feb  7 21:35:47 2012 us=367662   enable_c2c = DISABLED
Tue Feb  7 21:35:47 2012 us=367701   duplicate_cn = DISABLED
Tue Feb  7 21:35:47 2012 us=367737   cf_max = 0
Tue Feb  7 21:35:47 2012 us=367772   cf_per = 0
Tue Feb  7 21:35:47 2012 us=367810   max_clients = 1024
Tue Feb  7 21:35:47 2012 us=367847   max_routes_per_client = 256
Tue Feb  7 21:35:47 2012 us=367883   auth_user_pass_verify_script = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=367920   auth_user_pass_verify_script_via_file = DISABLED
Tue Feb  7 21:35:47 2012 us=367956   ssl_flags = 0
Tue Feb  7 21:35:47 2012 us=368011   port_share_host = '[UNDEF]'
Tue Feb  7 21:35:47 2012 us=368050   port_share_port = 0
Tue Feb  7 21:35:47 2012 us=368087   client = ENABLED
Tue Feb  7 21:35:47 2012 us=368123   pull = ENABLED
Tue Feb  7 21:35:47 2012 us=368160   auth_user_pass_file = 'stdin'
Tue Feb  7 21:35:47 2012 us=368200 OpenVPN 2.1.1 i686-pc-linux-gnu [SSL] [LZO2] [EPOLL] built on Jan  7 2012
Tue Feb  7 21:36:11 2012 us=87812 NOTE: the current --script-security setting may allow this configuration to call user-defined scripts
Tue Feb  7 21:36:11 2012 us=93955 WARNING: file 'user.key' is group or others accessible
Tue Feb  7 21:36:11 2012 us=109962 LZO compression initialized
Tue Feb  7 21:36:11 2012 us=110408 Control Channel MTU parms [ L:1562 D:138 EF:38 EB:0 ET:0 EL:0 ]
Tue Feb  7 21:36:11 2012 us=547656 Data Channel MTU parms [ L:1562 D:1300 EF:62 EB:135 ET:0 EL:0 AF:3/1 ]
Tue Feb  7 21:36:11 2012 us=547931 Fragmentation MTU parms [ L:1562 D:1300 EF:61 EB:135 ET:1 EL:0 AF:3/1 ]
Tue Feb  7 21:36:11 2012 us=548307 Local Options String: 'V4,dev-type tun,link-mtu 1562,tun-mtu 1500,proto UDPv4,comp-lzo,mtu-dynamic,cipher AES-128-CBC,auth SHA1,keysize 128,key-method 2,tls-client'
Tue Feb  7 21:36:11 2012 us=548482 Expected Remote Options String: 'V4,dev-type tun,link-mtu 1562,tun-mtu 1500,proto UDPv4,comp-lzo,mtu-dynamic,cipher AES-128-CBC,auth SHA1,keysize 128,key-method 2,tls-server'
Tue Feb  7 21:36:11 2012 us=548782 Local Options hash (VER=V4): '0c7fabe0'
Tue Feb  7 21:36:11 2012 us=549406 Expected Remote Options hash (VER=V4): 'e11a9f86'
Tue Feb  7 21:36:11 2012 us=549766 Socket Buffers: R=[110592->131072] S=[110592->131072]
Tue Feb  7 21:36:11 2012 us=549987 UDPv4 link local: [undef]
Tue Feb  7 21:36:11 2012 us=550201 UDPv4 link remote: 79.141.167.9:9081
Tue Feb  7 21:36:11 2012 us=690470 TLS: Initial packet from 79.141.167.9:9081, sid=0ef2d4a0 5ef47be8
Tue Feb  7 21:36:12 2012 us=321533 VERIFY OK: depth=1, /C=DE/O=CyberGhost_VPN/OU=CyberGhost/CN=CyberGhost
Tue Feb  7 21:36:12 2012 us=322236 Validating certificate key usage
Tue Feb  7 21:36:12 2012 us=322283 ++ Certificate has key usage  00a0, expects 00a0
Tue Feb  7 21:36:12 2012 us=322320 VERIFY KU OK
Tue Feb  7 21:36:12 2012 us=322368 Validating certificate extended key usage
Tue Feb  7 21:36:12 2012 us=322408 ++ Certificate has EKU (str) TLS Web Server Authentication, expects TLS Web Server Authentication
Tue Feb  7 21:36:12 2012 us=322445 VERIFY EKU OK
Tue Feb  7 21:36:12 2012 us=322478 VERIFY OK: depth=0, /C=DE/O=CyberGhost_VPN/OU=CyberGhost/CN=Server
Tue Feb  7 21:36:14 2012 us=829812 Data Channel Encrypt: Cipher 'AES-128-CBC' initialized with 128 bit key
Tue Feb  7 21:36:14 2012 us=830019 Data Channel Encrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Tue Feb  7 21:36:14 2012 us=830166 Data Channel Decrypt: Cipher 'AES-128-CBC' initialized with 128 bit key
Tue Feb  7 21:36:14 2012 us=830316 Data Channel Decrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Tue Feb  7 21:36:14 2012 us=830698 Control Channel: TLSv1, cipher TLSv1/SSLv3 DHE-RSA-AES256-SHA, 1024 bit RSA
Tue Feb  7 21:36:14 2012 us=830984 [Server] Peer Connection Initiated with 79.141.167.9:9081
Tue Feb  7 21:36:17 2012 us=121285 SENT CONTROL [Server]: 'PUSH_REQUEST' (status=1)
Tue Feb  7 21:36:17 2012 us=270214 AUTH: Received AUTH_FAILED control message
Tue Feb  7 21:36:17 2012 us=272745 TCP/UDP: Closing socket
Tue Feb  7 21:36:17 2012 us=273194 SIGTERM[soft,auth-failure] received, process exiting

--========GMX119681328836168609782--

