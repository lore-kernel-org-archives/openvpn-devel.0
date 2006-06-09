Mime-Version: 1.0 (Apple Message framework v750)
Message-Id: <625181F3-2C96-4581-8559-E9C38C6743E6@...663...>
From: =?ISO-8859-1?Q?"G=E1bor_B=E9rczi_=28Gabucino=29"?= <gabor@...663...>
Date: Fri, 9 Jun 2006 15:44:46 +0200
Subject: [Openvpn-devel] OpenVPN on Digital OSF/1 v4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"; delsp=yes; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

I'm trying to get $subject alive. The necessary support for the OSF/1=20=20
ifconfig was created, but I'm stuck now, because OpenVPN bails out=20=20
with the following message upon client connection:

Fri Jun  9 15:35:45 2006 us=3D922320 Current Parameter Settings:
Fri Jun  9 15:35:45 2006 us=3D934032   config =3D '/usr/pkg/etc/openvpn/=20
openvpn.conf'
Fri Jun  9 15:35:45 2006 us=3D935008   mode =3D 1
Fri Jun  9 15:35:45 2006 us=3D935008   show_ciphers =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D935984   show_digests =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D935984   show_engines =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D936960   genkey =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D936960   key_pass_file =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D936960   show_tls_ciphers =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D937936   proto =3D 1
Fri Jun  9 15:35:45 2006 us=3D937936   local =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D938912   remote_list =3D NULL
Fri Jun  9 15:35:45 2006 us=3D938912   remote_random =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D938912   local_port =3D 995
Fri Jun  9 15:35:45 2006 us=3D939888   remote_port =3D 995
Fri Jun  9 15:35:45 2006 us=3D939888   remote_float =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D940864   ipchange =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D940864   bind_local =3D ENABLED
Fri Jun  9 15:35:45 2006 us=3D941840   dev =3D 'tap'
Fri Jun  9 15:35:45 2006 us=3D941840   dev_type =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D942816   dev_node =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D942816   tun_ipv6 =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D943792   ifconfig_local =3D '10.0.98.1'
Fri Jun  9 15:35:45 2006 us=3D943792   ifconfig_remote_netmask =3D=20=20
'255.255.255.0'
Fri Jun  9 15:35:45 2006 us=3D943792   ifconfig_noexec =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D944768   ifconfig_nowarn =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D944768   shaper =3D 0
Fri Jun  9 15:35:45 2006 us=3D945744   tun_mtu =3D 1500
Fri Jun  9 15:35:45 2006 us=3D945744   tun_mtu_defined =3D ENABLED
Fri Jun  9 15:35:45 2006 us=3D945744   link_mtu =3D 1500
Fri Jun  9 15:35:45 2006 us=3D946720   link_mtu_defined =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D946720   tun_mtu_extra =3D 32
Fri Jun  9 15:35:45 2006 us=3D947696   tun_mtu_extra_defined =3D ENABLED
Fri Jun  9 15:35:45 2006 us=3D947696   fragment =3D 0
Fri Jun  9 15:35:45 2006 us=3D948672   mtu_discover_type =3D -1
Fri Jun  9 15:35:45 2006 us=3D948672   mtu_test =3D 0
Fri Jun  9 15:35:45 2006 us=3D949648   mlock =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D949648   keepalive_ping =3D 0
Fri Jun  9 15:35:45 2006 us=3D949648   keepalive_timeout =3D 0
Fri Jun  9 15:35:45 2006 us=3D950624   inactivity_timeout =3D 0
Fri Jun  9 15:35:45 2006 us=3D950624   ping_send_timeout =3D 0
Fri Jun  9 15:35:45 2006 us=3D951600   ping_rec_timeout =3D 0
Fri Jun  9 15:35:45 2006 us=3D951600   ping_rec_timeout_action =3D 0
Fri Jun  9 15:35:45 2006 us=3D951600   ping_timer_remote =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D952576   remap_sigusr1 =3D 0
Fri Jun  9 15:35:45 2006 us=3D952576   explicit_exit_notification =3D 0
Fri Jun  9 15:35:45 2006 us=3D953552   persist_tun =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D953552   persist_local_ip =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D954528   persist_remote_ip =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D954528   persist_key =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D954528   mssfix =3D 1450
Fri Jun  9 15:35:45 2006 us=3D955504   passtos =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D955504   resolve_retry_seconds =3D 1000000000
Fri Jun  9 15:35:45 2006 us=3D956480   connect_retry_seconds =3D 5
Fri Jun  9 15:35:45 2006 us=3D956480   username =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D957456   groupname =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D957456   chroot_dir =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D957456   cd_dir =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D958432   writepid =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D958432   up_script =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D959408   down_script =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D959408   down_pre =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D959408   up_restart =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D960384   up_delay =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D960384   daemon =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D961360   inetd =3D 0
Fri Jun  9 15:35:45 2006 us=3D961360   log =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D961360   suppress_timestamps =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D962336   nice =3D 0
Fri Jun  9 15:35:45 2006 us=3D962336   verbosity =3D 11
Fri Jun  9 15:35:45 2006 us=3D963312   mute =3D 0
Fri Jun  9 15:35:45 2006 us=3D963312   gremlin =3D 0
Fri Jun  9 15:35:45 2006 us=3D964288   status_file =3D '/var/adm/=20
openvpn.log'
Fri Jun  9 15:35:45 2006 us=3D964288   status_file_version =3D 1
Fri Jun  9 15:35:45 2006 us=3D965264   status_file_update_freq =3D 60
Fri Jun  9 15:35:45 2006 us=3D965264   occ =3D ENABLED
Fri Jun  9 15:35:45 2006 us=3D965264   rcvbuf =3D 65536
Fri Jun  9 15:35:45 2006 us=3D966240   sndbuf =3D 65536
Fri Jun  9 15:35:45 2006 us=3D966240   socks_proxy_server =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D967216   socks_proxy_port =3D 0
Fri Jun  9 15:35:45 2006 us=3D967216   socks_proxy_retry =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D967216   fast_io =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D968192   comp_lzo =3D ENABLED
Fri Jun  9 15:35:45 2006 us=3D968192   comp_lzo_adaptive =3D ENABLED
Fri Jun  9 15:35:45 2006 us=3D969168   route_script =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D969168   route_default_gateway =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D969168   route_noexec =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D970144   route_delay =3D 0
Fri Jun  9 15:35:45 2006 us=3D970144   route_delay_window =3D 30
Fri Jun  9 15:35:45 2006 us=3D971120   route_delay_defined =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D971120   management_addr =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D972096   management_port =3D 0
Fri Jun  9 15:35:45 2006 us=3D972096   management_user_pass =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D973072   management_log_history_cache =3D 250
Fri Jun  9 15:35:45 2006 us=3D973072   management_echo_buffer_size =3D 100
Fri Jun  9 15:35:45 2006 us=3D973072   management_query_passwords =3D=20=20
DISABLED
Fri Jun  9 15:35:45 2006 us=3D974048   management_hold =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D974048   shared_secret_file =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D975024   key_direction =3D 0
Fri Jun  9 15:35:45 2006 us=3D975024   ciphername_defined =3D ENABLED
Fri Jun  9 15:35:45 2006 us=3D975024   ciphername =3D 'BF-CBC'
Fri Jun  9 15:35:45 2006 us=3D976000   authname_defined =3D ENABLED
Fri Jun  9 15:35:45 2006 us=3D976000   authname =3D 'SHA1'
Fri Jun  9 15:35:45 2006 us=3D976976   keysize =3D 0
Fri Jun  9 15:35:45 2006 us=3D976976   engine =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D977952   replay =3D ENABLED
Fri Jun  9 15:35:45 2006 us=3D977952   mute_replay_warnings =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D978928   replay_window =3D 0
Fri Jun  9 15:35:45 2006 us=3D978928   replay_time =3D 0
Fri Jun  9 15:35:45 2006 us=3D978928   packet_id_file =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D979904   use_iv =3D ENABLED
Fri Jun  9 15:35:45 2006 us=3D979904   test_crypto =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D980880   tls_server =3D ENABLED
Fri Jun  9 15:35:45 2006 us=3D980880   tls_client =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D980880   key_method =3D 2
Fri Jun  9 15:35:45 2006 us=3D981856   ca_file =3D '/usr/pkg/etc/openvpn/=20
gabucino.ca'
Fri Jun  9 15:35:45 2006 us=3D981856   dh_file =3D '/usr/pkg/etc/openvpn/=20
dh1024.pem'
Fri Jun  9 15:35:45 2006 us=3D982832   cert_file =3D '/usr/pkg/etc/=20
openvpn/gabucino.crt'
Fri Jun  9 15:35:45 2006 us=3D982832   priv_key_file =3D '/usr/pkg/etc/=20
openvpn/gabucino.key'
Fri Jun  9 15:35:45 2006 us=3D983808   pkcs12_file =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D983808   cipher_list =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D983808   tls_verify =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D984784   tls_remote =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D984784   crl_file =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D985760   ns_cert_type =3D 0
Fri Jun  9 15:35:45 2006 us=3D985760   tls_timeout =3D 2
Fri Jun  9 15:35:45 2006 us=3D986736   renegotiate_bytes =3D 0
Fri Jun  9 15:35:45 2006 us=3D986736   renegotiate_packets =3D 0
Fri Jun  9 15:35:45 2006 us=3D987712   renegotiate_seconds =3D 3600
Fri Jun  9 15:35:45 2006 us=3D987712   handshake_window =3D 60
Fri Jun  9 15:35:45 2006 us=3D987712   transition_window =3D 3600
Fri Jun  9 15:35:45 2006 us=3D988688   single_session =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D988688   tls_exit =3D DISABLED
Fri Jun  9 15:35:45 2006 us=3D989664   tls_auth_file =3D '[UNDEF]'
Fri Jun  9 15:35:45 2006 us=3D989664   server_network =3D 10.0.98.0
Fri Jun  9 15:35:45 2006 us=3D994544   server_netmask =3D 255.255.255.0
Fri Jun  9 15:35:45 2006 us=3D995520   server_bridge_ip =3D 0.0.0.0
Fri Jun  9 15:35:45 2006 us=3D995520   server_bridge_netmask =3D 0.0.0.0
Fri Jun  9 15:35:45 2006 us=3D996496   server_bridge_pool_start =3D 0.0.0.0
Fri Jun  9 15:35:45 2006 us=3D996496   server_bridge_pool_end =3D 0.0.0.0
Fri Jun  9 15:35:45 2006 us=3D997472   push_list =3D 'route-gateway=20=20
10.0.98.1'
Fri Jun  9 15:35:45 2006 us=3D997472   ifconfig_pool_defined =3D ENABLED
Fri Jun  9 15:35:45 2006 us=3D998448   ifconfig_pool_start =3D 10.0.98.2
Fri Jun  9 15:35:46 2006   ifconfig_pool_end =3D 10.0.98.254
Fri Jun  9 15:35:46 2006   ifconfig_pool_netmask =3D 255.255.255.0
Fri Jun  9 15:35:46 2006 us=3D976   ifconfig_pool_persist_filename =3D=20=20
'[UNDEF]'
Fri Jun  9 15:35:46 2006 us=3D976   ifconfig_pool_persist_refresh_freq=20=20
=3D 600
Fri Jun  9 15:35:46 2006 us=3D1952   ifconfig_pool_linear =3D DISABLED
Fri Jun  9 15:35:46 2006 us=3D1952   n_bcast_buf =3D 256
Fri Jun  9 15:35:46 2006 us=3D2928   tcp_queue_limit =3D 64
Fri Jun  9 15:35:46 2006 us=3D2928   real_hash_size =3D 256
Fri Jun  9 15:35:46 2006 us=3D2928   virtual_hash_size =3D 256
Fri Jun  9 15:35:46 2006 us=3D3904   client_connect_script =3D '[UNDEF]'
Fri Jun  9 15:35:46 2006 us=3D3904   learn_address_script =3D '[UNDEF]'
Fri Jun  9 15:35:46 2006 us=3D5856   client_disconnect_script =3D '[UNDEF]'
Fri Jun  9 15:35:46 2006 us=3D6832   client_config_dir =3D '[UNDEF]'
Fri Jun  9 15:35:46 2006 us=3D6832   ccd_exclusive =3D DISABLED
Fri Jun  9 15:35:46 2006 us=3D7808   tmp_dir =3D '[UNDEF]'
Fri Jun  9 15:35:46 2006 us=3D8784   push_ifconfig_defined =3D DISABLED
Fri Jun  9 15:35:46 2006 us=3D9760   push_ifconfig_local =3D 0.0.0.0
Fri Jun  9 15:35:46 2006 us=3D9760   push_ifconfig_remote_netmask =3D=20=20
0.0.0.0
Fri Jun  9 15:35:46 2006 us=3D10736   enable_c2c =3D DISABLED
Fri Jun  9 15:35:46 2006 us=3D10736   duplicate_cn =3D DISABLED
Fri Jun  9 15:35:46 2006 us=3D11712   cf_max =3D 0
Fri Jun  9 15:35:46 2006 us=3D11712   cf_per =3D 0
Fri Jun  9 15:35:46 2006 us=3D11712   max_clients =3D 50
Fri Jun  9 15:35:46 2006 us=3D12688   max_routes_per_client =3D 256
Fri Jun  9 15:35:46 2006 us=3D12688   client_cert_not_required =3D DISABLED
Fri Jun  9 15:35:46 2006 us=3D13664   username_as_common_name =3D DISABLED
Fri Jun  9 15:35:46 2006 us=3D13664   auth_user_pass_verify_script =3D=20=20
'[UNDEF]'
Fri Jun  9 15:35:46 2006 us=3D14640=20=20=20=20
auth_user_pass_verify_script_via_file =3D DISABLED
Fri Jun  9 15:35:46 2006 us=3D14640   client =3D DISABLED
Fri Jun  9 15:35:46 2006 us=3D14640   pull =3D DISABLED
Fri Jun  9 15:35:46 2006 us=3D23424   auth_user_pass_file =3D '[UNDEF]'
Fri Jun  9 15:35:46 2006 us=3D36112 OpenVPN 2.0.7 alpha-dec-osf4.0b=20=20
[SSL] [LZO] built on Jun  9 2006
Fri Jun  9 15:35:46 2006 us=3D52704 WARNING: --keepalive option is=20=20
missing from server config
Fri Jun  9 15:35:46 2006 us=3D448960 Diffie-Hellman initialized with=20=20
1024 bit key
Fri Jun  9 15:35:46 2006 us=3D527040 MTU DYNAMIC mtu=3D0, flags=3D1, 0 -> 1=
59
Fri Jun  9 15:35:46 2006 us=3D528016 TLS-Auth MTU parms [ L:1579 D:159=20=20
EF:59 EB:0 ET:0 EL:0 ]
Fri Jun  9 15:35:46 2006 us=3D528016 MTU DYNAMIC mtu=3D1450, flags=3D2,=20=
=20
1579 -> 1450
Fri Jun  9 15:35:46 2006 us=3D532896 Tried opening /dev/tap0 (failed):=20=20
Device busy (errno=3D16)
Fri Jun  9 15:35:46 2006 us=3D537776 Tried opening /dev/tap1 (failed):=20=20
Device busy (errno=3D16)
Fri Jun  9 15:35:46 2006 us=3D540704 TUN/TAP device /dev/tap2 opened
Fri Jun  9 15:35:46 2006 us=3D541680 /sbin/ifconfig tap2 delete
Fri Jun  9 15:35:46 2006 us=3D541680 SYSTEM[0] '/sbin/ifconfig tap2=20=20
delete'
tap2: delete inet address 10.0.98.1
Fri Jun  9 15:35:46 2006 us=3D669536 SYSTEM return=3D0
Fri Jun  9 15:35:46 2006 us=3D670512 NOTE: Tried to delete pre-existing=20=
=20
tun/tap instance -- No Problem if failure
Fri Jun  9 15:35:46 2006 us=3D670512 /sbin/ifconfig tap2 10.0.98.1=20=20
netmask 255.255.255.0 ipmtu 1500 broadcast 10.0.98.255 up
Fri Jun  9 15:35:46 2006 us=3D671488 SYSTEM[2] '/sbin/ifconfig tap2=20=20
10.0.98.1 netmask 255.255.255.0 ipmtu 1500 broadcast 10.0.98.255 up'
Fri Jun  9 15:35:46 2006 us=3D740784 SYSTEM return=3D0
Fri Jun  9 15:35:46 2006 us=3D743712 Data Channel MTU parms [ L:1579 D:=20
1450 EF:47 EB:135 ET:32 EL:0 AF:3/1 ]
Fri Jun  9 15:35:46 2006 us=3D743712 STREAM: RESET
Fri Jun  9 15:35:46 2006 us=3D744688 STREAM: INIT maxlen=3D1579
Fri Jun  9 15:35:46 2006 us=3D745664 Listening for incoming TCP=20=20
connection on [undef]:995
Fri Jun  9 15:35:46 2006 us=3D746640 Socket Buffers: R=3D[32768->65536] S=
=3D=20
[32768->65536]
Fri Jun  9 15:35:46 2006 us=3D746640 TCPv4_SERVER link local (bound):=20=20
[undef]:995
Fri Jun  9 15:35:46 2006 us=3D747616 TCPv4_SERVER link remote: [undef]
Fri Jun  9 15:35:46 2006 us=3D747616 MULTI: multi_init called, r=3D256 v=3D=
256
Fri Jun  9 15:35:46 2006 us=3D753472 IFCONFIG POOL: base=3D10.0.98.2=20=20
size=3D253
Fri Jun  9 15:35:46 2006 us=3D754448 PO_INIT maxevents=3D54 flags=3D0x00000=
000
Fri Jun  9 15:35:46 2006 us=3D755424 MULTI: TCP INIT maxclients=3D50=20=20
maxevents=3D54
Fri Jun  9 15:35:46 2006 us=3D756400 Initialization Sequence Completed
Fri Jun  9 15:35:46 2006 us=3D756400 SCHEDULE: schedule_find_least NULL
Fri Jun  9 15:35:46 2006 us=3D757376 PO_CTL rwflags=3D0x0001 ev=3D4=20=20
arg=3D0x00000001
Fri Jun  9 15:35:46 2006 us=3D757376 PO_CTL rwflags=3D0x0001 ev=3D5=20=20
arg=3D0x00000002
Fri Jun  9 15:35:46 2006 us=3D758352 PO_WAIT[1,0] fd=3D5 rev=3D0x00000001=
=20=20
rwflags=3D0x0001 arg=3D0x00000002 [scalable]
Fri Jun  9 15:35:46 2006 us=3D761280 MULTI TCP: multi_tcp_action=20=20
a=3DTA_TUN_READ p=3D0
Fri Jun  9 15:35:46 2006 us=3D762256 MULTI TCP: multi_tcp_dispatch=20=20
a=3DTA_TUN_READ mi=3D0x00000000
Fri Jun  9 15:35:46 2006 us=3D763232  read from TUN/TAP returned 42
Fri Jun  9 15:35:46 2006 us=3D763232 MULTI TCP: multi_tcp_post=20=20
TA_TUN_READ -> TA_UNDEF
Fri Jun  9 15:35:46 2006 us=3D764208 SCHEDULE: schedule_find_least NULL
Fri Jun  9 15:35:47 2006 us=3D976 PO_WAIT[0,0] fd=3D4 rev=3D0x00000001=20=20
rwflags=3D0x0001 arg=3D0x00000001 [scalable]
Fri Jun  9 15:35:47 2006 us=3D1952 MULTI: REAP range 0 -> 16
Fri Jun  9 15:35:47 2006 us=3D2928 MULTI: multi_create_instance called
Fri Jun  9 15:35:47 2006 us=3D3904 PO_INIT maxevents=3D4 flags=3D0x00000002
Fri Jun  9 15:35:47 2006 us=3D3904 Re-using SSL/TLS context
Fri Jun  9 15:35:47 2006 us=3D6832 LZO compression initialized
Fri Jun  9 15:35:47 2006 us=3D6832 MTU DYNAMIC mtu=3D0, flags=3D1, 0 -> 159
Fri Jun  9 15:35:47 2006 us=3D7808 TLS: tls_session_init: entry
Fri Jun  9 15:35:47 2006 us=3D8784 PID packet_id_init seq_backtrack=3D0=20=
=20
time_backtrack=3D0
Fri Jun  9 15:35:47 2006 us=3D11712 PID packet_id_init seq_backtrack=3D0=20=
=20
time_backtrack=3D0
Fri Jun  9 15:35:47 2006 us=3D12688 TLS: tls_session_init: new session=20=20
object, sid=3Df46735bc c2ab3841
Fri Jun  9 15:35:47 2006 us=3D13664 TLS: tls_session_init: entry
Fri Jun  9 15:35:47 2006 us=3D13664 PID packet_id_init seq_backtrack=3D0=20=
=20
time_backtrack=3D0
Fri Jun  9 15:35:47 2006 us=3D16592 PID packet_id_init seq_backtrack=3D0=20=
=20
time_backtrack=3D0
Fri Jun  9 15:35:47 2006 us=3D17568 TLS: tls_session_init: new session=20=20
object, sid=3D60027667 63731623
Fri Jun  9 15:35:47 2006 us=3D20496 Control Channel MTU parms [ L:1579=20=20
D:159 EF:59 EB:0 ET:0 EL:0 ]
Fri Jun  9 15:35:47 2006 us=3D21472 MTU DYNAMIC mtu=3D1450, flags=3D2, 1579=
=20=20
-> 1450
Fri Jun  9 15:35:47 2006 us=3D22448 Data Channel MTU parms [ L:1579 D:=20
1450 EF:47 EB:135 ET:32 EL:0 AF:3/1 ]
Fri Jun  9 15:35:47 2006 us=3D26352 Local Options String: 'V4,dev-type=20=20
tap,link-mtu 1579,tun-mtu 1532,proto TCPv4_SERVER,comp-lzo,cipher BF-=20
CBC,auth SHA1,keysize 128,key-method 2,tls-server'
Fri Jun  9 15:35:47 2006 us=3D27328 Expected Remote Options String:=20=20
'V4,dev-type tap,link-mtu 1579,tun-mtu 1532,proto TCPv4_CLIENT,comp-=20
lzo,cipher BF-CBC,auth SHA1,keysize 128,key-method 2,tls-client'
Fri Jun  9 15:35:47 2006 us=3D28304 Local Options hash (VER=3DV4):=20=20
'd879f520'
Fri Jun  9 15:35:47 2006 us=3D29280 Expected Remote Options hash=20=20
(VER=3DV4): 'e62d1a2b'
Fri Jun  9 15:35:47 2006 us=3D30256 STREAM: RESET
Fri Jun  9 15:35:47 2006 us=3D30256 STREAM: INIT maxlen=3D1579
Fri Jun  9 15:35:47 2006 us=3D34160 TCP connection established with=20=20
84.236.20.230:59857
Fri Jun  9 15:35:47 2006 us=3D34160 Socket Buffers: R=3D[66364->65536] S=3D=
=20
[66364->65536]
Fri Jun  9 15:35:47 2006 us=3D35136 TCPv4_SERVER link local: [undef]
Fri Jun  9 15:35:47 2006 us=3D35136 TCPv4_SERVER link remote:=20=20
84.236.20.230:59857
Fri Jun  9 15:35:47 2006 us=3D36112 :21504 TIMER: coarse timer wakeup 1=20=
=20
seconds
Fri Jun  9 15:35:47 2006 us=3D37088 :21504 TLS: tls_multi_process: i=3D0=20=
=20
state=3DS_INITIAL, mysid=3Df46735bc c2ab3841, stored-sid=3D00000000=20=20
00000000, stored-ip=3D84.236.20.230:59857
Fri Jun  9 15:35:47 2006 us=3D38064 :21504 TLS: tls_process: chg=3D0=20=20
ks=3DS_INITIAL lame=3DS_UNDEF to_link->len=3D0 wakeup=3D604800
Fri Jun  9 15:35:47 2006 us=3D39040 :21504 ACK mark active outgoing ID 0
Fri Jun  9 15:35:47 2006 us=3D40016 :21504 TLS: Initial Handshake,=20=20
sid=3Df46735bc c2ab3841
Fri Jun  9 15:35:47 2006 us=3D40016 :21504 ACK reliable_can_send=20=20
active=3D1 current=3D1 : [1] 0
Fri Jun  9 15:35:47 2006 us=3D40992 :21504 ACK reliable_send ID 0=20=20
(size=3D8 to=3D2)
Fri Jun  9 15:35:47 2006 us=3D40992 :21504 Reliable -> TCP/UDP
Fri Jun  9 15:35:47 2006 us=3D41968 :21504 ACK reliable_send_timeout 2=20=20
[1] 0
Fri Jun  9 15:35:47 2006 us=3D41968 :21504 TLS: tls_process: timeout=20=20
set to 2
Fri Jun  9 15:35:47 2006 us=3D42944 :21504 TLS: tls_multi_process: i=3D1=20=
=20
state=3DS_INITIAL, mysid=3D60027667 63731623, stored-sid=3D00000000=20=20
00000000, stored-ip=3D[undef]
Fri Jun  9 15:35:47 2006 us=3D43920 :21504 TLS: tls_multi_process: i=3D2=20=
=20
state=3DS_UNDEF, mysid=3D00000000 00000000, stored-sid=3D00000000 00000000,=
=20=20
stored-ip=3D[undef]
Fri Jun  9 15:35:47 2006 us=3D44896 :21504 RANDOM USEC=3D81265
Fri Jun  9 15:35:47 2006 us=3D44896 :21504 SCHEDULE:=20=20
schedule_add_modify wakeup=3D[Fri Jun  9 15:35:48 2006 us=3D126161] pri=3D0
Fri Jun  9 15:35:47 2006 us=3D45872 :21504 MULTI TCP: instance added: :=20
21504
Fri Jun  9 15:35:47 2006 us=3D46848 :21504 MULTI TCP: multi_tcp_action=20=20
a=3DTA_INITIAL p=3D0
Fri Jun  9 15:35:47 2006 us=3D46848 :21504 MULTI TCP:=20=20
multi_tcp_dispatch a=3DTA_INITIAL mi=3D0x14003f560
Fri Jun  9 15:35:47 2006 us=3D47824 :21504 STREAM: SET NEXT, buf=3D=20
[216,0] next=3D[216,1579] len=3D-1 maxlen=3D1579
Fri Jun  9 15:35:47 2006 us=3D47824 :21504 PO_CTL rwflags=3D0x0001 ev=3D6=
=20=20
arg=3D0x14003f560
Fri Jun  9 15:35:47 2006 us=3D48800 :21504 TLS: tls_multi_process: i=3D0=20=
=20
state=3DS_PRE_START, mysid=3Df46735bc c2ab3841, stored-sid=3D00000000=20=20
00000000, stored-ip=3D84.236.20.230:59857
Fri Jun  9 15:35:47 2006 us=3D50752 :21504 TLS: tls_process: chg=3D0=20=20
ks=3DS_PRE_START lame=3DS_UNDEF to_link->len=3D18 wakeup=3D604800
Fri Jun  9 15:35:47 2006 us=3D55632 :21504 SSL state (accept): before/=20
accept initialization
Fri Jun  9 15:35:47 2006 us=3D56608 :21504 ACK reliable_send_timeout 2=20=20
[1] 0
Fri Jun  9 15:35:47 2006 us=3D56608 :21504 TLS: tls_process: timeout=20=20
set to 2
Fri Jun  9 15:35:47 2006 us=3D57584 :21504 TLS: tls_multi_process: i=3D1=20=
=20
state=3DS_INITIAL, mysid=3D60027667 63731623, stored-sid=3D00000000=20=20
00000000, stored-ip=3D[undef]
Fri Jun  9 15:35:47 2006 us=3D58560 :21504 TLS: tls_multi_process: i=3D2=20=
=20
state=3DS_UNDEF, mysid=3D00000000 00000000, stored-sid=3D00000000 00000000,=
=20=20
stored-ip=3D[undef]
Fri Jun  9 15:35:47 2006 us=3D60512 :21504 MULTI TCP: multi_tcp_post=20=20
TA_INITIAL -> TA_SOCKET_WRITE
Fri Jun  9 15:35:47 2006 us=3D60512 :21504 MULTI TCP: multi_tcp_action=20=20
a=3DTA_SOCKET_WRITE p=3D1
Fri Jun  9 15:35:47 2006 us=3D61488 :21504 MULTI TCP:=20=20
multi_tcp_wait_lite a=3DTA_SOCKET_WRITE mi=3D0x14003f560
Fri Jun  9 15:35:47 2006 us=3D61488 :21504 PO_CTL rwflags=3D0x0002 ev=3D6=
=20=20
arg=3D0x140001e74
Fri Jun  9 15:35:47 2006 us=3D68320 :21504 PO_CTL rwflags=3D0x0001 ev=3D5=
=20=20
arg=3D0x140001e78
Fri Jun  9 15:35:47 2006 us=3D70272 :21504 I/O WAIT TR|Tw|Sr|SW [0/0]
Fri Jun  9 15:35:47 2006 us=3D71248 :21504 PO_WAIT[0,0] fd=3D6=20=20
rev=3D0x00000004 rwflags=3D0x0002 arg=3D0x140001e74
Fri Jun  9 15:35:47 2006 us=3D71248 :21504  event_wait returned 1
Fri Jun  9 15:35:47 2006 us=3D72224 :21504 I/O WAIT status=3D0x0002
Fri Jun  9 15:35:47 2006 us=3D72224 :21504 MULTI TCP:=20=20
multi_tcp_dispatch a=3DTA_SOCKET_WRITE mi=3D0x14003f560
Fri Jun  9 15:35:47 2006 us=3D73200 :21504 TCPv4_SERVER WRITE [18] to=20=20
84.236.20.230:59857: P_CONTROL_HARD_RESET_SERVER_V2 kid=3D0=20=20
sid=3Df46735bc c2ab3841 [ ] pid=3D0 DATA
Fri Jun  9 15:35:47 2006 us=3D74176 :21504 STREAM: WRITE 18 offset=3D42
Fri Jun  9 15:35:47 2006 us=3D75152 :21504 TCPv4_SERVER write returned 19
Fri Jun  9 15:35:47 2006 us=3D76128 :21504 TLS: tls_multi_process: i=3D0=20=
=20
state=3DS_PRE_START, mysid=3Df46735bc c2ab3841, stored-sid=3D00000000=20=20
00000000, stored-ip=3D84.236.20.230:59857
Fri Jun  9 15:35:47 2006 us=3D77104 :21504 TLS: tls_process: chg=3D0=20=20
ks=3DS_PRE_START lame=3DS_UNDEF to_link->len=3D0 wakeup=3D604800
Fri Jun  9 15:35:47 2006 us=3D77104 :21504 ACK reliable_can_send=20=20
active=3D1 current=3D0 : [1] 0
Fri Jun  9 15:35:47 2006 us=3D78080 :21504 ACK reliable_send_timeout 2=20=20
[1] 0
Fri Jun  9 15:35:47 2006 us=3D79056 :21504 TLS: tls_process: timeout=20=20
set to 2
Fri Jun  9 15:35:47 2006 us=3D80032 :21504 TLS: tls_multi_process: i=3D1=20=
=20
state=3DS_INITIAL, mysid=3D60027667 63731623, stored-sid=3D00000000=20=20
00000000, stored-ip=3D[undef]
Fri Jun  9 15:35:47 2006 us=3D81008 :21504 TLS: tls_multi_process: i=3D2=20=
=20
state=3DS_UNDEF, mysid=3D00000000 00000000, stored-sid=3D00000000 00000000,=
=20=20
stored-ip=3D[undef]
Fri Jun  9 15:35:47 2006 us=3D81984 STREAM: SET NEXT, buf=3D[216,0] next=3D=
=20
[216,1579] len=3D-1 maxlen=3D1579
Fri Jun  9 15:35:47 2006 us=3D81984 MULTI TCP: multi_tcp_post=20=20
TA_SOCKET_WRITE -> TA_UNDEF
Fri Jun  9 15:35:47 2006 us=3D82960 SCHEDULE: schedule_find_least=20=20
wakeup=3D[Fri Jun  9 15:35:48 2006 us=3D126161] pri=3D635486317
Fri Jun  9 15:35:47 2006 us=3D82960 PO_WAIT[2,0] fd=3D6 rev=3D0x00000001=20=
=20
rwflags=3D0x0001 arg=3D0x14003f560 [scalable]
Fri Jun  9 15:35:47 2006 us=3D83936 MULTI TCP: multi_tcp_action=20=20
a=3DTA_SOCKET_READ p=3D0
Fri Jun  9 15:35:47 2006 us=3D83936 MULTI TCP: multi_tcp_dispatch=20=20
a=3DTA_SOCKET_READ mi=3D0x14003f560
Fri Jun  9 15:35:47 2006 us=3D84912 :21504 STREAM: GET NEXT len=3D1579
Fri Jun  9 15:35:47 2006 us=3D85888 :21504 STREAM: ADD length_added=3D16
Fri Jun  9 15:35:47 2006 us=3D85888 :21504 WARNING: Bad encapsulated=20=20
packet length from peer (0), which must be > 0 and <=3D 1579 -- please=20=20
ensure that --tun-mtu or --link-mtu is equal on both peers -- this=20=20
condition could also indicate a possible active attack on the TCP=20=20
link -- [Attemping restart...]
Fri Jun  9 15:35:47 2006 us=3D85888 :21504 STREAM: RESET
Fri Jun  9 15:35:47 2006 us=3D86864 :21504 Connection reset, restarting=20=
=20
[0]
Fri Jun  9 15:35:47 2006 us=3D86864 :21504 SIGUSR1[soft,connection-=20
reset] received, client-instance restarting
Fri Jun  9 15:35:47 2006 us=3D87840 MULTI: multi_close_instance called
Fri Jun  9 15:35:47 2006 us=3D87840 Assertion failed at multi.c:457
Fri Jun  9 15:35:47 2006 us=3D88816 Exiting

--=20
G=E1bor B=E9rczi



