From: debbie10t <debbie10t@...277...>
Message-ID: <f4082329-79a1-06c0-5ad3-662364caeb3f@...277...>
Date: Thu, 18 Aug 2016 14:11:10 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel]  Error: when using --tun-ipv6,
 if you have more than one TAP-Windows adapter,
 you must also specify --dev-node
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

I cannot find a bug report or thread related to this so I started one.

Having been made aware of this while working on --ifconfig-noexec IPv6
I was watching out for it and discovered a slight anomaly which should
be added to the knowledge pool:

** Only ONE TAP-Windows adapter is required to trigger this error.

===

Setup:

Linux server - details follow.

Windows10 client
openvpn-install-master-20160812155127-d1bd37fd50-x86_64.exe
Full install
*Single* TAP-Windows adapter installed "Ethernet" (default)
Logged in as Administrator
Openvpn Interactive service running
Using OpenVPN-GUI

Client config:
===

# Note: Node does not match "ethernet" (default installed TAP)
# --dev-node is defined
          dev-node defaultc
          dev-type tun
             proto udp
              port 1194
            nobind
      resolv-retry infinite
            client

;block-outside-dns
;     route-noexec
;  ifconfig-noexec
;       pull-filter ignore "ifconfig-ipv6 "
;
; script-security 3
;    up "c:\\program files\\openvpn\\config\\cup6.bat"
;  down "c:\\program files\\openvpn\\config\\cdown6.bat"

        ca "c:\\progra~1\\openvpn\\config\\defaultc\\pki\\ca.crt"
      cert "c:\\progra~1\\openvpn\\config\\defaultc\\pki\\defaultc01.crt"
       key "c:\\progra~1\\openvpn\\config\\defaultc\\pki\\defaultc01.key"
  tls-auth "c:\\progra~1\\openvpn\\config\\defaultc\\pki\\ta-default.key" 1

        reneg-sec 0
         comp-lzo no
  remote-cert-tls server
             verb 4
### EOF

Client log:
===

Thu Aug 18 13:54:39 2016 us=318579 Current Parameter Settings:
Thu Aug 18 13:54:39 2016 us=319557   config = 'defaultc.ovpn'
Thu Aug 18 13:54:39 2016 us=319557   mode = 0
Thu Aug 18 13:54:39 2016 us=319557   show_ciphers = DISABLED
Thu Aug 18 13:54:39 2016 us=319557   show_digests = DISABLED
Thu Aug 18 13:54:39 2016 us=319557   show_engines = DISABLED
Thu Aug 18 13:54:39 2016 us=319557   genkey = DISABLED
Thu Aug 18 13:54:39 2016 us=319557   key_pass_file = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=319557   show_tls_ciphers = DISABLED
Thu Aug 18 13:54:39 2016 us=319557   connect_retry_max = 0
Thu Aug 18 13:54:39 2016 us=319557 Connection profiles [0]:
Thu Aug 18 13:54:39 2016 us=319557   proto = udp
Thu Aug 18 13:54:39 2016 us=319557   local = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=319557   local_port = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=319557   remote = 'xxx'
Thu Aug 18 13:54:39 2016 us=320534   remote_port = '1194'
Thu Aug 18 13:54:39 2016 us=320534   remote_float = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   bind_defined = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   bind_local = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   bind_ipv6_only = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   connect_retry_seconds = 5
Thu Aug 18 13:54:39 2016 us=320534   connect_timeout = 120
Thu Aug 18 13:54:39 2016 us=320534   socks_proxy_server = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=320534   socks_proxy_port = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=320534   tun_mtu = 1500
Thu Aug 18 13:54:39 2016 us=320534   tun_mtu_defined = ENABLED
Thu Aug 18 13:54:39 2016 us=320534   link_mtu = 1500
Thu Aug 18 13:54:39 2016 us=320534   link_mtu_defined = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   tun_mtu_extra = 0
Thu Aug 18 13:54:39 2016 us=320534   tun_mtu_extra_defined = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   mtu_discover_type = -1
Thu Aug 18 13:54:39 2016 us=320534   fragment = 0
Thu Aug 18 13:54:39 2016 us=320534   mssfix = 1450
Thu Aug 18 13:54:39 2016 us=320534   explicit_exit_notification = 0
Thu Aug 18 13:54:39 2016 us=320534 Connection profiles END
Thu Aug 18 13:54:39 2016 us=320534   remote_random = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   ipchange = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=320534   dev = 'defaultc'
Thu Aug 18 13:54:39 2016 us=320534   dev_type = 'tun'
Thu Aug 18 13:54:39 2016 us=320534   dev_node = 'defaultc'
Thu Aug 18 13:54:39 2016 us=320534   lladdr = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=320534   topology = 1
Thu Aug 18 13:54:39 2016 us=320534   tun_ipv6 = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   ifconfig_local = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=320534   ifconfig_remote_netmask = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=320534   ifconfig_noexec = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   ifconfig_nowarn = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   ifconfig_ipv6_local = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=320534   ifconfig_ipv6_netbits = 0
Thu Aug 18 13:54:39 2016 us=320534   ifconfig_ipv6_remote = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=320534   shaper = 0
Thu Aug 18 13:54:39 2016 us=320534   mtu_test = 0
Thu Aug 18 13:54:39 2016 us=320534   mlock = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   keepalive_ping = 0
Thu Aug 18 13:54:39 2016 us=320534   keepalive_timeout = 0
Thu Aug 18 13:54:39 2016 us=320534   inactivity_timeout = 0
Thu Aug 18 13:54:39 2016 us=320534   ping_send_timeout = 0
Thu Aug 18 13:54:39 2016 us=320534   ping_rec_timeout = 0
Thu Aug 18 13:54:39 2016 us=320534   ping_rec_timeout_action = 0
Thu Aug 18 13:54:39 2016 us=320534   ping_timer_remote = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   remap_sigusr1 = 0
Thu Aug 18 13:54:39 2016 us=320534   persist_tun = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   persist_local_ip = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   persist_remote_ip = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   persist_key = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   passtos = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   resolve_retry_seconds = 1000000000
Thu Aug 18 13:54:39 2016 us=320534   resolve_in_advance = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   username = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=320534   groupname = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=320534   chroot_dir = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=320534   cd_dir = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=320534   writepid = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=320534   up_script = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=320534   down_script = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=320534   down_pre = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   up_restart = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   up_delay = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   daemon = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   inetd = 0
Thu Aug 18 13:54:39 2016 us=320534   log = ENABLED
Thu Aug 18 13:54:39 2016 us=320534   suppress_timestamps = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   machine_readable_output = DISABLED
Thu Aug 18 13:54:39 2016 us=320534   nice = 0
Thu Aug 18 13:54:39 2016 us=320534   verbosity = 4
Thu Aug 18 13:54:39 2016 us=320534   mute = 0
Thu Aug 18 13:54:39 2016 us=320534   gremlin = 0
Thu Aug 18 13:54:39 2016 us=320534   status_file = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=320534   status_file_version = 1
Thu Aug 18 13:54:39 2016 us=321511   status_file_update_freq = 60
Thu Aug 18 13:54:39 2016 us=321511   occ = ENABLED
Thu Aug 18 13:54:39 2016 us=321511   rcvbuf = 0
Thu Aug 18 13:54:39 2016 us=321511   sndbuf = 0
Thu Aug 18 13:54:39 2016 us=321511   sockflags = 0
Thu Aug 18 13:54:39 2016 us=321511   fast_io = DISABLED
Thu Aug 18 13:54:39 2016 us=321511   comp.alg = 1
Thu Aug 18 13:54:39 2016 us=321511   comp.flags = 0
Thu Aug 18 13:54:39 2016 us=321511   route_script = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=321511   route_default_gateway = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=321511   route_default_metric = 0
Thu Aug 18 13:54:39 2016 us=321511   route_noexec = DISABLED
Thu Aug 18 13:54:39 2016 us=321511   route_delay = 5
Thu Aug 18 13:54:39 2016 us=321511   route_delay_window = 30
Thu Aug 18 13:54:39 2016 us=321511   route_delay_defined = ENABLED
Thu Aug 18 13:54:39 2016 us=321511   route_nopull = DISABLED
Thu Aug 18 13:54:39 2016 us=321511   route_gateway_via_dhcp = DISABLED
Thu Aug 18 13:54:39 2016 us=321511   allow_pull_fqdn = DISABLED
Thu Aug 18 13:54:39 2016 us=321511   management_addr = '127.0.0.1'
Thu Aug 18 13:54:39 2016 us=321511   management_port = '25340'
Thu Aug 18 13:54:39 2016 us=321511   management_user_pass = 'stdin'
Thu Aug 18 13:54:39 2016 us=321511   management_log_history_cache = 250
Thu Aug 18 13:54:39 2016 us=321511   management_echo_buffer_size = 100
Thu Aug 18 13:54:39 2016 us=321511   management_write_peer_info_file = 
'[UNDEF]'
Thu Aug 18 13:54:39 2016 us=321511   management_client_user = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=321511   management_client_group = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=321511   management_flags = 6
Thu Aug 18 13:54:39 2016 us=321511   shared_secret_file = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=321511   key_direction = 2
Thu Aug 18 13:54:39 2016 us=321511   ciphername = 'BF-CBC'
Thu Aug 18 13:54:39 2016 us=321511   authname = 'SHA1'
Thu Aug 18 13:54:39 2016 us=321511   prng_hash = 'SHA1'
Thu Aug 18 13:54:39 2016 us=321511   prng_nonce_secret_len = 16
Thu Aug 18 13:54:39 2016 us=321511   keysize = 0
Thu Aug 18 13:54:39 2016 us=321511   engine = DISABLED
Thu Aug 18 13:54:39 2016 us=321511   replay = ENABLED
Thu Aug 18 13:54:39 2016 us=321511   mute_replay_warnings = DISABLED
Thu Aug 18 13:54:39 2016 us=321511   replay_window = 64
Thu Aug 18 13:54:39 2016 us=321511   replay_time = 15
Thu Aug 18 13:54:39 2016 us=321511   packet_id_file = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=321511   use_iv = ENABLED
Thu Aug 18 13:54:39 2016 us=321511   test_crypto = DISABLED
Thu Aug 18 13:54:39 2016 us=321511   tls_server = DISABLED
Thu Aug 18 13:54:39 2016 us=321511   tls_client = ENABLED
Thu Aug 18 13:54:39 2016 us=321511   key_method = 2
Thu Aug 18 13:54:39 2016 us=321511   ca_file = 
'c:\progra~1\openvpn\config\defaultc\pki\ca.crt'
Thu Aug 18 13:54:39 2016 us=321511   ca_path = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=321511   dh_file = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=321511   cert_file = 
'c:\progra~1\openvpn\config\defaultc\pki\defaultc01.crt'
Thu Aug 18 13:54:39 2016 us=321511   extra_certs_file = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=321511   priv_key_file = 
'c:\progra~1\openvpn\config\defaultc\pki\defaultc01.key'
Thu Aug 18 13:54:39 2016 us=321511   pkcs12_file = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=321511   cryptoapi_cert = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=321511   cipher_list = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=321511   tls_verify = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=321511   tls_export_cert = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=321511   verify_x509_type = 0
Thu Aug 18 13:54:39 2016 us=321511   verify_x509_name = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=321511   crl_file = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=321511   ns_cert_type = 0
Thu Aug 18 13:54:39 2016 us=321511   remote_cert_ku[i] = 160
Thu Aug 18 13:54:39 2016 us=321511   remote_cert_ku[i] = 136
Thu Aug 18 13:54:39 2016 us=321511   remote_cert_ku[i] = 0
Thu Aug 18 13:54:39 2016 us=321511   remote_cert_ku[i] = 0
Thu Aug 18 13:54:39 2016 us=321511   remote_cert_ku[i] = 0
Thu Aug 18 13:54:39 2016 us=321511   remote_cert_ku[i] = 0
Thu Aug 18 13:54:39 2016 us=321511   remote_cert_ku[i] = 0
Thu Aug 18 13:54:39 2016 us=321511   remote_cert_ku[i] = 0
Thu Aug 18 13:54:39 2016 us=321511   remote_cert_ku[i] = 0
Thu Aug 18 13:54:39 2016 us=321511   remote_cert_ku[i] = 0
Thu Aug 18 13:54:39 2016 us=322497   remote_cert_ku[i] = 0
Thu Aug 18 13:54:39 2016 us=322497   remote_cert_ku[i] = 0
Thu Aug 18 13:54:39 2016 us=322497   remote_cert_ku[i] = 0
Thu Aug 18 13:54:39 2016 us=322497   remote_cert_ku[i] = 0
Thu Aug 18 13:54:39 2016 us=322497   remote_cert_ku[i] = 0
Thu Aug 18 13:54:39 2016 us=322497   remote_cert_ku[i] = 0
Thu Aug 18 13:54:39 2016 us=322497   remote_cert_eku = 'TLS Web Server 
Authentication'
Thu Aug 18 13:54:39 2016 us=322497   ssl_flags = 0
Thu Aug 18 13:54:39 2016 us=322497   tls_timeout = 2
Thu Aug 18 13:54:39 2016 us=322497   renegotiate_bytes = 0
Thu Aug 18 13:54:39 2016 us=322497   renegotiate_packets = 0
Thu Aug 18 13:54:39 2016 us=322497   renegotiate_seconds = 0
Thu Aug 18 13:54:39 2016 us=322497   handshake_window = 60
Thu Aug 18 13:54:39 2016 us=322497   transition_window = 3600
Thu Aug 18 13:54:39 2016 us=322497   single_session = DISABLED
Thu Aug 18 13:54:39 2016 us=322497   push_peer_info = DISABLED
Thu Aug 18 13:54:39 2016 us=322497   tls_exit = DISABLED
Thu Aug 18 13:54:39 2016 us=322497   tls_auth_file = 
'c:\progra~1\openvpn\config\defaultc\pki\ta-default.key'
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_protected_authentication = 
DISABLED
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_protected_authentication = 
DISABLED
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_protected_authentication = 
DISABLED
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_protected_authentication = 
DISABLED
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_protected_authentication = 
DISABLED
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_protected_authentication = 
DISABLED
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_protected_authentication = 
DISABLED
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_protected_authentication = 
DISABLED
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_protected_authentication = 
DISABLED
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_protected_authentication = 
DISABLED
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_protected_authentication = 
DISABLED
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_protected_authentication = 
DISABLED
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_protected_authentication = 
DISABLED
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_protected_authentication = 
DISABLED
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_protected_authentication = 
DISABLED
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_protected_authentication = 
DISABLED
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_private_mode = 00000000
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_private_mode = 00000000
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_private_mode = 00000000
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_private_mode = 00000000
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_private_mode = 00000000
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_private_mode = 00000000
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_private_mode = 00000000
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_private_mode = 00000000
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_private_mode = 00000000
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_private_mode = 00000000
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_private_mode = 00000000
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_private_mode = 00000000
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_private_mode = 00000000
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_private_mode = 00000000
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_private_mode = 00000000
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_private_mode = 00000000
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_cert_private = DISABLED
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_cert_private = DISABLED
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_cert_private = DISABLED
Thu Aug 18 13:54:39 2016 us=322497   pkcs11_cert_private = DISABLED
Thu Aug 18 13:54:39 2016 us=323470   pkcs11_cert_private = DISABLED
Thu Aug 18 13:54:39 2016 us=323470   pkcs11_cert_private = DISABLED
Thu Aug 18 13:54:39 2016 us=323470   pkcs11_cert_private = DISABLED
Thu Aug 18 13:54:39 2016 us=323470   pkcs11_cert_private = DISABLED
Thu Aug 18 13:54:39 2016 us=323470   pkcs11_cert_private = DISABLED
Thu Aug 18 13:54:39 2016 us=323470   pkcs11_cert_private = DISABLED
Thu Aug 18 13:54:39 2016 us=323470   pkcs11_cert_private = DISABLED
Thu Aug 18 13:54:39 2016 us=323470   pkcs11_cert_private = DISABLED
Thu Aug 18 13:54:39 2016 us=323470   pkcs11_cert_private = DISABLED
Thu Aug 18 13:54:39 2016 us=323470   pkcs11_cert_private = DISABLED
Thu Aug 18 13:54:39 2016 us=323470   pkcs11_cert_private = DISABLED
Thu Aug 18 13:54:39 2016 us=323470   pkcs11_cert_private = DISABLED
Thu Aug 18 13:54:39 2016 us=323470   pkcs11_pin_cache_period = -1
Thu Aug 18 13:54:39 2016 us=323470   pkcs11_id = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=323470   pkcs11_id_management = DISABLED
Thu Aug 18 13:54:39 2016 us=323470   server_network = 0.0.0.0
Thu Aug 18 13:54:39 2016 us=323470   server_netmask = 0.0.0.0
Thu Aug 18 13:54:39 2016 us=323470   server_network_ipv6 = ::
Thu Aug 18 13:54:39 2016 us=323470   server_netbits_ipv6 = 0
Thu Aug 18 13:54:39 2016 us=323470   server_bridge_ip = 0.0.0.0
Thu Aug 18 13:54:39 2016 us=323470   server_bridge_netmask = 0.0.0.0
Thu Aug 18 13:54:39 2016 us=323470   server_bridge_pool_start = 0.0.0.0
Thu Aug 18 13:54:39 2016 us=323470   server_bridge_pool_end = 0.0.0.0
Thu Aug 18 13:54:39 2016 us=323470   ifconfig_pool_defined = DISABLED
Thu Aug 18 13:54:39 2016 us=323470   ifconfig_pool_start = 0.0.0.0
Thu Aug 18 13:54:39 2016 us=323470   ifconfig_pool_end = 0.0.0.0
Thu Aug 18 13:54:39 2016 us=323470   ifconfig_pool_netmask = 0.0.0.0
Thu Aug 18 13:54:39 2016 us=323470   ifconfig_pool_persist_filename = 
'[UNDEF]'
Thu Aug 18 13:54:39 2016 us=323470 ifconfig_pool_persist_refresh_freq = 600
Thu Aug 18 13:54:39 2016 us=323470   ifconfig_ipv6_pool_defined = DISABLED
Thu Aug 18 13:54:39 2016 us=323470   ifconfig_ipv6_pool_base = ::
Thu Aug 18 13:54:39 2016 us=323470   ifconfig_ipv6_pool_netbits = 0
Thu Aug 18 13:54:39 2016 us=323470   n_bcast_buf = 256
Thu Aug 18 13:54:39 2016 us=323470   tcp_queue_limit = 64
Thu Aug 18 13:54:39 2016 us=323470   real_hash_size = 256
Thu Aug 18 13:54:39 2016 us=323470   virtual_hash_size = 256
Thu Aug 18 13:54:39 2016 us=323470   client_connect_script = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=323470   learn_address_script = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=323470   client_disconnect_script = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=323470   client_config_dir = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=323470   ccd_exclusive = DISABLED
Thu Aug 18 13:54:39 2016 us=323470   tmp_dir = 
'C:\Users\root\AppData\Local\Temp\'
Thu Aug 18 13:54:39 2016 us=323470   push_ifconfig_defined = DISABLED
Thu Aug 18 13:54:39 2016 us=323470   push_ifconfig_local = 0.0.0.0
Thu Aug 18 13:54:39 2016 us=323470   push_ifconfig_remote_netmask = 0.0.0.0
Thu Aug 18 13:54:39 2016 us=323470   push_ifconfig_ipv6_defined = DISABLED
Thu Aug 18 13:54:39 2016 us=323470   push_ifconfig_ipv6_local = ::/0
Thu Aug 18 13:54:39 2016 us=324448   push_ifconfig_ipv6_remote = ::
Thu Aug 18 13:54:39 2016 us=324448   enable_c2c = DISABLED
Thu Aug 18 13:54:39 2016 us=324448   duplicate_cn = DISABLED
Thu Aug 18 13:54:39 2016 us=324448   cf_max = 0
Thu Aug 18 13:54:39 2016 us=324448   cf_per = 0
Thu Aug 18 13:54:39 2016 us=324448   max_clients = 1024
Thu Aug 18 13:54:39 2016 us=324448   max_routes_per_client = 256
Thu Aug 18 13:54:39 2016 us=324448   auth_user_pass_verify_script = 
'[UNDEF]'
Thu Aug 18 13:54:39 2016 us=324448 auth_user_pass_verify_script_via_file 
= DISABLED
Thu Aug 18 13:54:39 2016 us=324448   client = ENABLED
Thu Aug 18 13:54:39 2016 us=324448   pull = ENABLED
Thu Aug 18 13:54:39 2016 us=324448   auth_user_pass_file = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=324448   show_net_up = DISABLED
Thu Aug 18 13:54:39 2016 us=324448   route_method = 3
Thu Aug 18 13:54:39 2016 us=324448   block_outside_dns = DISABLED
Thu Aug 18 13:54:39 2016 us=324448   ip_win32_defined = DISABLED
Thu Aug 18 13:54:39 2016 us=324448   ip_win32_type = 3
Thu Aug 18 13:54:39 2016 us=324448   dhcp_masq_offset = 0
Thu Aug 18 13:54:39 2016 us=324448   dhcp_lease_time = 31536000
Thu Aug 18 13:54:39 2016 us=324448   tap_sleep = 0
Thu Aug 18 13:54:39 2016 us=324448   dhcp_options = DISABLED
Thu Aug 18 13:54:39 2016 us=324448   dhcp_renew = DISABLED
Thu Aug 18 13:54:39 2016 us=324448   dhcp_pre_release = DISABLED
Thu Aug 18 13:54:39 2016 us=324448   dhcp_release = DISABLED
Thu Aug 18 13:54:39 2016 us=324448   domain = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=324448   netbios_scope = '[UNDEF]'
Thu Aug 18 13:54:39 2016 us=324448   netbios_node_type = 0
Thu Aug 18 13:54:39 2016 us=324448   disable_nbt = DISABLED
Thu Aug 18 13:54:39 2016 us=324448 OpenVPN 2.3_git x86_64-w64-mingw32 
[SSL (OpenSSL)] [LZO] [LZ4] [PKCS11] [IPv6] built on Aug 12 2016
Thu Aug 18 13:54:39 2016 us=324448 Windows version 6.2 (Windows 8 or 
greater) 64bit
Thu Aug 18 13:54:39 2016 us=324448 library versions: OpenSSL 1.0.1t 3 
May 2016, LZO 2.09
Enter Management Password:
Thu Aug 18 13:54:39 2016 us=342041 MANAGEMENT: TCP Socket listening on 
[AF_INET]127.0.0.1:25340
Thu Aug 18 13:54:39 2016 us=343018 Need hold release from management 
interface, waiting...
Thu Aug 18 13:54:39 2016 us=775380 MANAGEMENT: Client connected from 
[AF_INET]127.0.0.1:25340
Thu Aug 18 13:54:39 2016 us=877028 MANAGEMENT: CMD 'state on'
Thu Aug 18 13:54:39 2016 us=877028 MANAGEMENT: CMD 'log all on'
Thu Aug 18 13:54:40 2016 us=34417 MANAGEMENT: CMD 'hold off'
Thu Aug 18 13:54:40 2016 us=37350 MANAGEMENT: CMD 'hold release'
Thu Aug 18 13:54:40 2016 us=182030 Outgoing Control Channel 
Authentication: Using 160 bit message hash 'SHA1' for HMAC authentication
Thu Aug 18 13:54:40 2016 us=182030 Incoming Control Channel 
Authentication: Using 160 bit message hash 'SHA1' for HMAC authentication
Thu Aug 18 13:54:40 2016 us=182030 Control Channel MTU parms [ L:1622 
D:1184 EF:66 EB:0 ET:0 EL:3 ]
Thu Aug 18 13:54:40 2016 us=182030 Data Channel MTU parms [ L:1622 
D:1450 EF:122 EB:406 ET:0 EL:3 ]
Thu Aug 18 13:54:40 2016 us=182030 Local Options String (VER=V4): 
'V4,dev-type tun,link-mtu 1542,tun-mtu 1500,proto UDPv4,comp-lzo,keydir 
1,cipher BF-CBC,auth SHA1,keysize 128,tls-auth,key-method 2,tls-client'
Thu Aug 18 13:54:40 2016 us=182030 Expected Remote Options String 
(VER=V4): 'V4,dev-type tun,link-mtu 1542,tun-mtu 1500,proto 
UDPv4,comp-lzo,keydir 0,cipher BF-CBC,auth SHA1,keysize 
128,tls-auth,key-method 2,tls-server'
Thu Aug 18 13:54:40 2016 us=182030 TCP/UDP: Preserving recently used 
remote address: [AF_INET]xxx:1194
Thu Aug 18 13:54:40 2016 us=182030 Socket Buffers: R=[65536->65536] 
S=[65536->65536]
Thu Aug 18 13:54:40 2016 us=182030 UDP link local: (not bound)
Thu Aug 18 13:54:40 2016 us=182030 UDP link remote: [AF_INET]xxx:1194
Thu Aug 18 13:54:40 2016 us=182030 MANAGEMENT: >STATE:1471524880,WAIT,,,,,,
Thu Aug 18 13:54:40 2016 us=186919 MANAGEMENT: >STATE:1471524880,AUTH,,,,,,
Thu Aug 18 13:54:40 2016 us=186919 TLS: Initial packet from 
[AF_INET]xxx:1194, sid=c9f6d9ba 500d9117
Thu Aug 18 13:54:40 2016 us=210382 VERIFY OK: depth=1, C=US, 
ST=California, L=San Francisco, O=Copyleft Certificate Co, OU=My 
Organizational Unit, CN=defaults, emailAddress=me@...2160...
Thu Aug 18 13:54:40 2016 us=211357 Validating certificate key usage
Thu Aug 18 13:54:40 2016 us=211357 ++ Certificate has key usage 00a0, 
expects 00a0
Thu Aug 18 13:54:40 2016 us=211357 VERIFY KU OK
Thu Aug 18 13:54:40 2016 us=211357 Validating certificate extended key 
usage
Thu Aug 18 13:54:40 2016 us=211357 ++ Certificate has EKU (str) TLS Web 
Server Authentication, expects TLS Web Server Authentication
Thu Aug 18 13:54:40 2016 us=211357 VERIFY EKU OK
Thu Aug 18 13:54:40 2016 us=211357 VERIFY OK: depth=0, C=US, 
ST=California, L=San Francisco, O=Copyleft Certificate Co, OU=My 
Organizational Unit, CN=defaults, emailAddress=me@...2160...
Thu Aug 18 13:54:40 2016 us=230909 Control Channel: TLSv1.2, cipher 
TLSv1/SSLv3 ECDHE-RSA-AES256-GCM-SHA384, 2048 bit RSA
Thu Aug 18 13:54:40 2016 us=230909 [defaults] Peer Connection Initiated 
with [AF_INET]xxx:1194
Thu Aug 18 13:54:41 2016 us=233942 MANAGEMENT: 
 >STATE:1471524881,GET_CONFIG,,,,,,
Thu Aug 18 13:54:41 2016 us=233942 SENT CONTROL [defaults]: 
'PUSH_REQUEST' (status=1)
Thu Aug 18 13:54:41 2016 us=237858 PUSH: Received control message: 
'PUSH_REPLY,ifconfig-ipv6 12fc:1918::10:8:0:1000/112 
12fc:1918::10:8:0:1,comp-lzo no,explicit-exit-notify 3,tun-ipv6,route 
10.8.0.1,topology net30,ping 10,ping-restart 30,peer-id 0,cipher 
AES-256-GCM,ifconfig 10.8.0.6 10.8.0.5'
Thu Aug 18 13:54:41 2016 us=237858 Option 'explicit-exit-notify' in 
[PUSH-OPTIONS]:3 is ignored by previous <connection> blocks
Thu Aug 18 13:54:41 2016 us=237858 OPTIONS IMPORT: timers and/or 
timeouts modified
Thu Aug 18 13:54:41 2016 us=237858 OPTIONS IMPORT: explicit notify 
parm(s) modified
Thu Aug 18 13:54:41 2016 us=237858 OPTIONS IMPORT: compression parms 
modified
Thu Aug 18 13:54:41 2016 us=237858 OPTIONS IMPORT: --ifconfig/up options 
modified
Thu Aug 18 13:54:41 2016 us=237858 OPTIONS IMPORT: route options modified
Thu Aug 18 13:54:41 2016 us=237858 OPTIONS IMPORT: peer-id set
Thu Aug 18 13:54:41 2016 us=237858 OPTIONS IMPORT: adjusting link_mtu to 
1625
Thu Aug 18 13:54:41 2016 us=237858 OPTIONS IMPORT: data channel crypto 
options modified
Thu Aug 18 13:54:41 2016 us=237858 Data Channel MTU parms [ L:1538 
D:1538 EF:38 EB:406 ET:0 EL:3 ]
Thu Aug 18 13:54:41 2016 us=237858 Data Channel Encrypt: Cipher 
'AES-256-GCM' initialized with 256 bit key
Thu Aug 18 13:54:41 2016 us=237858 Data Channel Decrypt: Cipher 
'AES-256-GCM' initialized with 256 bit key
Thu Aug 18 13:54:41 2016 us=237858 interactive service msg_channel=564
Thu Aug 18 13:54:41 2016 us=239816 ROUTE_GATEWAY 
172.27.72.226/255.255.255.0 I=9 HWADDR=0a:00:27:00:00:09
Thu Aug 18 13:54:41 2016 us=240792 do_ifconfig, tt->ipv6=1, 
tt->did_ifconfig_ipv6_setup=1
Thu Aug 18 13:54:41 2016 us=240792 MANAGEMENT: 
 >STATE:1471524881,ASSIGN_IP,,10.8.0.6,,,,,12fc:1918::10:8:0:1000
Thu Aug 18 13:54:41 2016 us=240792 MANAGEMENT: Client disconnected
Thu Aug 18 13:54:41 2016 us=240792 Error: When using --tun-ipv6, if you 
have more than one TAP-Windows adapter, you must also specify --dev-node
Thu Aug 18 13:54:41 2016 us=240792 Exiting due to fatal error


For reference:

Server config
===

cd /etc/openvpn
dev tun

server 10.8.0.0 255.255.255.0

server-ipv6 12fc:1918::10:8:0:0/112

keepalive 10 30
comp-lzo no
push "comp-lzo no"
push "explicit-exit-notify 3"

log defaults/vpn.log
verb 4

management 127.0.0.1 51194

tls-auth defaults/ta.key 0
ca defaults/ca.crt
cert defaults/defaults.crt
key defaults/defaults.key  # This file should be kept secret
dh defaults/dh-4096b.pem

### EOF


Server version:

Thu Aug 18 11:33:11 2016 us=33390 OpenVPN 2.3_git 
[git:master/834f602fd069118b] x86_64-unknown-linux-gnu [SSL (OpenSSL)] 
[LZO] [LZ4] [EPOLL] [MH] [IPv6] built on Jul 26 2016
Thu Aug 18 11:33:11 2016 us=33442 library versions: OpenSSL 1.0.1f 6 Jan 
2014, LZO 2.06
Thu Aug 18 11:33:11 2016 us=34469 MANAGEMENT: TCP Socket listening on 
[AF_INET]127.0.0.1:51194

* Nothing unusual in server log *

-- 
Happy to create bug report if required.
Regards


