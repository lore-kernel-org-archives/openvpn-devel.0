References: <f7687ebf-a75f-095d-67ca-e32a5c4e53e7@...515...>
	<41c0e750-b27e-22ea-d5fb-b17fe391636d@...1147...>
	<689096e2-8bb8-95b8-5daf-22fd600a00ca@...515...>
	<da7671c8-6768-f718-79a0-996cdb0d8d87@...1147...>
	<82ec1478-ec53-3980-05b1-4529a74aa789@...1147...>
	<20170717121451.GQ70062@...1296...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <a3d45ab2-63e9-2849-6118-775a8f43ec87@...1147...>
Date: Mon, 17 Jul 2017 14:22:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170717121451.GQ70062@...1296...>
Content-Type: multipart/mixed; boundary="------------9F48D07056CD24E1CB9D3CA0"
Content-Language: en-US
Subject: Re: [Openvpn-devel] Windows installer with updated pkcs11-helper
 (1.22) available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------9F48D07056CD24E1CB9D3CA0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 17/07/17 14:14, Gert Doering wrote:
> Hi,
>
> On Mon, Jul 17, 2017 at 02:10:11PM +0200, Jan Just Keijser wrote:
>> this problem is NOT present in OpenVPN 2.3.17; the same warning appears (route gateway is ambiguous) but the route is added
>> anyway. This seems to be a regression in 2.4.
> Can we have a log, please?
>
>
attached: config and log (with hostnames anonymized)

JJK


--------------9F48D07056CD24E1CB9D3CA0
Content-Type: text/x-log;
 name="nikhef-udp-pkcs11.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nikhef-udp-pkcs11.log"

Mon Jul 17 14:18:33 2017 us=360410 Current Parameter Settings:
Mon Jul 17 14:18:33 2017 us=360410   config = 'nikhef-udp-pkcs11.ovpn'
Mon Jul 17 14:18:33 2017 us=360410   mode = 0
Mon Jul 17 14:18:33 2017 us=360410   show_ciphers = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   show_digests = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   show_engines = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   genkey = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   key_pass_file = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   show_tls_ciphers = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   connect_retry_max = 0
Mon Jul 17 14:18:33 2017 us=360410 Connection profiles [0]:
Mon Jul 17 14:18:33 2017 us=360410   proto = udp
Mon Jul 17 14:18:33 2017 us=360410   local = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   local_port = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   remote = 'vpnserver'
Mon Jul 17 14:18:33 2017 us=360410   remote_port = '1194'
Mon Jul 17 14:18:33 2017 us=360410   remote_float = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   bind_defined = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   bind_local = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   bind_ipv6_only = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   connect_retry_seconds = 5
Mon Jul 17 14:18:33 2017 us=360410   connect_timeout = 120
Mon Jul 17 14:18:33 2017 us=360410   socks_proxy_server = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   socks_proxy_port = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   tun_mtu = 1500
Mon Jul 17 14:18:33 2017 us=360410   tun_mtu_defined = ENABLED
Mon Jul 17 14:18:33 2017 us=360410   link_mtu = 1500
Mon Jul 17 14:18:33 2017 us=360410   link_mtu_defined = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   tun_mtu_extra = 0
Mon Jul 17 14:18:33 2017 us=360410   tun_mtu_extra_defined = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   mtu_discover_type = -1
Mon Jul 17 14:18:33 2017 us=360410   fragment = 0
Mon Jul 17 14:18:33 2017 us=360410   mssfix = 1450
Mon Jul 17 14:18:33 2017 us=360410   explicit_exit_notification = 0
Mon Jul 17 14:18:33 2017 us=360410 Connection profiles END
Mon Jul 17 14:18:33 2017 us=360410   remote_random = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   ipchange = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   dev = 'tun'
Mon Jul 17 14:18:33 2017 us=360410   dev_type = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   dev_node = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   lladdr = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   topology = 1
Mon Jul 17 14:18:33 2017 us=360410   ifconfig_local = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   ifconfig_remote_netmask = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   ifconfig_noexec = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   ifconfig_nowarn = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   ifconfig_ipv6_local = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   ifconfig_ipv6_netbits = 0
Mon Jul 17 14:18:33 2017 us=360410   ifconfig_ipv6_remote = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   shaper = 0
Mon Jul 17 14:18:33 2017 us=360410   mtu_test = 0
Mon Jul 17 14:18:33 2017 us=360410   mlock = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   keepalive_ping = 0
Mon Jul 17 14:18:33 2017 us=360410   keepalive_timeout = 0
Mon Jul 17 14:18:33 2017 us=360410   inactivity_timeout = 0
Mon Jul 17 14:18:33 2017 us=360410   ping_send_timeout = 0
Mon Jul 17 14:18:33 2017 us=360410   ping_rec_timeout = 0
Mon Jul 17 14:18:33 2017 us=360410   ping_rec_timeout_action = 0
Mon Jul 17 14:18:33 2017 us=360410   ping_timer_remote = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   remap_sigusr1 = 0
Mon Jul 17 14:18:33 2017 us=360410   persist_tun = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   persist_local_ip = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   persist_remote_ip = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   persist_key = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   passtos = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   resolve_retry_seconds = 1000000000
Mon Jul 17 14:18:33 2017 us=360410   resolve_in_advance = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   username = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   groupname = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   chroot_dir = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   cd_dir = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   writepid = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   up_script = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   down_script = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   down_pre = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   up_restart = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   up_delay = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   daemon = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   inetd = 0
Mon Jul 17 14:18:33 2017 us=360410   log = ENABLED
Mon Jul 17 14:18:33 2017 us=360410   suppress_timestamps = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   machine_readable_output = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   nice = 0
Mon Jul 17 14:18:33 2017 us=360410   verbosity = 5
Mon Jul 17 14:18:33 2017 us=360410   mute = 0
Mon Jul 17 14:18:33 2017 us=360410   gremlin = 0
Mon Jul 17 14:18:33 2017 us=360410   status_file = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   status_file_version = 1
Mon Jul 17 14:18:33 2017 us=360410   status_file_update_freq = 60
Mon Jul 17 14:18:33 2017 us=360410   occ = ENABLED
Mon Jul 17 14:18:33 2017 us=360410   rcvbuf = 0
Mon Jul 17 14:18:33 2017 us=360410   sndbuf = 0
Mon Jul 17 14:18:33 2017 us=360410   sockflags = 0
Mon Jul 17 14:18:33 2017 us=360410   fast_io = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   comp.alg = 2
Mon Jul 17 14:18:33 2017 us=360410   comp.flags = 1
Mon Jul 17 14:18:33 2017 us=360410   route_script = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   route_default_gateway = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   route_default_metric = 0
Mon Jul 17 14:18:33 2017 us=360410   route_noexec = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   route_delay = 5
Mon Jul 17 14:18:33 2017 us=360410   route_delay_window = 30
Mon Jul 17 14:18:33 2017 us=360410   route_delay_defined = ENABLED
Mon Jul 17 14:18:33 2017 us=360410   route_nopull = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   route_gateway_via_dhcp = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   allow_pull_fqdn = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   [redirect_default_gateway local=0]
Mon Jul 17 14:18:33 2017 us=360410   management_addr = '127.0.0.1'
Mon Jul 17 14:18:33 2017 us=360410   management_port = '25340'
Mon Jul 17 14:18:33 2017 us=360410   management_user_pass = 'stdin'
Mon Jul 17 14:18:33 2017 us=360410   management_log_history_cache = 250
Mon Jul 17 14:18:33 2017 us=360410   management_echo_buffer_size = 100
Mon Jul 17 14:18:33 2017 us=360410   management_write_peer_info_file = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   management_client_user = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   management_client_group = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   management_flags = 6
Mon Jul 17 14:18:33 2017 us=360410   shared_secret_file = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   key_direction = 0
Mon Jul 17 14:18:33 2017 us=360410   ciphername = 'BF-CBC'
Mon Jul 17 14:18:33 2017 us=360410   ncp_enabled = ENABLED
Mon Jul 17 14:18:33 2017 us=360410   ncp_ciphers = 'AES-256-GCM:AES-128-GCM'
Mon Jul 17 14:18:33 2017 us=360410   authname = 'SHA1'
Mon Jul 17 14:18:33 2017 us=360410   prng_hash = 'SHA1'
Mon Jul 17 14:18:33 2017 us=360410   prng_nonce_secret_len = 16
Mon Jul 17 14:18:33 2017 us=360410   keysize = 0
Mon Jul 17 14:18:33 2017 us=360410   engine = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   replay = ENABLED
Mon Jul 17 14:18:33 2017 us=360410   mute_replay_warnings = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   replay_window = 64
Mon Jul 17 14:18:33 2017 us=360410   replay_time = 15
Mon Jul 17 14:18:33 2017 us=360410   packet_id_file = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   use_iv = ENABLED
Mon Jul 17 14:18:33 2017 us=360410   test_crypto = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   tls_server = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   tls_client = ENABLED
Mon Jul 17 14:18:33 2017 us=360410   key_method = 2
Mon Jul 17 14:18:33 2017 us=360410   ca_file = 'digicert.pem'
Mon Jul 17 14:18:33 2017 us=360410   ca_path = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   dh_file = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   cert_file = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   extra_certs_file = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   priv_key_file = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   pkcs12_file = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   cryptoapi_cert = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   cipher_list = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   tls_verify = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   tls_export_cert = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   verify_x509_type = 0
Mon Jul 17 14:18:33 2017 us=360410   verify_x509_name = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   crl_file = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   ns_cert_type = 0
Mon Jul 17 14:18:33 2017 us=360410   remote_cert_ku[i] = 65535
Mon Jul 17 14:18:33 2017 us=360410   remote_cert_ku[i] = 0
Mon Jul 17 14:18:33 2017 us=360410   remote_cert_ku[i] = 0
Mon Jul 17 14:18:33 2017 us=360410   remote_cert_ku[i] = 0
Mon Jul 17 14:18:33 2017 us=360410   remote_cert_ku[i] = 0
Mon Jul 17 14:18:33 2017 us=360410   remote_cert_ku[i] = 0
Mon Jul 17 14:18:33 2017 us=360410   remote_cert_ku[i] = 0
Mon Jul 17 14:18:33 2017 us=360410   remote_cert_ku[i] = 0
Mon Jul 17 14:18:33 2017 us=360410   remote_cert_ku[i] = 0
Mon Jul 17 14:18:33 2017 us=360410   remote_cert_ku[i] = 0
Mon Jul 17 14:18:33 2017 us=360410   remote_cert_ku[i] = 0
Mon Jul 17 14:18:33 2017 us=360410   remote_cert_ku[i] = 0
Mon Jul 17 14:18:33 2017 us=360410   remote_cert_ku[i] = 0
Mon Jul 17 14:18:33 2017 us=360410   remote_cert_ku[i] = 0
Mon Jul 17 14:18:33 2017 us=360410   remote_cert_ku[i] = 0
Mon Jul 17 14:18:33 2017 us=360410   remote_cert_ku[i] = 0
Mon Jul 17 14:18:33 2017 us=360410   remote_cert_eku = 'TLS Web Server Authentication'
Mon Jul 17 14:18:33 2017 us=360410   ssl_flags = 0
Mon Jul 17 14:18:33 2017 us=360410   tls_timeout = 2
Mon Jul 17 14:18:33 2017 us=360410   renegotiate_bytes = -1
Mon Jul 17 14:18:33 2017 us=360410   renegotiate_packets = 0
Mon Jul 17 14:18:33 2017 us=360410   renegotiate_seconds = 3600
Mon Jul 17 14:18:33 2017 us=360410   handshake_window = 60
Mon Jul 17 14:18:33 2017 us=360410   transition_window = 3600
Mon Jul 17 14:18:33 2017 us=360410   single_session = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   push_peer_info = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   tls_exit = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   tls_auth_file = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   tls_crypt_file = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_providers = eTPkcs11.dll
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_protected_authentication = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_protected_authentication = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_protected_authentication = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_protected_authentication = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_protected_authentication = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_protected_authentication = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_protected_authentication = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_protected_authentication = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_protected_authentication = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_protected_authentication = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_protected_authentication = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_protected_authentication = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_protected_authentication = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_protected_authentication = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_protected_authentication = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_protected_authentication = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_private_mode = 00000000
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_private_mode = 00000000
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_private_mode = 00000000
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_private_mode = 00000000
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_private_mode = 00000000
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_private_mode = 00000000
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_private_mode = 00000000
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_private_mode = 00000000
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_private_mode = 00000000
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_private_mode = 00000000
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_private_mode = 00000000
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_private_mode = 00000000
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_private_mode = 00000000
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_private_mode = 00000000
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_private_mode = 00000000
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_private_mode = 00000000
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_cert_private = ENABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_cert_private = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_cert_private = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_cert_private = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_cert_private = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_cert_private = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_cert_private = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_cert_private = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_cert_private = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_cert_private = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_cert_private = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_cert_private = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_cert_private = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_cert_private = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_cert_private = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_cert_private = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_pin_cache_period = -1
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_id = 'SafeNet\x2C\x20Inc\x2E/eToken/00a3659c/Jan\x20Just/36343132443132424330433945434336'
Mon Jul 17 14:18:33 2017 us=360410   pkcs11_id_management = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   server_network = 0.0.0.0
Mon Jul 17 14:18:33 2017 us=360410   server_netmask = 0.0.0.0
Mon Jul 17 14:18:33 2017 us=360410   server_network_ipv6 = ::
Mon Jul 17 14:18:33 2017 us=360410   server_netbits_ipv6 = 0
Mon Jul 17 14:18:33 2017 us=360410   server_bridge_ip = 0.0.0.0
Mon Jul 17 14:18:33 2017 us=360410   server_bridge_netmask = 0.0.0.0
Mon Jul 17 14:18:33 2017 us=360410   server_bridge_pool_start = 0.0.0.0
Mon Jul 17 14:18:33 2017 us=360410   server_bridge_pool_end = 0.0.0.0
Mon Jul 17 14:18:33 2017 us=360410   ifconfig_pool_defined = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   ifconfig_pool_start = 0.0.0.0
Mon Jul 17 14:18:33 2017 us=360410   ifconfig_pool_end = 0.0.0.0
Mon Jul 17 14:18:33 2017 us=360410   ifconfig_pool_netmask = 0.0.0.0
Mon Jul 17 14:18:33 2017 us=360410   ifconfig_pool_persist_filename = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   ifconfig_pool_persist_refresh_freq = 600
Mon Jul 17 14:18:33 2017 us=360410   ifconfig_ipv6_pool_defined = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   ifconfig_ipv6_pool_base = ::
Mon Jul 17 14:18:33 2017 us=360410   ifconfig_ipv6_pool_netbits = 0
Mon Jul 17 14:18:33 2017 us=360410   n_bcast_buf = 256
Mon Jul 17 14:18:33 2017 us=360410   tcp_queue_limit = 64
Mon Jul 17 14:18:33 2017 us=360410   real_hash_size = 256
Mon Jul 17 14:18:33 2017 us=360410   virtual_hash_size = 256
Mon Jul 17 14:18:33 2017 us=360410   client_connect_script = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   learn_address_script = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   client_disconnect_script = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   client_config_dir = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   ccd_exclusive = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   tmp_dir = 'C:\TEMP\'
Mon Jul 17 14:18:33 2017 us=360410   push_ifconfig_defined = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   push_ifconfig_local = 0.0.0.0
Mon Jul 17 14:18:33 2017 us=360410   push_ifconfig_remote_netmask = 0.0.0.0
Mon Jul 17 14:18:33 2017 us=360410   push_ifconfig_ipv6_defined = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   push_ifconfig_ipv6_local = ::/0
Mon Jul 17 14:18:33 2017 us=360410   push_ifconfig_ipv6_remote = ::
Mon Jul 17 14:18:33 2017 us=360410   enable_c2c = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   duplicate_cn = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   cf_max = 0
Mon Jul 17 14:18:33 2017 us=360410   cf_per = 0
Mon Jul 17 14:18:33 2017 us=360410   max_clients = 1024
Mon Jul 17 14:18:33 2017 us=360410   max_routes_per_client = 256
Mon Jul 17 14:18:33 2017 us=360410   auth_user_pass_verify_script = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   auth_user_pass_verify_script_via_file = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   auth_token_generate = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   auth_token_lifetime = 0
Mon Jul 17 14:18:33 2017 us=360410   client = ENABLED
Mon Jul 17 14:18:33 2017 us=360410   pull = ENABLED
Mon Jul 17 14:18:33 2017 us=360410   auth_user_pass_file = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   show_net_up = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   route_method = 3
Mon Jul 17 14:18:33 2017 us=360410   block_outside_dns = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   ip_win32_defined = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   ip_win32_type = 3
Mon Jul 17 14:18:33 2017 us=360410   dhcp_masq_offset = 0
Mon Jul 17 14:18:33 2017 us=360410   dhcp_lease_time = 31536000
Mon Jul 17 14:18:33 2017 us=360410   tap_sleep = 0
Mon Jul 17 14:18:33 2017 us=360410   dhcp_options = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   dhcp_renew = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   dhcp_pre_release = DISABLED
Mon Jul 17 14:18:33 2017 us=360410   domain = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   netbios_scope = '[UNDEF]'
Mon Jul 17 14:18:33 2017 us=360410   netbios_node_type = 0
Mon Jul 17 14:18:33 2017 us=360410   disable_nbt = DISABLED
Mon Jul 17 14:18:33 2017 us=360410 OpenVPN 2.4.3 x86_64-w64-mingw32 [SSL (OpenSSL)] [LZO] [LZ4] [PKCS11] [AEAD] built on Jul 14 2017
Mon Jul 17 14:18:33 2017 us=360410 Windows version 6.1 (Windows 7) 64bit
Mon Jul 17 14:18:33 2017 us=360410 library versions: OpenSSL 1.0.2l  25 May 2017, LZO 2.10
Enter Management Password:
Mon Jul 17 14:18:33 2017 us=360410 MANAGEMENT: TCP Socket listening on [AF_INET]127.0.0.1:25340
Mon Jul 17 14:18:33 2017 us=360410 Need hold release from management interface, waiting...
Mon Jul 17 14:18:33 2017 us=875211 MANAGEMENT: Client connected from [AF_INET]127.0.0.1:25340
Mon Jul 17 14:18:33 2017 us=984411 MANAGEMENT: CMD 'state on'
Mon Jul 17 14:18:33 2017 us=984411 MANAGEMENT: CMD 'log all on'
Mon Jul 17 14:18:34 2017 us=78012 MANAGEMENT: CMD 'echo all on'
Mon Jul 17 14:18:34 2017 us=78012 MANAGEMENT: CMD 'hold off'
Mon Jul 17 14:18:34 2017 us=78012 MANAGEMENT: CMD 'hold release'
Mon Jul 17 14:18:34 2017 us=78012 PKCS#11: Adding PKCS#11 provider 'eTPkcs11.dll'
Mon Jul 17 14:18:36 2017 us=948417 MANAGEMENT: CMD 'password [...]'
Mon Jul 17 14:18:36 2017 us=995217 LZO compression initializing
Mon Jul 17 14:18:36 2017 us=995217 Control Channel MTU parms [ L:1622 D:1212 EF:38 EB:0 ET:0 EL:3 ]
Mon Jul 17 14:18:36 2017 us=995217 MANAGEMENT: >STATE:1500293916,RESOLVE,,,,,,
Mon Jul 17 14:18:36 2017 us=995217 Data Channel MTU parms [ L:1622 D:1450 EF:122 EB:406 ET:0 EL:3 ]
Mon Jul 17 14:18:36 2017 us=995217 Local Options String (VER=V4): 'V4,dev-type tun,link-mtu 1542,tun-mtu 1500,proto UDPv4,comp-lzo,cipher BF-CBC,auth SHA1,keysize 128,key-method 2,tls-client'
Mon Jul 17 14:18:36 2017 us=995217 Expected Remote Options String (VER=V4): 'V4,dev-type tun,link-mtu 1542,tun-mtu 1500,proto UDPv4,comp-lzo,cipher BF-CBC,auth SHA1,keysize 128,key-method 2,tls-server'
Mon Jul 17 14:18:36 2017 us=995217 TCP/UDP: Preserving recently used remote address: [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:36 2017 us=995217 Socket Buffers: R=[8192->8192] S=[8192->8192]
Mon Jul 17 14:18:36 2017 us=995217 UDP link local: (not bound)
Mon Jul 17 14:18:36 2017 us=995217 UDP link remote: [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:36 2017 us=995217 MANAGEMENT: >STATE:1500293916,WAIT,,,,,,
Mon Jul 17 14:18:37 2017 us=10817 MANAGEMENT: >STATE:1500293917,AUTH,,,,,,
Mon Jul 17 14:18:37 2017 us=10817 TLS: Initial packet from [AF_INET]222.222.97.13:1194, sid=64c40702 59cc6324
Mon Jul 17 14:18:37 2017 us=10817 VERIFY OK: depth=2, C=US, O=DigiCert Inc, OU=www.digicert.com, CN=DigiCert Assured ID Root CA
Mon Jul 17 14:18:37 2017 us=10817 VERIFY OK: depth=1, C=NL, ST=Noord-Holland, L=Amsterdam, O=TERENA, CN=TERENA SSL CA 3
Mon Jul 17 14:18:37 2017 us=10817 VERIFY KU OK
Mon Jul 17 14:18:37 2017 us=10817 Validating certificate extended key usage
Mon Jul 17 14:18:37 2017 us=10817 ++ Certificate has EKU (str) TLS Web Server Authentication, expects TLS Web Server Authentication
Mon Jul 17 14:18:37 2017 us=10817 VERIFY EKU OK
Mon Jul 17 14:18:37 2017 us=10817 VERIFY OK: depth=0, C=NL, ST=Noord-Holland, L=Amsterdam, O=Nikhef, CN=vpnserver
Mon Jul 17 14:18:37 2017 us=385217 Control Channel: TLSv1.2, cipher TLSv1/SSLv3 DHE-RSA-AES256-GCM-SHA384, 2048 bit RSA
Mon Jul 17 14:18:37 2017 us=385217 [vpnserver] Peer Connection Initiated with [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:38 2017 us=446019 MANAGEMENT: >STATE:1500293918,GET_CONFIG,,,,,,
Mon Jul 17 14:18:38 2017 us=446019 SENT CONTROL [vpnserver]: 'PUSH_REQUEST' (status=1)
Mon Jul 17 14:18:38 2017 us=446019 PUSH: Received control message: 'PUSH_REPLY,ifconfig-ipv6 2001:610:120:e034::1002/64 2001:610:120:e034::1,route 222.222.97.13 255.255.255.255 net_gateway,dhcp-option DISABLE-NBT,dhcp-option DNS 222.222.97.228,dhcp-option DOMAIN nikhef.nl,tun-ipv6,route 10.200.0.1,topology net30,ping 10,ping-restart 120,ifconfig 10.200.0.14 10.200.0.13'
Mon Jul 17 14:18:38 2017 us=446019 Note: option tun-ipv6 is ignored because modern operating systems do not need special IPv6 tun handling anymore.
Mon Jul 17 14:18:38 2017 us=446019 OPTIONS IMPORT: timers and/or timeouts modified
Mon Jul 17 14:18:38 2017 us=446019 OPTIONS IMPORT: --ifconfig/up options modified
Mon Jul 17 14:18:38 2017 us=446019 OPTIONS IMPORT: route options modified
Mon Jul 17 14:18:38 2017 us=446019 OPTIONS IMPORT: --ip-win32 and/or --dhcp-option options modified
Mon Jul 17 14:18:38 2017 us=446019 Data Channel MTU parms [ L:1542 D:1450 EF:42 EB:406 ET:0 EL:3 ]
Mon Jul 17 14:18:38 2017 us=446019 Data Channel Encrypt: Cipher 'BF-CBC' initialized with 128 bit key
Mon Jul 17 14:18:38 2017 us=446019 WARNING: INSECURE cipher with block size less than 128 bit (64 bit).  This allows attacks like SWEET32.  Mitigate by using a --cipher with a larger block size (e.g. AES-256-CBC).
Mon Jul 17 14:18:38 2017 us=446019 Data Channel Encrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Mon Jul 17 14:18:38 2017 us=446019 Data Channel Decrypt: Cipher 'BF-CBC' initialized with 128 bit key
Mon Jul 17 14:18:38 2017 us=446019 WARNING: INSECURE cipher with block size less than 128 bit (64 bit).  This allows attacks like SWEET32.  Mitigate by using a --cipher with a larger block size (e.g. AES-256-CBC).
Mon Jul 17 14:18:38 2017 us=446019 Data Channel Decrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Mon Jul 17 14:18:38 2017 us=446019 WARNING: cipher with small block size in use, reducing reneg-bytes to 64MB to mitigate SWEET32 attacks.
Mon Jul 17 14:18:38 2017 us=446019 interactive service msg_channel=404
Mon Jul 17 14:18:38 2017 us=446019 ROUTE_GATEWAY 111.111.135.254/255.255.252.0 I=23 HWADDR=80:19:34:57:3e:9c
Mon Jul 17 14:18:38 2017 us=492819 open_tun
Mon Jul 17 14:18:38 2017 us=492819 TAP-WIN32 device [vpn0] opened: \\.\Global\{0A98E2CD-E31A-4D47-B5EF-03F98D3A49FB}.tap
Mon Jul 17 14:18:38 2017 us=492819 TAP-Windows Driver Version 9.21 
Mon Jul 17 14:18:38 2017 us=492819 TAP-Windows MTU=1500
Mon Jul 17 14:18:38 2017 us=492819 Notified TAP-Windows driver to set a DHCP IP/netmask of 10.200.0.14/255.255.255.252 on interface {0A98E2CD-E31A-4D47-B5EF-03F98D3A49FB} [DHCP-serv: 10.200.0.13, lease-time: 31536000]
Mon Jul 17 14:18:38 2017 us=492819 DHCP option string: 0f096e69 6b686566 2e6e6c06 04c2ab61 e42b0601 04000000 02
Mon Jul 17 14:18:38 2017 us=492819 Successful ARP Flush on interface [17] {0A98E2CD-E31A-4D47-B5EF-03F98D3A49FB}
Mon Jul 17 14:18:38 2017 us=492819 do_ifconfig, tt->did_ifconfig_ipv6_setup=1
Mon Jul 17 14:18:38 2017 us=492819 MANAGEMENT: >STATE:1500293918,ASSIGN_IP,,10.200.0.14,,,,,2001:610:120:e034::1002
Mon Jul 17 14:18:38 2017 us=492819 add_route_ipv6(2001:610:120:e034::/64 -> 2001:610:120:e034::1002 metric 0) dev vpn0
Mon Jul 17 14:18:38 2017 us=492819 IPv6 route addition via service succeeded
Mon Jul 17 14:18:43 2017 us=1227 TEST ROUTES: 3/3 succeeded len=2 ret=1 a=1 u/d=up
Mon Jul 17 14:18:43 2017 us=1227 C:\Windows\system32\route.exe ADD 222.222.97.13 MASK 255.255.255.255 111.111.135.254
Mon Jul 17 14:18:43 2017 us=1227 Warning: route gateway is ambiguous: 111.111.135.254 (2 matches)
Mon Jul 17 14:18:43 2017 us=1227 Route addition via service failed
Mon Jul 17 14:18:43 2017 us=1227 C:\Windows\system32\route.exe ADD 0.0.0.0 MASK 128.0.0.0 10.200.0.13
Mon Jul 17 14:18:43 2017 us=16827 Route addition via service succeeded
Mon Jul 17 14:18:43 2017 us=16827 C:\Windows\system32\route.exe ADD 128.0.0.0 MASK 128.0.0.0 10.200.0.13
Mon Jul 17 14:18:43 2017 us=16827 Route addition via service succeeded
Mon Jul 17 14:18:43 2017 us=16827 MANAGEMENT: >STATE:1500293923,ADD_ROUTES,,,,,,
Mon Jul 17 14:18:43 2017 us=16827 C:\Windows\system32\route.exe ADD 222.222.97.13 MASK 255.255.255.255 111.111.135.254
Mon Jul 17 14:18:43 2017 us=16827 Warning: route gateway is ambiguous: 111.111.135.254 (2 matches)
Mon Jul 17 14:18:43 2017 us=16827 Route addition via service failed
Mon Jul 17 14:18:43 2017 us=16827 C:\Windows\system32\route.exe ADD 10.200.0.1 MASK 255.255.255.255 10.200.0.13
Mon Jul 17 14:18:43 2017 us=16827 Route addition via service succeeded
Mon Jul 17 14:18:43 2017 us=16827 WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this
Mon Jul 17 14:18:43 2017 us=16827 Initialization Sequence Completed
Mon Jul 17 14:18:43 2017 us=16827 MANAGEMENT: >STATE:1500293923,CONNECTED,SUCCESS,10.200.0.14,222.222.97.13,1194,,,2001:610:120:e034::1002
Mon Jul 17 14:18:43 2017 us=16827 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:44 2017 us=108829 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:44 2017 us=842030 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:44 2017 us=873231 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:45 2017 us=122831 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:45 2017 us=122831 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:46 2017 us=994834 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:47 2017 us=135235 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:47 2017 us=135235 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:47 2017 us=915236 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:47 2017 us=946436 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:51 2017 us=35241 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:51 2017 us=144442 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:51 2017 us=253642 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:52 2017 us=49243 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:53 2017 us=593646 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:53 2017 us=749646 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:54 2017 us=61647 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:54 2017 us=607648 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:54 2017 us=763648 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:56 2017 us=620051 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:56 2017 us=776051 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:18:58 2017 us=70854 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:00 2017 us=629258 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:00 2017 us=629258 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:00 2017 us=644858 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:00 2017 us=785258 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:00 2017 us=894459 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:01 2017 us=643260 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:01 2017 us=643260 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:01 2017 us=658860 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:02 2017 us=657262 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:02 2017 us=657262 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:03 2017 us=390463 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:03 2017 us=671264 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:04 2017 us=404465 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:04 2017 us=669665 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:04 2017 us=669665 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:06 2017 us=73668 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:06 2017 us=416868 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:07 2017 us=680471 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:07 2017 us=680471 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:07 2017 us=696071 Recursive routing detected, drop tun packet to [AF_INET]222.222.97.13:1194
Mon Jul 17 14:19:07 2017 us=914471 TCP/UDP: Closing socket
Mon Jul 17 14:19:07 2017 us=914471 C:\Windows\system32\route.exe DELETE 10.200.0.1 MASK 255.255.255.255 10.200.0.13
Mon Jul 17 14:19:07 2017 us=914471 Route deletion via service succeeded
Mon Jul 17 14:19:07 2017 us=914471 C:\Windows\system32\route.exe DELETE 222.222.97.13 MASK 255.255.255.255 111.111.135.254
Mon Jul 17 14:19:07 2017 us=914471 Warning: route gateway is ambiguous: 111.111.135.254 (2 matches)
Mon Jul 17 14:19:07 2017 us=914471 Route deletion via service failed
Mon Jul 17 14:19:07 2017 us=914471 C:\Windows\system32\route.exe DELETE 0.0.0.0 MASK 128.0.0.0 10.200.0.13
Mon Jul 17 14:19:07 2017 us=930071 Route deletion via service succeeded
Mon Jul 17 14:19:07 2017 us=930071 C:\Windows\system32\route.exe DELETE 128.0.0.0 MASK 128.0.0.0 10.200.0.13
Mon Jul 17 14:19:07 2017 us=930071 Route deletion via service succeeded
Mon Jul 17 14:19:07 2017 us=930071 Closing TUN/TAP interface
Mon Jul 17 14:19:07 2017 us=961271 TAP: DHCP address released
Mon Jul 17 14:19:07 2017 us=961271 SIGTERM[hard,] received, process exiting
Mon Jul 17 14:19:07 2017 us=961271 MANAGEMENT: >STATE:1500293947,EXITING,SIGTERM,,,,,
WRWWRWRWRWRWWRRWRWWRRWrWrWrWrWrWrWrWrWrWrWrWrWrWrWrWrWrWrWrWrWrWrWrWrWrWrWrWrrWrrWrrWrrWrWrrrWrrWrWrrrWrrWrRrWrrWrrWrrWrrWrrWrrWrrWrrWrrWrrWrrWrRrWrWrrrWrrWrrWrrWrWrrrWrrWrWrrrWrrWrrWrrWrWrrrWrrWrrWrWrrrWr

--------------9F48D07056CD24E1CB9D3CA0
Content-Type: text/plain; charset=UTF-8;
 name="nikhef-udp-pkcs11.ovpn"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nikhef-udp-pkcs11.ovpn"

client
proto udp
remote vpnserver
port 1194
dev tun
nobind

remote-cert-tls server
ca       digicert.pem

pkcs11-providers eTPkcs11.dll
pkcs11-id 'SafeNet\x2C\x20Inc\x2E/eToken/00a3659c/Jan\x20Just/36343132443132424330433945434336'
pkcs11-cert-private 1

verb 5

comp-lzo
redirect-gateway def1

--------------9F48D07056CD24E1CB9D3CA0--

