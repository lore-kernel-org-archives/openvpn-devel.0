Message-ID: <4CBC6CD4.7000103@...1418...>
Date: Mon, 18 Oct 2010 17:50:44 +0200
From: Christian Rank <christian.rank@...1418...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050503030208010603050102"
Subject: [Openvpn-devel] Errors adding routes on Windows 7 with OpenVPN 2.1.3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050503030208010603050102
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

we noticed a strange problem with OpenVPN 2.1.3 on a Windows 7 client
here: The VPN tunnel to an OpenVPN server does no longer work since the
OpenVPN 2.1.3 software tries to insert many strange routes into the
Windows 7 routing tables. With OpenVPN 2.1.1, all goes well. Our OpenVPN
server is running on OpenVPN 2.1_rc15 i686-pc-linux-gnu.

I have attached the Windows OpenVPN log file (with verbosity 4).

Maybe this is a bug in the Windows implementation of OpenVPN 2.1.3?

Thanks in advance for any help,
	Christian

- --=20
Dr. Christian Rank
Rechenzentrum Universit=E4t Passau
Bereich Netzwerk und Telekommunikation
Innstr. 33
D-94032 Passau
GERMANY
Tel.: 0851/509-1838
Fax:  0851/509-1802
PGP public key see http://www.rz.uni-passau.de/mitarbeiter/rank
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iJwEAQECAAYFAky8bM8ACgkQICQoVWVVBdXzYQQAlDytBOe1ssO6hgghgd80Kfa5
PY+7NkSLg+0ejCtEv2zLJ28YXf0Up5164celXVY2Hd+xjNXuUNOPezQ5cV2/agAh
ZIR97cfGZx0gDl92E7dwo0enCL23n/fwEnzJD9VkrjJ13eIiKIRhGZO297vSTsL2
jvtBTIMCvxPtKBonmX0=3D
=3DWRBl
-----END PGP SIGNATURE-----

--------------050503030208010603050102
Content-Type: text/x-log;
 name="pers-ext.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pers-ext.log"

Mon Oct 18 17:37:52 2010 NOTE: --user option is not implemented on Windows
Mon Oct 18 17:37:52 2010 NOTE: --group option is not implemented on Windows
Mon Oct 18 17:37:52 2010 us=320000 Current Parameter Settings:
Mon Oct 18 17:37:52 2010 us=320000   config = 'pers-ext.ovpn'
Mon Oct 18 17:37:52 2010 us=320000   mode = 0
Mon Oct 18 17:37:52 2010 us=320000   show_ciphers = DISABLED
Mon Oct 18 17:37:52 2010 us=320000   show_digests = DISABLED
Mon Oct 18 17:37:52 2010 us=320000   show_engines = DISABLED
Mon Oct 18 17:37:52 2010 us=320000   genkey = DISABLED
Mon Oct 18 17:37:52 2010 us=320000   key_pass_file = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=320000   show_tls_ciphers = DISABLED
Mon Oct 18 17:37:52 2010 us=320000 Connection profiles [default]:
Mon Oct 18 17:37:52 2010 us=320000   proto = tcp-client
Mon Oct 18 17:37:52 2010 us=320000   local = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=320000   local_port = 0
Mon Oct 18 17:37:52 2010 us=320000   remote = '132.231.254.253'
Mon Oct 18 17:37:52 2010 us=320000   remote_port = 1198
Mon Oct 18 17:37:52 2010 us=320000   remote_float = DISABLED
Mon Oct 18 17:37:52 2010 us=320000   bind_defined = DISABLED
Mon Oct 18 17:37:52 2010 us=320000   bind_local = DISABLED
Mon Oct 18 17:37:52 2010 us=320000   connect_retry_seconds = 15
Mon Oct 18 17:37:52 2010 us=320000   connect_timeout = 10
Mon Oct 18 17:37:52 2010 us=320000   connect_retry_max = 2
Mon Oct 18 17:37:52 2010 us=320000   socks_proxy_server = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=320000   socks_proxy_port = 0
Mon Oct 18 17:37:52 2010 us=320000   socks_proxy_retry = DISABLED
Mon Oct 18 17:37:52 2010 us=320000 Connection profiles END
Mon Oct 18 17:37:52 2010 us=320000   remote_random = DISABLED
Mon Oct 18 17:37:52 2010 us=320000   ipchange = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=320000   dev = 'tun'
Mon Oct 18 17:37:52 2010 us=320000   dev_type = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=320000   dev_node = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=320000   lladdr = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=320000   topology = 1
Mon Oct 18 17:37:52 2010 us=320000   tun_ipv6 = DISABLED
Mon Oct 18 17:37:52 2010 us=320000   ifconfig_local = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=320000   ifconfig_remote_netmask = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=320000   ifconfig_noexec = DISABLED
Mon Oct 18 17:37:52 2010 us=320000   ifconfig_nowarn = DISABLED
Mon Oct 18 17:37:52 2010 us=320000   shaper = 0
Mon Oct 18 17:37:52 2010 us=320000   tun_mtu = 1500
Mon Oct 18 17:37:52 2010 us=320000   tun_mtu_defined = ENABLED
Mon Oct 18 17:37:52 2010 us=320000   link_mtu = 1500
Mon Oct 18 17:37:52 2010 us=320000   link_mtu_defined = DISABLED
Mon Oct 18 17:37:52 2010 us=320000   tun_mtu_extra = 0
Mon Oct 18 17:37:52 2010 us=320000   tun_mtu_extra_defined = DISABLED
Mon Oct 18 17:37:52 2010 us=320000   fragment = 0
Mon Oct 18 17:37:52 2010 us=320000   mtu_discover_type = -1
Mon Oct 18 17:37:52 2010 us=320000   mtu_test = 0
Mon Oct 18 17:37:52 2010 us=320000   mlock = DISABLED
Mon Oct 18 17:37:52 2010 us=320000   keepalive_ping = 0
Mon Oct 18 17:37:52 2010 us=320000   keepalive_timeout = 0
Mon Oct 18 17:37:52 2010 us=320000   inactivity_timeout = 0
Mon Oct 18 17:37:52 2010 us=320000   ping_send_timeout = 0
Mon Oct 18 17:37:52 2010 us=320000   ping_rec_timeout = 0
Mon Oct 18 17:37:52 2010 us=320000   ping_rec_timeout_action = 0
Mon Oct 18 17:37:52 2010 us=320000   ping_timer_remote = DISABLED
Mon Oct 18 17:37:52 2010 us=320000   remap_sigusr1 = 0
Mon Oct 18 17:37:52 2010 us=320000   explicit_exit_notification = 0
Mon Oct 18 17:37:52 2010 us=320000   persist_tun = ENABLED
Mon Oct 18 17:37:52 2010 us=320000   persist_local_ip = DISABLED
Mon Oct 18 17:37:52 2010 us=320000   persist_remote_ip = DISABLED
Mon Oct 18 17:37:52 2010 us=320000   persist_key = ENABLED
Mon Oct 18 17:37:52 2010 us=320000   mssfix = 1450
Mon Oct 18 17:37:52 2010 us=320000   resolve_retry_seconds = 0
Mon Oct 18 17:37:52 2010 us=320000   username = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=320000   groupname = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=320000   chroot_dir = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=539000   cd_dir = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=539000   writepid = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=539000   up_script = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=539000   down_script = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=539000   down_pre = DISABLED
Mon Oct 18 17:37:52 2010 us=539000   up_restart = DISABLED
Mon Oct 18 17:37:52 2010 us=539000   up_delay = DISABLED
Mon Oct 18 17:37:52 2010 us=539000   daemon = DISABLED
Mon Oct 18 17:37:52 2010 us=539000   inetd = 0
Mon Oct 18 17:37:52 2010 us=539000   log = DISABLED
Mon Oct 18 17:37:52 2010 us=539000   suppress_timestamps = DISABLED
Mon Oct 18 17:37:52 2010 us=539000   nice = 0
Mon Oct 18 17:37:52 2010 us=539000   verbosity = 4
Mon Oct 18 17:37:52 2010 us=539000   mute = 0
Mon Oct 18 17:37:52 2010 us=539000   gremlin = 0
Mon Oct 18 17:37:52 2010 us=539000   status_file = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=539000   status_file_version = 1
Mon Oct 18 17:37:52 2010 us=539000   status_file_update_freq = 60
Mon Oct 18 17:37:52 2010 us=570000   occ = ENABLED
Mon Oct 18 17:37:52 2010 us=570000   rcvbuf = 0
Mon Oct 18 17:37:52 2010 us=570000   sndbuf = 0
Mon Oct 18 17:37:52 2010 us=570000   sockflags = 0
Mon Oct 18 17:37:52 2010 us=570000   fast_io = DISABLED
Mon Oct 18 17:37:52 2010 us=570000   lzo = 1
Mon Oct 18 17:37:52 2010 us=570000   route_script = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=570000   route_default_gateway = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=570000   route_default_metric = 0
Mon Oct 18 17:37:52 2010 us=570000   route_noexec = DISABLED
Mon Oct 18 17:37:52 2010 us=570000   route_delay = 5
Mon Oct 18 17:37:52 2010 us=570000   route_delay_window = 30
Mon Oct 18 17:37:52 2010 us=570000   route_delay_defined = ENABLED
Mon Oct 18 17:37:52 2010 us=570000   route_nopull = DISABLED
Mon Oct 18 17:37:52 2010 us=570000   route_gateway_via_dhcp = DISABLED
Mon Oct 18 17:37:52 2010 us=570000   max_routes = 100
Mon Oct 18 17:37:52 2010 us=570000   allow_pull_fqdn = DISABLED
Mon Oct 18 17:37:52 2010 us=601000   management_addr = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=601000   management_port = 0
Mon Oct 18 17:37:52 2010 us=601000   management_user_pass = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=601000   management_log_history_cache = 250
Mon Oct 18 17:37:52 2010 us=601000   management_echo_buffer_size = 100
Mon Oct 18 17:37:52 2010 us=601000   management_write_peer_info_file = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=601000   management_client_user = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=601000   management_client_group = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=601000   management_flags = 0
Mon Oct 18 17:37:52 2010 us=601000   shared_secret_file = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=601000   key_direction = 2
Mon Oct 18 17:37:52 2010 us=601000   ciphername_defined = ENABLED
Mon Oct 18 17:37:52 2010 us=601000   ciphername = 'BF-CBC'
Mon Oct 18 17:37:52 2010 us=601000   authname_defined = ENABLED
Mon Oct 18 17:37:52 2010 us=648000   authname = 'SHA1'
Mon Oct 18 17:37:52 2010 us=648000   prng_hash = 'SHA1'
Mon Oct 18 17:37:52 2010 us=648000   prng_nonce_secret_len = 16
Mon Oct 18 17:37:52 2010 us=648000   keysize = 0
Mon Oct 18 17:37:52 2010 us=648000   engine = DISABLED
Mon Oct 18 17:37:52 2010 us=648000   replay = ENABLED
Mon Oct 18 17:37:52 2010 us=648000   mute_replay_warnings = ENABLED
Mon Oct 18 17:37:52 2010 us=648000   replay_window = 64
Mon Oct 18 17:37:52 2010 us=648000   replay_time = 15
Mon Oct 18 17:37:52 2010 us=648000   packet_id_file = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=648000   use_iv = ENABLED
Mon Oct 18 17:37:52 2010 us=648000   test_crypto = DISABLED
Mon Oct 18 17:37:52 2010 us=648000   tls_server = DISABLED
Mon Oct 18 17:37:52 2010 us=648000   tls_client = ENABLED
Mon Oct 18 17:37:52 2010 us=648000   key_method = 2
Mon Oct 18 17:37:52 2010 us=648000   ca_file = 'cachain.crt'
Mon Oct 18 17:37:52 2010 us=648000   ca_path = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=679000   dh_file = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=679000   cert_file = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=679000   priv_key_file = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=679000   pkcs12_file = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=679000   cryptoapi_cert = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=679000   cipher_list = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=679000   tls_verify = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=679000   tls_remote = 'openvpn.rz.uni-passau.de'
Mon Oct 18 17:37:52 2010 us=679000   crl_file = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=679000   ns_cert_type = 0
Mon Oct 18 17:37:52 2010 us=679000   remote_cert_ku[i] = 0
Mon Oct 18 17:37:52 2010 us=679000   remote_cert_ku[i] = 0
Mon Oct 18 17:37:52 2010 us=679000   remote_cert_ku[i] = 0
Mon Oct 18 17:37:52 2010 us=679000   remote_cert_ku[i] = 0
Mon Oct 18 17:37:52 2010 us=679000   remote_cert_ku[i] = 0
Mon Oct 18 17:37:52 2010 us=679000   remote_cert_ku[i] = 0
Mon Oct 18 17:37:52 2010 us=726000   remote_cert_ku[i] = 0
Mon Oct 18 17:37:52 2010 us=726000   remote_cert_ku[i] = 0
Mon Oct 18 17:37:52 2010 us=726000   remote_cert_ku[i] = 0
Mon Oct 18 17:37:52 2010 us=726000   remote_cert_ku[i] = 0
Mon Oct 18 17:37:52 2010 us=726000   remote_cert_ku[i] = 0
Mon Oct 18 17:37:52 2010 us=726000   remote_cert_ku[i] = 0
Mon Oct 18 17:37:52 2010 us=726000   remote_cert_ku[i] = 0
Mon Oct 18 17:37:52 2010 us=726000   remote_cert_ku[i] = 0
Mon Oct 18 17:37:52 2010 us=726000   remote_cert_ku[i] = 0
Mon Oct 18 17:37:52 2010 us=726000   remote_cert_ku[i] = 0
Mon Oct 18 17:37:52 2010 us=726000   remote_cert_eku = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=726000   tls_timeout = 2
Mon Oct 18 17:37:52 2010 us=726000   renegotiate_bytes = 0
Mon Oct 18 17:37:52 2010 us=726000   renegotiate_packets = 0
Mon Oct 18 17:37:52 2010 us=726000   renegotiate_seconds = 43200
Mon Oct 18 17:37:52 2010 us=726000   handshake_window = 60
Mon Oct 18 17:37:52 2010 us=726000   transition_window = 3600
Mon Oct 18 17:37:52 2010 us=773000   single_session = DISABLED
Mon Oct 18 17:37:52 2010 us=773000   push_peer_info = DISABLED
Mon Oct 18 17:37:52 2010 us=773000   tls_exit = DISABLED
Mon Oct 18 17:37:52 2010 us=773000   tls_auth_file = 'ta.key'
Mon Oct 18 17:37:52 2010 us=773000   pkcs11_protected_authentication = DISABLED
Mon Oct 18 17:37:52 2010 us=773000   pkcs11_protected_authentication = DISABLED
Mon Oct 18 17:37:52 2010 us=773000   pkcs11_protected_authentication = DISABLED
Mon Oct 18 17:37:52 2010 us=773000   pkcs11_protected_authentication = DISABLED
Mon Oct 18 17:37:52 2010 us=773000   pkcs11_protected_authentication = DISABLED
Mon Oct 18 17:37:52 2010 us=773000   pkcs11_protected_authentication = DISABLED
Mon Oct 18 17:37:52 2010 us=773000   pkcs11_protected_authentication = DISABLED
Mon Oct 18 17:37:52 2010 us=773000   pkcs11_protected_authentication = DISABLED
Mon Oct 18 17:37:52 2010 us=773000   pkcs11_protected_authentication = DISABLED
Mon Oct 18 17:37:52 2010 us=804000   pkcs11_protected_authentication = DISABLED
Mon Oct 18 17:37:52 2010 us=804000   pkcs11_protected_authentication = DISABLED
Mon Oct 18 17:37:52 2010 us=804000   pkcs11_protected_authentication = DISABLED
Mon Oct 18 17:37:52 2010 us=804000   pkcs11_protected_authentication = DISABLED
Mon Oct 18 17:37:52 2010 us=804000   pkcs11_protected_authentication = DISABLED
Mon Oct 18 17:37:52 2010 us=804000   pkcs11_protected_authentication = DISABLED
Mon Oct 18 17:37:52 2010 us=804000   pkcs11_protected_authentication = DISABLED
Mon Oct 18 17:37:52 2010 us=804000   pkcs11_private_mode = 00000000
Mon Oct 18 17:37:52 2010 us=804000   pkcs11_private_mode = 00000000
Mon Oct 18 17:37:52 2010 us=804000   pkcs11_private_mode = 00000000
Mon Oct 18 17:37:52 2010 us=804000   pkcs11_private_mode = 00000000
Mon Oct 18 17:37:52 2010 us=804000   pkcs11_private_mode = 00000000
Mon Oct 18 17:37:52 2010 us=804000   pkcs11_private_mode = 00000000
Mon Oct 18 17:37:52 2010 us=804000   pkcs11_private_mode = 00000000
Mon Oct 18 17:37:52 2010 us=835000   pkcs11_private_mode = 00000000
Mon Oct 18 17:37:52 2010 us=835000   pkcs11_private_mode = 00000000
Mon Oct 18 17:37:52 2010 us=835000   pkcs11_private_mode = 00000000
Mon Oct 18 17:37:52 2010 us=835000   pkcs11_private_mode = 00000000
Mon Oct 18 17:37:52 2010 us=835000   pkcs11_private_mode = 00000000
Mon Oct 18 17:37:52 2010 us=835000   pkcs11_private_mode = 00000000
Mon Oct 18 17:37:52 2010 us=835000   pkcs11_private_mode = 00000000
Mon Oct 18 17:37:52 2010 us=835000   pkcs11_private_mode = 00000000
Mon Oct 18 17:37:52 2010 us=835000   pkcs11_private_mode = 00000000
Mon Oct 18 17:37:52 2010 us=835000   pkcs11_cert_private = DISABLED
Mon Oct 18 17:37:52 2010 us=835000   pkcs11_cert_private = DISABLED
Mon Oct 18 17:37:52 2010 us=835000   pkcs11_cert_private = DISABLED
Mon Oct 18 17:37:52 2010 us=835000   pkcs11_cert_private = DISABLED
Mon Oct 18 17:37:52 2010 us=835000   pkcs11_cert_private = DISABLED
Mon Oct 18 17:37:52 2010 us=866000   pkcs11_cert_private = DISABLED
Mon Oct 18 17:37:52 2010 us=866000   pkcs11_cert_private = DISABLED
Mon Oct 18 17:37:52 2010 us=866000   pkcs11_cert_private = DISABLED
Mon Oct 18 17:37:52 2010 us=866000   pkcs11_cert_private = DISABLED
Mon Oct 18 17:37:52 2010 us=866000   pkcs11_cert_private = DISABLED
Mon Oct 18 17:37:52 2010 us=866000   pkcs11_cert_private = DISABLED
Mon Oct 18 17:37:52 2010 us=866000   pkcs11_cert_private = DISABLED
Mon Oct 18 17:37:52 2010 us=866000   pkcs11_cert_private = DISABLED
Mon Oct 18 17:37:52 2010 us=866000   pkcs11_cert_private = DISABLED
Mon Oct 18 17:37:52 2010 us=866000   pkcs11_cert_private = DISABLED
Mon Oct 18 17:37:52 2010 us=866000   pkcs11_cert_private = DISABLED
Mon Oct 18 17:37:52 2010 us=866000   pkcs11_pin_cache_period = -1
Mon Oct 18 17:37:52 2010 us=866000   pkcs11_id = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=866000   pkcs11_id_management = DISABLED
Mon Oct 18 17:37:52 2010 us=866000   server_network = 0.0.0.0
Mon Oct 18 17:37:52 2010 us=898000   server_netmask = 0.0.0.0
Mon Oct 18 17:37:52 2010 us=898000   server_bridge_ip = 0.0.0.0
Mon Oct 18 17:37:52 2010 us=898000   server_bridge_netmask = 0.0.0.0
Mon Oct 18 17:37:52 2010 us=898000   server_bridge_pool_start = 0.0.0.0
Mon Oct 18 17:37:52 2010 us=898000   server_bridge_pool_end = 0.0.0.0
Mon Oct 18 17:37:52 2010 us=898000   ifconfig_pool_defined = DISABLED
Mon Oct 18 17:37:52 2010 us=898000   ifconfig_pool_start = 0.0.0.0
Mon Oct 18 17:37:52 2010 us=898000   ifconfig_pool_end = 0.0.0.0
Mon Oct 18 17:37:52 2010 us=898000   ifconfig_pool_netmask = 0.0.0.0
Mon Oct 18 17:37:52 2010 us=898000   ifconfig_pool_persist_filename = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=898000   ifconfig_pool_persist_refresh_freq = 600
Mon Oct 18 17:37:52 2010 us=898000   n_bcast_buf = 256
Mon Oct 18 17:37:52 2010 us=898000   tcp_queue_limit = 64
Mon Oct 18 17:37:52 2010 us=898000   real_hash_size = 256
Mon Oct 18 17:37:52 2010 us=929000   virtual_hash_size = 256
Mon Oct 18 17:37:52 2010 us=929000   client_connect_script = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=929000   learn_address_script = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=929000   client_disconnect_script = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=929000   client_config_dir = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=929000   ccd_exclusive = DISABLED
Mon Oct 18 17:37:52 2010 us=929000   tmp_dir = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=929000   push_ifconfig_defined = DISABLED
Mon Oct 18 17:37:52 2010 us=929000   push_ifconfig_local = 0.0.0.0
Mon Oct 18 17:37:52 2010 us=929000   push_ifconfig_remote_netmask = 0.0.0.0
Mon Oct 18 17:37:52 2010 us=929000   enable_c2c = DISABLED
Mon Oct 18 17:37:52 2010 us=929000   duplicate_cn = DISABLED
Mon Oct 18 17:37:52 2010 us=929000   cf_max = 0
Mon Oct 18 17:37:52 2010 us=929000   cf_per = 0
Mon Oct 18 17:37:52 2010 us=929000   max_clients = 1024
Mon Oct 18 17:37:52 2010 us=929000   max_routes_per_client = 256
Mon Oct 18 17:37:52 2010 us=960000   auth_user_pass_verify_script = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=960000   auth_user_pass_verify_script_via_file = DISABLED
Mon Oct 18 17:37:52 2010 us=960000   ssl_flags = 0
Mon Oct 18 17:37:52 2010 us=960000   client = ENABLED
Mon Oct 18 17:37:52 2010 us=960000   pull = ENABLED
Mon Oct 18 17:37:52 2010 us=960000   auth_user_pass_file = 'stdin'
Mon Oct 18 17:37:52 2010 us=960000   show_net_up = DISABLED
Mon Oct 18 17:37:52 2010 us=960000   route_method = 0
Mon Oct 18 17:37:52 2010 us=960000   ip_win32_defined = DISABLED
Mon Oct 18 17:37:52 2010 us=960000   ip_win32_type = 3
Mon Oct 18 17:37:52 2010 us=960000   dhcp_masq_offset = 0
Mon Oct 18 17:37:52 2010 us=960000   dhcp_lease_time = 31536000
Mon Oct 18 17:37:52 2010 us=960000   tap_sleep = 0
Mon Oct 18 17:37:52 2010 us=960000   dhcp_options = DISABLED
Mon Oct 18 17:37:52 2010 us=960000   dhcp_renew = DISABLED
Mon Oct 18 17:37:52 2010 us=960000   dhcp_pre_release = DISABLED
Mon Oct 18 17:37:52 2010 us=991000   dhcp_release = DISABLED
Mon Oct 18 17:37:52 2010 us=991000   domain = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=991000   netbios_scope = '[UNDEF]'
Mon Oct 18 17:37:52 2010 us=991000   netbios_node_type = 0
Mon Oct 18 17:37:52 2010 us=991000   disable_nbt = DISABLED
Mon Oct 18 17:37:52 2010 us=991000 OpenVPN 2.1.3 i686-pc-mingw32 [SSL] [LZO2] [PKCS11] built on Aug 20 2010
Mon Oct 18 17:37:58 2010 us=982000 WARNING: Make sure you understand the semantics of --tls-remote before using it (see the man page).
Mon Oct 18 17:37:58 2010 us=982000 NOTE: OpenVPN 2.1 requires '--script-security 2' or higher to call user-defined scripts or executables
Mon Oct 18 17:37:59 2010 us=434000 Control Channel Authentication: using 'ta.key' as a OpenVPN static key file
Mon Oct 18 17:37:59 2010 us=434000 Outgoing Control Channel Authentication: Using 160 bit message hash 'SHA1' for HMAC authentication
Mon Oct 18 17:37:59 2010 us=434000 Incoming Control Channel Authentication: Using 160 bit message hash 'SHA1' for HMAC authentication
Mon Oct 18 17:37:59 2010 us=434000 LZO compression initialized
Mon Oct 18 17:37:59 2010 us=434000 Control Channel MTU parms [ L:1544 D:168 EF:68 EB:0 ET:0 EL:0 ]
Mon Oct 18 17:37:59 2010 us=434000 Socket Buffers: R=[8192->8192] S=[8192->8192]
Mon Oct 18 17:37:59 2010 us=434000 Data Channel MTU parms [ L:1544 D:1450 EF:44 EB:135 ET:0 EL:0 AF:3/1 ]
Mon Oct 18 17:37:59 2010 us=434000 Local Options String: 'V4,dev-type tun,link-mtu 1544,tun-mtu 1500,proto TCPv4_CLIENT,comp-lzo,keydir 1,cipher BF-CBC,auth SHA1,keysize 128,tls-auth,key-method 2,tls-client'
Mon Oct 18 17:37:59 2010 us=434000 Expected Remote Options String: 'V4,dev-type tun,link-mtu 1544,tun-mtu 1500,proto TCPv4_SERVER,comp-lzo,keydir 0,cipher BF-CBC,auth SHA1,keysize 128,tls-auth,key-method 2,tls-server'
Mon Oct 18 17:37:59 2010 us=434000 Local Options hash (VER=V4): 'ee93268d'
Mon Oct 18 17:37:59 2010 us=434000 Expected Remote Options hash (VER=V4): 'bd577cd1'
Mon Oct 18 17:37:59 2010 us=434000 Attempting to establish TCP connection with 132.231.254.253:1198
Mon Oct 18 17:37:59 2010 us=512000 TCP connection established with 132.231.254.253:1198
Mon Oct 18 17:37:59 2010 us=512000 TCPv4_CLIENT link local: [undef]
Mon Oct 18 17:37:59 2010 us=512000 TCPv4_CLIENT link remote: 132.231.254.253:1198
Mon Oct 18 17:37:59 2010 us=590000 TLS: Initial packet from 132.231.254.253:1198, sid=8169ed30 0715a9af
Mon Oct 18 17:37:59 2010 us=590000 WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this
Mon Oct 18 17:38:02 2010 us=227000 VERIFY OK: depth=3, /C=DE/O=Deutsche_Telekom_AG/OU=T-TeleSec_Trust_Center/CN=Deutsche_Telekom_Root_CA_2
Mon Oct 18 17:38:02 2010 us=227000 VERIFY OK: depth=2, /C=DE/O=DFN-Verein/OU=DFN-PKI/CN=DFN-Verein_PCA_Global_-_G01
Mon Oct 18 17:38:02 2010 us=242000 VERIFY OK: depth=1, /C=DE/L=Passau/O=Universitaet_Passau/OU=Rechenzentrum/CN=Universitaet_Passau_CA_-_G01/emailAddress=ca@...1418...
Mon Oct 18 17:38:02 2010 us=242000 VERIFY X509NAME OK: /C=DE/L=Passau/O=Universitaet_Passau/OU=Rechenzentrum/CN=openvpn.rz.uni-passau.de
Mon Oct 18 17:38:02 2010 us=242000 VERIFY OK: depth=0, /C=DE/L=Passau/O=Universitaet_Passau/OU=Rechenzentrum/CN=openvpn.rz.uni-passau.de
Mon Oct 18 17:38:05 2010 us=113000 Data Channel Encrypt: Cipher 'BF-CBC' initialized with 128 bit key
Mon Oct 18 17:38:05 2010 us=113000 Data Channel Encrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Mon Oct 18 17:38:05 2010 us=113000 Data Channel Decrypt: Cipher 'BF-CBC' initialized with 128 bit key
Mon Oct 18 17:38:05 2010 us=113000 Data Channel Decrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Mon Oct 18 17:38:05 2010 us=113000 Control Channel: TLSv1, cipher TLSv1/SSLv3 DHE-RSA-AES256-SHA, 2048 bit RSA
Mon Oct 18 17:38:05 2010 us=113000 [openvpn.rz.uni-passau.de] Peer Connection Initiated with 132.231.254.253:1198
Mon Oct 18 17:38:07 2010 us=375000 SENT CONTROL [openvpn.rz.uni-passau.de]: 'PUSH_REQUEST' (status=1)
Mon Oct 18 17:38:07 2010 us=718000 PUSH: Received control message: 'PUSH_REPLY,route remote_host 255.255.255.255 net_gateway,route 132.231.0.0 255.255.0.0,route 10.30.0.0 255.255.0.0,ping 60,ping-exit 190,inactive 1800,comp-lzo,route-gateway 132.231.191.1,topology subnet,ifconfig 132.231.191.10 255.255.255.0'
Mon Oct 18 17:38:07 2010 us=718000 OPTIONS IMPORT: timers and/or timeouts modified
Mon Oct 18 17:38:07 2010 us=718000 OPTIONS IMPORT: LZO parms modified
Mon Oct 18 17:38:07 2010 us=718000 OPTIONS IMPORT: --ifconfig/up options modified
Mon Oct 18 17:38:07 2010 us=718000 OPTIONS IMPORT: route options modified
Mon Oct 18 17:38:07 2010 us=718000 OPTIONS IMPORT: route-related options modified
Mon Oct 18 17:38:07 2010 us=749000 ROUTE default_gateway=192.168.0.1
Mon Oct 18 17:38:07 2010 us=749000 OpenVPN ROUTE: routes dropped because number of expanded routes is greater than route list capacity (100)
Mon Oct 18 17:38:07 2010 us=843000 TAP-WIN32 device [Local Area Connection 2] opened: \\.\Global\{F8AA92FC-0D34-47D7-A1A3-CEBD5AE570D8}.tap
Mon Oct 18 17:38:07 2010 us=843000 TAP-Win32 Driver Version 9.7 
Mon Oct 18 17:38:07 2010 us=843000 TAP-Win32 MTU=1500
Mon Oct 18 17:38:07 2010 us=843000 Set TAP-Win32 TUN subnet mode network/local/netmask = 132.231.191.0/132.231.191.10/255.255.255.0 [SUCCEEDED]
Mon Oct 18 17:38:07 2010 us=843000 Notified TAP-Win32 driver to set a DHCP IP/netmask of 132.231.191.10/255.255.255.0 on interface {F8AA92FC-0D34-47D7-A1A3-CEBD5AE570D8} [DHCP-serv: 132.231.191.254, lease-time: 31536000]
Mon Oct 18 17:38:07 2010 us=843000 Successful ARP Flush on interface [19] {F8AA92FC-0D34-47D7-A1A3-CEBD5AE570D8}
Mon Oct 18 17:38:13 2010 us=6000 TEST ROUTES: 100/100 succeeded len=100 ret=1 a=0 u/d=up
Mon Oct 18 17:38:13 2010 us=6000 C:\WINDOWS\system32\route.exe ADD 0.34.243.152 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=22000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:13 2010 us=22000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:13 2010 us=22000 C:\WINDOWS\system32\route.exe ADD 119.49.156.222 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=37000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:13 2010 us=37000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:13 2010 us=53000 C:\WINDOWS\system32\route.exe ADD 1.55.147.192 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=53000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:13 2010 us=53000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:13 2010 us=69000 C:\WINDOWS\system32\route.exe ADD 0.0.0.0 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=69000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:13 2010 us=69000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:13 2010 us=84000 C:\WINDOWS\system32\route.exe ADD 0.0.11.72 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=84000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:13 2010 us=84000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:13 2010 us=100000 C:\WINDOWS\system32\route.exe ADD 0.0.0.4 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=100000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:13 2010 us=100000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:13 2010 us=115000 C:\WINDOWS\system32\route.exe ADD 0.44.43.244 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=115000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:13 2010 us=115000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:13 2010 us=131000 C:\WINDOWS\system32\route.exe ADD 0.72.195.180 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=147000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:13 2010 us=147000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:13 2010 us=147000 C:\WINDOWS\system32\route.exe ADD 0.0.0.3 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=162000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:13 2010 us=162000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:13 2010 us=162000 C:\WINDOWS\system32\route.exe ADD 0.34.243.184 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=178000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:13 2010 us=178000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:13 2010 us=178000 C:\WINDOWS\system32\route.exe ADD 0.69.241.255 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=193000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:13 2010 us=193000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:13 2010 us=209000 C:\WINDOWS\system32\route.exe ADD 0.44.43.244 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=209000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:13 2010 us=209000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:13 2010 us=209000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:13 2010 us=256000 C:\WINDOWS\system32\route.exe ADD 0.72.195.180 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=271000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:13 2010 us=271000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:13 2010 us=271000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:13 2010 us=318000 C:\WINDOWS\system32\route.exe ADD 0.0.0.3 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=318000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:13 2010 us=318000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:13 2010 us=318000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:13 2010 us=365000 C:\WINDOWS\system32\route.exe ADD 0.0.0.0 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=365000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:13 2010 us=365000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:13 2010 us=365000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:13 2010 us=412000 C:\WINDOWS\system32\route.exe ADD 0.44.43.244 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=427000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:13 2010 us=427000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:13 2010 us=427000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:13 2010 us=459000 C:\WINDOWS\system32\route.exe ADD 0.34.245.80 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=474000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:13 2010 us=474000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:13 2010 us=490000 C:\WINDOWS\system32\route.exe ADD 0.34.243.216 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=490000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:13 2010 us=490000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:13 2010 us=505000 C:\WINDOWS\system32\route.exe ADD 0.69.242.67 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=521000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:13 2010 us=521000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:13 2010 us=537000 C:\WINDOWS\system32\route.exe ADD 0.44.43.244 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=552000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:13 2010 us=552000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:13 2010 us=552000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:13 2010 us=615000 C:\WINDOWS\system32\route.exe ADD 0.0.0.0 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=630000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:13 2010 us=630000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:13 2010 us=630000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:13 2010 us=661000 C:\WINDOWS\system32\route.exe ADD 0.34.243.216 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=677000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:13 2010 us=677000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:13 2010 us=677000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:13 2010 us=724000 C:\WINDOWS\system32\route.exe ADD 1.55.147.188 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=724000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:13 2010 us=724000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:13 2010 us=739000 C:\WINDOWS\system32\route.exe ADD 0.34.251.248 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=755000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:13 2010 us=755000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:13 2010 us=755000 C:\WINDOWS\system32\route.exe ADD 0.34.245.80 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=771000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:13 2010 us=771000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:13 2010 us=771000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:13 2010 us=817000 C:\WINDOWS\system32\route.exe ADD 0.34.244.56 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=817000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:13 2010 us=817000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:13 2010 us=833000 C:\WINDOWS\system32\route.exe ADD 0.65.17.243 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=849000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:13 2010 us=849000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:13 2010 us=864000 C:\WINDOWS\system32\route.exe ADD 1.55.147.188 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=880000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:13 2010 us=880000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:13 2010 us=880000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:13 2010 us=911000 C:\WINDOWS\system32\route.exe ADD 1.53.6.100 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=927000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:13 2010 us=927000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:13 2010 us=942000 C:\WINDOWS\system32\route.exe ADD 1.55.18.108 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=958000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:13 2010 us=958000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:13 2010 us=958000 C:\WINDOWS\system32\route.exe ADD 0.0.0.0 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:13 2010 us=973000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:13 2010 us=973000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:13 2010 us=973000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:14 2010 us=20000 C:\WINDOWS\system32\route.exe ADD 132.231.254.253 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=20000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:14 2010 us=20000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:14 2010 us=36000 C:\WINDOWS\system32\route.exe ADD 1.49.210.200 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=51000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:14 2010 us=51000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:14 2010 us=51000 C:\WINDOWS\system32\route.exe ADD 132.231.254.253 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=67000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:14 2010 us=67000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:14 2010 us=67000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:14 2010 us=114000 C:\WINDOWS\system32\route.exe ADD 0.0.0.1 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=114000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:14 2010 us=114000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:14 2010 us=129000 C:\WINDOWS\system32\route.exe ADD 1.49.210.200 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=129000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:14 2010 us=129000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:14 2010 us=129000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:14 2010 us=176000 C:\WINDOWS\system32\route.exe ADD 34.0.0.3 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=192000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:14 2010 us=192000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:14 2010 us=192000 C:\WINDOWS\system32\route.exe ADD 0.0.0.0 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=207000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:14 2010 us=207000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:14 2010 us=207000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:14 2010 us=254000 C:\WINDOWS\system32\route.exe ADD 0.64.4.134 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=254000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:14 2010 us=254000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:14 2010 us=270000 C:\WINDOWS\system32\route.exe ADD 0.34.245.80 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=285000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:14 2010 us=285000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:14 2010 us=285000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:14 2010 us=332000 C:\WINDOWS\system32\route.exe ADD 0.0.0.0 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=332000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:14 2010 us=332000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:14 2010 us=332000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:14 2010 us=379000 C:\WINDOWS\system32\route.exe ADD 1.55.18.108 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=395000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:14 2010 us=395000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:14 2010 us=395000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:14 2010 us=441000 C:\WINDOWS\system32\route.exe ADD 1.49.210.200 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=441000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:14 2010 us=441000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:14 2010 us=441000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:14 2010 us=488000 C:\WINDOWS\system32\route.exe ADD 1.49.199.216 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=488000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:14 2010 us=488000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:14 2010 us=504000 C:\WINDOWS\system32\route.exe ADD 0.0.0.0 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=519000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:14 2010 us=519000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:14 2010 us=519000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:14 2010 us=551000 C:\WINDOWS\system32\route.exe ADD 0.0.0.0 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=566000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:14 2010 us=566000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:14 2010 us=566000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:14 2010 us=629000 C:\WINDOWS\system32\route.exe ADD 0.34.244.80 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=644000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:14 2010 us=644000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:14 2010 us=691000 C:\WINDOWS\system32\route.exe ADD 0.34.245.80 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=707000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:14 2010 us=707000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:14 2010 us=707000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:14 2010 us=738000 C:\WINDOWS\system32\route.exe ADD 0.34.244.188 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=753000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:14 2010 us=753000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:14 2010 us=769000 C:\WINDOWS\system32\route.exe ADD 0.34.244.104 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=769000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:14 2010 us=769000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:14 2010 us=785000 C:\WINDOWS\system32\route.exe ADD 0.65.28.146 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=785000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:14 2010 us=785000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:14 2010 us=800000 C:\WINDOWS\system32\route.exe ADD 0.34.245.80 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=816000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:14 2010 us=816000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:14 2010 us=816000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:14 2010 us=909000 C:\WINDOWS\system32\route.exe ADD 0.64.4.134 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=941000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:14 2010 us=941000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:14 2010 us=941000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:14 2010 us=987000 C:\WINDOWS\system32\route.exe ADD 0.0.0.0 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:14 2010 us=987000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:14 2010 us=987000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:14 2010 us=987000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:15 2010 us=34000 C:\WINDOWS\system32\route.exe ADD 1.55.79.116 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=50000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:15 2010 us=50000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:15 2010 us=65000 C:\WINDOWS\system32\route.exe ADD 0.71.37.69 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=65000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:15 2010 us=65000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:15 2010 us=81000 C:\WINDOWS\system32\route.exe ADD 34.0.0.3 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=97000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:15 2010 us=97000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:15 2010 us=97000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:15 2010 us=143000 C:\WINDOWS\system32\route.exe ADD 0.0.0.0 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=143000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:15 2010 us=143000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:15 2010 us=143000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:15 2010 us=190000 C:\WINDOWS\system32\route.exe ADD 0.34.245.80 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=206000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:15 2010 us=206000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:15 2010 us=206000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:15 2010 us=253000 C:\WINDOWS\system32\route.exe ADD 0.34.244.192 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=253000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:15 2010 us=253000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:15 2010 us=268000 C:\WINDOWS\system32\route.exe ADD 0.34.244.188 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=268000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:15 2010 us=268000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:15 2010 us=268000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:15 2010 us=315000 C:\WINDOWS\system32\route.exe ADD 0.34.244.152 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=331000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:15 2010 us=331000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:15 2010 us=346000 C:\WINDOWS\system32\route.exe ADD 0.68.143.120 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=346000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:15 2010 us=346000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:15 2010 us=377000 C:\WINDOWS\system32\route.exe ADD 0.34.245.80 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=377000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:15 2010 us=377000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:15 2010 us=377000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:15 2010 us=440000 C:\WINDOWS\system32\route.exe ADD 0.0.0.1 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=440000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:15 2010 us=440000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:15 2010 us=440000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:15 2010 us=487000 C:\WINDOWS\system32\route.exe ADD 0.64.4.134 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=502000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:15 2010 us=502000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:15 2010 us=502000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:15 2010 us=549000 C:\WINDOWS\system32\route.exe ADD 6.216.13.238 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=549000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:15 2010 us=549000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:15 2010 us=565000 C:\WINDOWS\system32\route.exe ADD 0.34.244.140 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=580000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:15 2010 us=580000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:15 2010 us=580000 C:\WINDOWS\system32\route.exe ADD 0.0.48.0 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=596000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:15 2010 us=596000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:15 2010 us=596000 C:\WINDOWS\system32\route.exe ADD 0.0.0.0 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=611000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:15 2010 us=611000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:15 2010 us=611000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:15 2010 us=658000 C:\WINDOWS\system32\route.exe ADD 0.64.4.134 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=658000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:15 2010 us=658000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:15 2010 us=658000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:15 2010 us=705000 C:\WINDOWS\system32\route.exe ADD 0.34.245.80 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=721000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:15 2010 us=721000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:15 2010 us=721000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:15 2010 us=767000 C:\WINDOWS\system32\route.exe ADD 0.34.244.192 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=767000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:15 2010 us=767000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:15 2010 us=767000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:15 2010 us=814000 C:\WINDOWS\system32\route.exe ADD 0.34.244.232 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=830000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:15 2010 us=830000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:15 2010 us=845000 C:\WINDOWS\system32\route.exe ADD 0.64.166.220 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=845000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:15 2010 us=845000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:15 2010 us=861000 C:\WINDOWS\system32\route.exe ADD 0.34.245.80 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=877000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:15 2010 us=877000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:15 2010 us=877000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:15 2010 us=939000 C:\WINDOWS\system32\route.exe ADD 0.34.244.192 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:15 2010 us=970000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:15 2010 us=970000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:15 2010 us=970000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:16 2010 us=17000 C:\WINDOWS\system32\route.exe ADD 0.0.48.0 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=17000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:16 2010 us=17000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:16 2010 us=17000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:16 2010 us=64000 C:\WINDOWS\system32\route.exe ADD 0.0.0.0 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=79000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:16 2010 us=79000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:16 2010 us=79000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:16 2010 us=111000 C:\WINDOWS\system32\route.exe ADD 1.50.13.48 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=142000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:16 2010 us=142000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:16 2010 us=142000 C:\WINDOWS\system32\route.exe ADD 0.34.253.224 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=157000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:16 2010 us=157000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:16 2010 us=173000 C:\WINDOWS\system32\route.exe ADD 0.34.251.228 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=173000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:16 2010 us=173000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:16 2010 us=189000 C:\WINDOWS\system32\route.exe ADD 1.55.79.112 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=189000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:16 2010 us=189000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:16 2010 us=204000 C:\WINDOWS\system32\route.exe ADD 0.0.0.242 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=220000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:16 2010 us=220000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:16 2010 us=220000 C:\WINDOWS\system32\route.exe ADD 0.0.0.0 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=235000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:16 2010 us=235000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:16 2010 us=235000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:16 2010 us=282000 C:\WINDOWS\system32\route.exe ADD 0.0.0.242 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=282000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:16 2010 us=282000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:16 2010 us=282000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:16 2010 us=329000 C:\WINDOWS\system32\route.exe ADD 1.55.79.116 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=345000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:16 2010 us=345000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:16 2010 us=345000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:16 2010 us=391000 C:\WINDOWS\system32\route.exe ADD 1.50.29.24 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=391000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:16 2010 us=391000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:16 2010 us=407000 C:\WINDOWS\system32\route.exe ADD 0.0.0.15 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=423000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:16 2010 us=423000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:16 2010 us=454000 C:\WINDOWS\system32\route.exe ADD 0.0.0.0 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=469000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:16 2010 us=469000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:16 2010 us=469000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:16 2010 us=516000 C:\WINDOWS\system32\route.exe ADD 0.34.245.80 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=532000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:16 2010 us=532000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:16 2010 us=532000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:16 2010 us=579000 C:\WINDOWS\system32\route.exe ADD 0.0.0.0 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=579000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:16 2010 us=579000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:16 2010 us=579000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:16 2010 us=625000 C:\WINDOWS\system32\route.exe ADD 0.0.0.0 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=625000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:16 2010 us=625000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:16 2010 us=625000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:16 2010 us=672000 C:\WINDOWS\system32\route.exe ADD 0.34.245.24 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=688000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:16 2010 us=688000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:16 2010 us=703000 C:\WINDOWS\system32\route.exe ADD 0.64.205.124 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=703000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:16 2010 us=703000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:16 2010 us=719000 C:\WINDOWS\system32\route.exe ADD 0.34.245.80 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=735000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:16 2010 us=735000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:16 2010 us=735000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:16 2010 us=781000 C:\WINDOWS\system32\route.exe ADD 0.0.0.0 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=781000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:16 2010 us=781000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:16 2010 us=781000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:16 2010 us=828000 C:\WINDOWS\system32\route.exe ADD 0.34.245.24 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=844000 ROUTE: route addition failed using CreateIpForwardEntry: The object already exists.   [status=5010 if_index=11]
Mon Oct 18 17:38:16 2010 us=844000 Route addition via IPAPI failed [adaptive]
Mon Oct 18 17:38:16 2010 us=844000 Route addition fallback to route.exe
The route addition failed: The object already exists.
Mon Oct 18 17:38:16 2010 us=891000 C:\WINDOWS\system32\route.exe ADD 0.64.214.67 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=891000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:16 2010 us=906000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:16 2010 us=906000 C:\WINDOWS\system32\route.exe ADD 1.53.128.192 MASK 255.255.255.255 192.168.0.1
Mon Oct 18 17:38:16 2010 us=922000 ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=20 and dwForwardType=4
Mon Oct 18 17:38:16 2010 us=922000 Route addition via IPAPI succeeded [adaptive]
Mon Oct 18 17:38:16 2010 us=922000 Initialization Sequence Completed

--------------050503030208010603050102--

