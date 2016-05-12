References: <5731B295.4040301@...515...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <57350DC5.80801@...68...>
Date: Fri, 13 May 2016 01:12:05 +0200
MIME-Version: 1.0
In-Reply-To: <5731B295.4040301@...515...>
Subject: Re: [Openvpn-devel] SIGSEGV (NULL ptr deref) in PolarSSL-based
 build if noTLS ciphers specified (was: OpenVPN 2.3.11 released)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Am 10.05.2016 um 12:06 schrieb Samuli Sepp=E4nen:
> The OpenVPN community project team is proud to release OpenVPN 2.3.11.=20
> It can be downloaded from here:
>=20
> <http://openvpn.net/index.php/open-source/downloads.html>
>=20
> This release fixes two vulnerabilities: a port-share bug with DoS=20
> potential and a buffer overflow by user supplied data when using pam=20
> authentication. In addition a number of small fixes and improvements are=
=20
> included. A full list of changes is available here:
>=20
> <https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn23>

Thanks.

Unfortunately, it appears that at least with PolarSSL 1.3.16, this
release introduces a crasher regression which easily shows up in a "make
check" on FreeBSD when no specific ciphers are selected.  Backtrace
below.  The OpenSSL-based build seems fine.

To me it appears as though the failure-inducing change were
> commit 8a399cd30ae19f521794f3dfe7ef194abd440d1b
> Author: Steffan Karger <steffan@...1856...>
> Date:   Sun Apr 17 20:23:32 2016 +0200
>=20
>     Restrict default TLS cipher list
[...]

which removes an if (options->cipher_list) ... check guarding
tls_ctx_restrict_ciphers(), and adds a "sane default TLS cipher list" in
an if (ciphers =3D=3D NULL) block into the invoked *OpenSSL* implementation
tls_ctx_restrict_ciphers() of src/openvpn/ssl_openssl.c, but *not* into
the PolarSSL src/openvpn/ssl_polarssl.c.

A trivial attempt that I made at adding the list above to PolarSSL
doesn't work, the TLS client self-test balks that the client had no
cipher suites in common with the server, so apparently I know or oversee
too little and should not be the one writing such code.

Please someone write corresponding functionality (adding a limited set
of strong default cipher suites) also for PolarSSL, and we all see to a
quick 2.3.12 release?

Thanks.

> Program terminated with signal SIGSEGV, Segmentation fault.
> #0  0x0000000800eecd2b in strlen () from /lib/libc.so.7
> (gdb) bt f
> #0  0x0000000800eecd2b in strlen () from /lib/libc.so.7
> No symbol table info available.
> #1  0x0000000000495c09 in tls_ctx_restrict_ciphers (ctx=3D0x7fffffffd7c0,=
=20
>     ciphers=3D0x0) at ssl_polarssl.c:179
>         tmp_ciphers =3D 0x495fbb <tls_ctx_check_cert_time+203> "=3D"
>         tmp_ciphers_orig =3D 0x7fffffffcd10 "@\315\377\377\377\177"
>         token =3D 0x0
>         i =3D 8
>         cipher_count =3D 18163184
>         ciphers_len =3D 0
> #2  0x000000000048c931 in init_ssl (options=3D0x7fffffffd0e0,=20
>     new_ctx=3D0x7fffffffd7c0) at ssl.c:564
> No locals.
> #3  0x000000000042710d in do_init_crypto_tls_c1 (c=3D0x7fffffffd0e0)
>     at init.c:2138
>         options =3D 0x7fffffffd0e0
> #4  0x00000000004269e4 in do_init_crypto_tls (c=3D0x7fffffffd0e0, flags=
=3D3)
>     at init.c:2218
>         options =3D 0x7fffffffd0e0
>         to =3D {ssl_ctx =3D {initialised =3D 64, endpoint =3D 8,=20
>             dhm_ctx =3D 0x7fff00000065, crt_chain =3D 0x80112c7b8, ca_cha=
in =3D 0x0,=20
>             priv_key =3D 0x4ba952, external_key =3D 0x4ba952,=20
>             allowed_ciphers =3D 0x2ffffde88}, key_type =3D {
>             hmac_length =3D 222 '\336', cipher =3D 0x801849a08, digest =
=3D 0x801849408}, server =3D 109, xmit_hold =3D 164, local_options =3D 0x0,=
 remote_options =3D 0x7fffffffcfc0 "\340\320\377\377\377\177", key_method =
=3D 4869113, replay =3D false,=20
>           single_session =3D false, disable_occ =3D false, push_peer_info=
_detail =3D 2, transition_window =3D 64, handshake_window =3D -12304, packe=
t_timeout =3D 32767, renegotiate_bytes =3D 4266084, renegotiate_packets =3D=
 0, renegotiate_seconds =3D 4869113,=20
>           verify_command =3D 0x298 <error: Cannot access memory at addres=
s 0x298>, verify_export_cert =3D 0x1 <error: Cannot access memory at addres=
s 0x1>, verify_x509_type =3D 1, verify_x509_name =3D 0x0,=20
>           crl_file =3D 0x40ffffcf48 <error: Cannot access memory at addre=
ss 0x40ffffcf48>, ns_cert_type =3D 480, remote_cert_ku =3D {0, 37, 0, 512, =
0, 38, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0}, remote_cert_eku =3D 0x0,=20
>           verify_hash =3D 0x63b0370d1b8d876d <error: Cannot access memory=
 at address 0x63b0370d1b8d876d>, x509_username_field =3D 0x0, pass_config_i=
nfo =3D 109, crypto_flags_and =3D 1672492813, crypto_flags_or =3D 32, repla=
y_window =3D 0, replay_time =3D -1, tcp_mode =3D false,=20
>           tls_auth =3D {key_ctx_bi =3D 0x0, packet_id =3D 0x4, pid_persis=
t =3D 0x8, flags =3D 4294954896}, tls_auth_key =3D {encrypt =3D {cipher =3D=
 0x412ceb <po_init+619>, hmac =3D 0x8018172c0}, decrypt =3D {cipher =3D 0x0=
, hmac =3D 0x8}}, frame =3D {link_mtu =3D 25260704, link_mtu_dynamic =3D 8,=
=20
>             extra_frame =3D 4274992, extra_buffer =3D 0, extra_tun =3D 42=
75744, extra_link =3D 0, align_flags =3D 4274896, align_adjust =3D 0},=20
>           auth_user_pass_verify_script =3D 0x413a90 <po_free> "UH\211\345=
H\203\354\020H\211}\370H\213}\370H\211}\360H\213}\360H\213\177\060\350\203\=
020\377\377H\213}\360H\213\177\070\350v\020\377\377H\213}\360\350m\020\377\=
377H\203\304\020]\303\017\037",=20
>           auth_user_pass_verify_script_via_file =3D 160, tmp_dir =3D 0x80=
1809060 "\220:A", auth_user_pass_file =3D 0x201806080 <error: Cannot access=
 memory at address 0x201806080>, client_config_dir_exclusive =3D 0x7fffffff=
d8d0 "\004", es =3D 0x7fffffffcfc0,=20
>           plugins =3D 0x4129c1 <event_set_init_simple+49>, ssl_flags =3D =
462260077, mda_context =3D 0x0, sci =3D 0x7fffffffde00, gremlin =3D -8568}
>         packet_id_long_form =3D false
> #5  0x00000000004240b3 in do_init_crypto (c=3D0x7fffffffd0e0, flags=3D3) =
at init.c:2391
> No locals.
> #6  0x0000000000422f12 in init_instance (c=3D0x7fffffffd0e0, env=3D0x8018=
06040, flags=3D4) at init.c:3440
>         crypto_flags =3D 3
>         options =3D 0x7fffffffd0e0
>         child =3D false
>         link_socket_mode =3D 0
> #7  0x0000000000422a38 in init_instance_handle_signals (c=3D0x7fffffffd0e=
0, env=3D0x801806040, flags=3D4) at init.c:3301
> No locals.
> #8  0x000000000044cfdc in tunnel_point_to_point (c=3D0x7fffffffd0e0) at o=
penvpn.c:70
> No locals.
> #9  0x000000000044ce1f in openvpn_main (argc=3D15, argv=3D0x7fffffffde08)=
 at openvpn.c:270
>         c =3D {options =3D {gc =3D {list =3D 0x8018171a0}, gc_owned =3D t=
rue, config =3D 0x7fffffffe2b9 "sample-config-files/loopback-server.test", =
mode =3D 0, forward_compatible =3D false, ignore_unknown_option =3D 0x0, pe=
rsist_config =3D false, persist_mode =3D 0, key_pass_file =3D 0x0,=20
>             show_ciphers =3D false, show_digests =3D false, show_engines =
=3D false, show_tls_ciphers =3D false, genkey =3D false, ce =3D {proto =3D =
5, local_port =3D 16100, local_port_defined =3D true, remote_port =3D 16101=
, local =3D 0x801806108 "::1", remote =3D 0x8018060c8 "::1",=20
>               remote_float =3D false, bind_defined =3D false, bind_local =
=3D true, connect_retry_seconds =3D 5, connect_retry_defined =3D false, con=
nect_retry_max =3D 0, connect_timeout =3D 10, connect_timeout_defined =3D f=
alse, http_proxy_options =3D 0x0, socks_proxy_server =3D 0x0,=20
>               socks_proxy_port =3D 0, socks_proxy_authfile =3D 0x0, socks=
_proxy_retry =3D false, tun_mtu =3D 1500, tun_mtu_defined =3D true, tun_mtu=
_extra =3D 0, tun_mtu_extra_defined =3D false, link_mtu =3D 1500, link_mtu_=
defined =3D false, mtu_discover_type =3D -1, fragment =3D 0,=20
>               mssfix =3D 1450, mssfix_default =3D false, explicit_exit_no=
tification =3D 0, flags =3D 0}, remote_ip_hint =3D 0x0, connection_list =3D=
 0x0, remote_list =3D 0x801841088, force_connection_list =3D false, http_pr=
oxy_override =3D 0x0, rh_store =3D 0x0, remote_random =3D false,=20
>             ipchange =3D 0x0, dev =3D 0x801806128 "null", dev_type =3D 0x=
0, dev_node =3D 0x0, lladdr =3D 0x0, topology =3D 1, ifconfig_local =3D 0x0=
, ifconfig_remote_netmask =3D 0x0, ifconfig_ipv6_local =3D 0x0, ifconfig_ip=
v6_netbits =3D 0, ifconfig_ipv6_remote =3D 0x0,=20
>             ifconfig_noexec =3D false, ifconfig_nowarn =3D false, shaper =
=3D 0, proto_force =3D -1, mtu_test =3D false, mlock =3D false, keepalive_p=
ing =3D 0, keepalive_timeout =3D 0, inactivity_timeout =3D 120, inactivity_=
minimum_bytes =3D 10000000, ping_send_timeout =3D 1,=20
>             ping_rec_timeout =3D 180, ping_timer_remote =3D false, tun_ip=
v6 =3D false, ping_rec_timeout_action =3D 1, persist_tun =3D false, persist=
_local_ip =3D false, persist_remote_ip =3D false, persist_key =3D false, pa=
sstos =3D false, resolve_retry_seconds =3D 1000000000,=20
>             tuntap_options =3D {dummy =3D 0}, username =3D 0x0, groupname=
 =3D 0x0, chroot_dir =3D 0x0, cd_dir =3D 0x7fffffffe258 "../sample", writep=
id =3D 0x0, up_script =3D 0x0, down_script =3D 0x7fffffffe27b "../tests/t_c=
ltsrv-down.sh", user_script_used =3D true, down_pre =3D false,=20
>             up_delay =3D false, up_restart =3D false, daemon =3D false, r=
emap_sigusr1 =3D 0, inetd =3D 0, log =3D false, suppress_timestamps =3D fal=
se, nice =3D 0, verbosity =3D 3, mute =3D 0, gremlin =3D 0, status_file =3D=
 0x0, status_file_version =3D 1, status_file_update_freq =3D 60,=20
>             fast_io =3D false, lzo =3D 0, rcvbuf =3D 0, sndbuf =3D 0, mar=
k =3D 0, sockflags =3D 0, route_script =3D 0x0, route_predown_script =3D 0x=
0, route_default_gateway =3D 0x0, route_default_metric =3D 0, route_noexec =
=3D false, route_delay =3D 0, route_delay_window =3D 30,=20
>             route_delay_defined =3D false, max_routes =3D 100, routes =3D=
 0x0, routes_ipv6 =3D 0x0, route_nopull =3D false, route_gateway_via_dhcp =
=3D false, allow_pull_fqdn =3D false, client_nat =3D 0x0, occ =3D true, man=
agement_addr =3D 0x0, management_port =3D 0,=20
>             management_user_pass =3D 0x0, management_log_history_cache =
=3D 250, management_echo_buffer_size =3D 100, management_state_buffer_size =
=3D 100, management_write_peer_info_file =3D 0x0, management_client_user =
=3D 0x0, management_client_group =3D 0x0, management_flags =3D 0,=20
>             plugin_list =3D 0x0, tmp_dir =3D 0x4b1097 "/tmp", server_defi=
ned =3D false, server_network =3D 0, server_netmask =3D 0, server_ipv6_defi=
ned =3D false, server_network_ipv6 =3D {__u6_addr =3D {__u6_addr8 =3D '\000=
' <repeats 15 times>, __u6_addr16 =3D {0, 0, 0, 0, 0, 0, 0, 0},=20
>                 __u6_addr32 =3D {0, 0, 0, 0}}}, server_netbits_ipv6 =3D 0=
, server_flags =3D 0, server_bridge_proxy_dhcp =3D false, server_bridge_def=
ined =3D false, server_bridge_ip =3D 0, server_bridge_netmask =3D 0, server=
_bridge_pool_start =3D 0, server_bridge_pool_end =3D 0,=20
>             push_list =3D {head =3D 0x0, tail =3D 0x0}, ifconfig_pool_def=
ined =3D false, ifconfig_pool_start =3D 0, ifconfig_pool_end =3D 0, ifconfi=
g_pool_netmask =3D 0, ifconfig_pool_persist_filename =3D 0x0, ifconfig_pool=
_persist_refresh_freq =3D 600,=20
>             ifconfig_ipv6_pool_defined =3D false, ifconfig_ipv6_pool_base=
 =3D {__u6_addr =3D {__u6_addr8 =3D '\000' <repeats 15 times>, __u6_addr16 =
=3D {0, 0, 0, 0, 0, 0, 0, 0}, __u6_addr32 =3D {0, 0, 0, 0}}}, ifconfig_ipv6=
_pool_netbits =3D 0, real_hash_size =3D 256,=20
>             virtual_hash_size =3D 256, client_connect_script =3D 0x0, cli=
ent_disconnect_script =3D 0x0, learn_address_script =3D 0x0, client_config_=
dir =3D 0x0, ccd_exclusive =3D false, disable =3D false, n_bcast_buf =3D 25=
6, tcp_queue_limit =3D 64, iroutes =3D 0x0, iroutes_ipv6 =3D 0x0,=20
>             push_ifconfig_defined =3D false, push_ifconfig_local =3D 0, p=
ush_ifconfig_remote_netmask =3D 0, push_ifconfig_local_alias =3D 0, push_if=
config_constraint_defined =3D false, push_ifconfig_constraint_network =3D 0=
, push_ifconfig_constraint_netmask =3D 0,=20
>             push_ifconfig_ipv6_defined =3D false, push_ifconfig_ipv6_loca=
l =3D {__u6_addr =3D {__u6_addr8 =3D '\000' <repeats 15 times>, __u6_addr16=
 =3D {0, 0, 0, 0, 0, 0, 0, 0}, __u6_addr32 =3D {0, 0, 0, 0}}}, push_ifconfi=
g_ipv6_netbits =3D 0, push_ifconfig_ipv6_remote =3D {
>               __u6_addr =3D {__u6_addr8 =3D '\000' <repeats 15 times>, __=
u6_addr16 =3D {0, 0, 0, 0, 0, 0, 0, 0}, __u6_addr32 =3D {0, 0, 0, 0}}}, ena=
ble_c2c =3D false, duplicate_cn =3D false, cf_max =3D 0, cf_per =3D 0, max_=
clients =3D 1024, max_routes_per_client =3D 256,=20
>             stale_routes_check_interval =3D 0, stale_routes_ageing_time =
=3D 0, auth_user_pass_verify_script =3D 0x0, auth_user_pass_verify_script_v=
ia_file =3D false, port_share_host =3D 0x0, port_share_port =3D 0, port_sha=
re_journal_dir =3D 0x0, client =3D false, pull =3D false,=20
>             push_continuation =3D 0, push_option_types_found =3D 0, auth_=
user_pass_file =3D 0x0, pre_pull =3D 0x0, server_poll_timeout =3D 0, schedu=
led_exit_interval =3D 5, sc_info =3D {flags =3D 0, challenge_text =3D 0x0},=
 shared_secret_file =3D 0x0, shared_secret_file_inline =3D 0x0,=20
>             key_direction =3D 0, ciphername_defined =3D true, ciphername =
=3D 0x4a1b6d "BF-CBC", authname_defined =3D true, authname =3D 0x4b108b "SH=
A1", keysize =3D 0, prng_hash =3D 0x4b108b "SHA1", prng_nonce_secret_len =
=3D 16, engine =3D 0x0, replay =3D true,=20
>             mute_replay_warnings =3D false, replay_window =3D 64, replay_=
time =3D 15, packet_id_file =3D 0x0, use_iv =3D true, test_crypto =3D false=
, use_prediction_resistance =3D false, tls_server =3D true, tls_client =3D =
false, ca_file =3D 0x801817128 "sample-keys/ca.crt", ca_path =3D 0x0,=20
>             dh_file =3D 0x801817108 "sample-keys/dh2048.pem", cert_file =
=3D 0x801817168 "sample-keys/server.crt", extra_certs_file =3D 0x0, priv_ke=
y_file =3D 0x801817148 "sample-keys/server.key", pkcs12_file =3D 0x0, ciphe=
r_list =3D 0x0, tls_verify =3D 0x0, verify_x509_type =3D 0,=20
>             verify_x509_name =3D 0x0, tls_export_cert =3D 0x0, crl_file =
=3D 0x0, ca_file_inline =3D 0x0, cert_file_inline =3D 0x0, extra_certs_file=
_inline =3D 0x0, priv_key_file_inline =3D 0x0, dh_file_inline =3D 0x0, pkcs=
12_file_inline =3D 0x0, ns_cert_type =3D 0, remote_cert_ku =3D {
>               0 <repeats 16 times>}, remote_cert_eku =3D 0x0, verify_hash=
 =3D 0x0, ssl_flags =3D 0, key_method =3D 2, tls_timeout =3D 2, renegotiate=
_bytes =3D 0, renegotiate_packets =3D 0, renegotiate_seconds =3D 10, handsh=
ake_window =3D 60, transition_window =3D 3600, tls_auth_file =3D 0x0,=20
>             tls_auth_file_inline =3D 0x0, single_session =3D false, push_=
peer_info =3D false, tls_exit =3D true, foreign_option_index =3D 0, use_pee=
r_id =3D false, peer_id =3D 0}, first_time =3D true, mode =3D 0, gc =3D {li=
st =3D 0x0}, es =3D 0x801806040, sig =3D 0x6da838 <siginfo_static>,=20
>           plugins =3D 0x0, plugins_owned =3D false, did_we_daemonize =3D =
false, persist =3D {restart_sleep_seconds =3D 0}, c0 =3D 0x0, c1 =3D {link_=
socket_addr =3D {local =3D {addr =3D {sa =3D {sa_len =3D 0 '\000', sa_famil=
y =3D 0 '\000', sa_data =3D '\000' <repeats 13 times>}, in4 =3D {
>                     sin_len =3D 0 '\000', sin_family =3D 0 '\000', sin_po=
rt =3D 0, sin_addr =3D {s_addr =3D 0}, sin_zero =3D "\000\000\000\000\000\0=
00\000"}, in6 =3D {sin6_len =3D 0 '\000', sin6_family =3D 0 '\000', sin6_po=
rt =3D 0, sin6_flowinfo =3D 0, sin6_addr =3D {__u6_addr =3D {
>                         __u6_addr8 =3D '\000' <repeats 15 times>, __u6_ad=
dr16 =3D {0, 0, 0, 0, 0, 0, 0, 0}, __u6_addr32 =3D {0, 0, 0, 0}}}, sin6_sco=
pe_id =3D 0}}}, remote =3D {addr =3D {sa =3D {sa_len =3D 0 '\000', sa_famil=
y =3D 0 '\000', sa_data =3D '\000' <repeats 13 times>}, in4 =3D {
>                     sin_len =3D 0 '\000', sin_family =3D 0 '\000', sin_po=
rt =3D 0, sin_addr =3D {s_addr =3D 0}, sin_zero =3D "\000\000\000\000\000\0=
00\000"}, in6 =3D {sin6_len =3D 0 '\000', sin6_family =3D 0 '\000', sin6_po=
rt =3D 0, sin6_flowinfo =3D 0, sin6_addr =3D {__u6_addr =3D {
>                         __u6_addr8 =3D '\000' <repeats 15 times>, __u6_ad=
dr16 =3D {0, 0, 0, 0, 0, 0, 0, 0}, __u6_addr32 =3D {0, 0, 0, 0}}}, sin6_sco=
pe_id =3D 0}}}, actual =3D {dest =3D {addr =3D {sa =3D {sa_len =3D 0 '\000'=
, sa_family =3D 0 '\000', sa_data =3D '\000' <repeats 13 times>},=20
>                     in4 =3D {sin_len =3D 0 '\000', sin_family =3D 0 '\000=
', sin_port =3D 0, sin_addr =3D {s_addr =3D 0}, sin_zero =3D "\000\000\000\=
000\000\000\000"}, in6 =3D {sin6_len =3D 0 '\000', sin6_family =3D 0 '\000'=
, sin6_port =3D 0, sin6_flowinfo =3D 0, sin6_addr =3D {__u6_addr =3D {
>                           __u6_addr8 =3D '\000' <repeats 15 times>, __u6_=
addr16 =3D {0, 0, 0, 0, 0, 0, 0, 0}, __u6_addr32 =3D {0, 0, 0, 0}}}, sin6_s=
cope_id =3D 0}}}, pi =3D {in4 =3D {s_addr =3D 0}, in6 =3D {ipi6_addr =3D {_=
_u6_addr =3D {__u6_addr8 =3D '\000' <repeats 15 times>,=20
>                         __u6_addr16 =3D {0, 0, 0, 0, 0, 0, 0, 0}, __u6_ad=
dr32 =3D {0, 0, 0, 0}}}, ipi6_ifindex =3D 0}}}}, ks =3D {key_type =3D {ciph=
er_length =3D 0 '\000', hmac_length =3D 0 '\000', cipher =3D 0x0, digest =
=3D 0x0}, static_key =3D {encrypt =3D {cipher =3D 0x0, hmac =3D 0x0},=20
>                 decrypt =3D {cipher =3D 0x0, hmac =3D 0x0}}, ssl_ctx =3D =
{initialised =3D true, endpoint =3D 1, dhm_ctx =3D 0x801810100, crt_chain =
=3D 0x801841580, ca_chain =3D 0x801841300, priv_key =3D 0x8018063e0, extern=
al_key =3D 0x0, allowed_ciphers =3D 0x0}, tls_auth_key =3D {encrypt =3D {
>                   cipher =3D 0x0, hmac =3D 0x0}, decrypt =3D {cipher =3D =
0x0, hmac =3D 0x0}}}, pid_persist =3D {filename =3D 0x0, fd =3D -1, time =
=3D 0, id =3D 0, time_last_written =3D 0, id_last_written =3D 0}, tuntap =
=3D 0x0, tuntap_owned =3D false, route_list =3D 0x0, route_ipv6_list =3D 0x=
0,=20
>             status_output =3D 0x0, status_output_owned =3D true, http_pro=
xy =3D 0x0, http_proxy_owned =3D false, socks_proxy =3D 0x0, socks_proxy_ow=
ned =3D false, ifconfig_pool_persist =3D 0x0, ifconfig_pool_persist_owned =
=3D false, pulled_options_digest_save =3D {
>               digest =3D '\000' <repeats 15 times>}, auth_user_pass =3D 0=
x0}, c2 =3D {gc =3D {list =3D 0x0}, event_set =3D 0x801809060, event_set_ma=
x =3D 4, event_set_owned =3D true, event_set_status =3D 0, link_socket =3D =
0x80180a180, link_socket_owned =3D true, link_socket_info =3D 0x0,=20
>             accept_from =3D 0x0, to_link_addr =3D 0x0, from =3D {dest =3D=
 {addr =3D {sa =3D {sa_len =3D 0 '\000', sa_family =3D 0 '\000', sa_data =
=3D '\000' <repeats 13 times>}, in4 =3D {sin_len =3D 0 '\000', sin_family =
=3D 0 '\000', sin_port =3D 0, sin_addr =3D {s_addr =3D 0},=20
>                     sin_zero =3D "\000\000\000\000\000\000\000"}, in6 =3D=
 {sin6_len =3D 0 '\000', sin6_family =3D 0 '\000', sin6_port =3D 0, sin6_fl=
owinfo =3D 0, sin6_addr =3D {__u6_addr =3D {__u6_addr8 =3D '\000' <repeats =
15 times>, __u6_addr16 =3D {0, 0, 0, 0, 0, 0, 0, 0}, __u6_addr32 =3D {
>                           0, 0, 0, 0}}}, sin6_scope_id =3D 0}}}, pi =3D {=
in4 =3D {s_addr =3D 0}, in6 =3D {ipi6_addr =3D {__u6_addr =3D {__u6_addr8 =
=3D '\000' <repeats 15 times>, __u6_addr16 =3D {0, 0, 0, 0, 0, 0, 0, 0}, __=
u6_addr32 =3D {0, 0, 0, 0}}}, ipi6_ifindex =3D 0}}}, frame =3D {
>               link_mtu =3D 0, link_mtu_dynamic =3D 0, extra_frame =3D 0, =
extra_buffer =3D 0, extra_tun =3D 0, extra_link =3D 0, align_flags =3D 0, a=
lign_adjust =3D 0}, fragment =3D 0x0, frame_fragment =3D {link_mtu =3D 0, l=
ink_mtu_dynamic =3D 0, extra_frame =3D 0, extra_buffer =3D 0,=20
>               extra_tun =3D 0, extra_link =3D 0, align_flags =3D 0, align=
_adjust =3D 0}, frame_fragment_omit =3D {link_mtu =3D 0, link_mtu_dynamic =
=3D 0, extra_frame =3D 0, extra_buffer =3D 0, extra_tun =3D 0, extra_link =
=3D 0, align_flags =3D 0, align_adjust =3D 0}, shaper =3D {
>               bytes_per_second =3D 0, wakeup =3D {tv_sec =3D 0, tv_usec =
=3D 0}, factor =3D 0}, tun_read_bytes =3D 0, tun_write_bytes =3D 0, link_re=
ad_bytes =3D 0, link_read_bytes_auth =3D 0, link_write_bytes =3D 0, wait_fo=
r_connect =3D {defined =3D false, n =3D 0, last =3D 0},=20
>             ping_send_interval =3D {defined =3D false, n =3D 0, last =3D =
0}, ping_rec_interval =3D {defined =3D false, n =3D 0, last =3D 0}, inactiv=
ity_interval =3D {defined =3D false, n =3D 0, last =3D 0}, inactivity_bytes=
 =3D 0, options_string_local =3D 0x0, options_string_remote =3D 0x0,=20
>             occ_op =3D -1, occ_n_tries =3D 0, occ_interval =3D {defined =
=3D false, n =3D 0, last =3D 0}, original_recv_size =3D 0, max_recv_size_lo=
cal =3D 0, max_recv_size_remote =3D 0, max_send_size_local =3D 0, max_send_=
size_remote =3D 0, occ_mtu_load_size =3D 0,=20
>             occ_mtu_load_test_interval =3D {defined =3D false, n =3D 0, l=
ast =3D 0}, occ_mtu_load_n_tries =3D 0, tls_multi =3D 0x0, tls_auth_standal=
one =3D 0x0, tmp_int =3D {refresh =3D 0, horizon =3D 0, future_trigger =3D =
0, last_action =3D 0, last_test_true =3D 0}, tls_exit_signal =3D 15,=20
>             crypto_options =3D {key_ctx_bi =3D 0x0, packet_id =3D 0x0, pi=
d_persist =3D 0x0, flags =3D 2}, packet_id =3D {send =3D {id =3D 0, time =
=3D 0}, rec =3D {last_reap =3D 0, time =3D 0, id =3D 0, seq_backtrack =3D 0=
, time_backtrack =3D 0, max_backtrack_stat =3D 0, initialized =3D false,=20
>                 seq_list =3D 0x0, name =3D 0x0, unit =3D 0}}, packet_id_p=
ersist_interval =3D {defined =3D false, n =3D 0, last =3D 0}, lzo_compwork =
=3D {defined =3D false, flags =3D 0, wmem =3D 0x0, wmem_size =3D 0, ac =3D =
{compress_state =3D false, next =3D 0, n_total =3D 0, n_comp =3D 0},=20
>               pre_decompress =3D 0, post_decompress =3D 0, pre_compress =
=3D 0, post_compress =3D 0}, buffers =3D 0x0, buffers_owned =3D false, buf =
=3D {capacity =3D 0, offset =3D 0, len =3D 0, data =3D 0x0}, to_tun =3D {ca=
pacity =3D 0, offset =3D 0, len =3D 0, data =3D 0x0}, to_link =3D {capacity=
 =3D 0,=20
>               offset =3D 0, len =3D 0, data =3D 0x0}, ipv4_tun =3D false,=
 log_rw =3D false, route_wakeup =3D {defined =3D false, n =3D 0, last =3D 0=
}, route_wakeup_expire =3D {defined =3D false, n =3D 0, last =3D 0}, did_op=
en_tun =3D false, timeval =3D {tv_sec =3D 0, tv_usec =3D 0},=20
>             coarse_timer_wakeup =3D 0, update_timeout_random_component =
=3D 0, timeout_random_component =3D {tv_sec =3D 0, tv_usec =3D 0}, do_up_ra=
n =3D false, explicit_exit_notification_time_wait =3D 0, explicit_exit_noti=
fication_interval =3D {defined =3D false, n =3D 0, last =3D 0},=20
>             es =3D 0x801806230, es_owned =3D true, fast_io =3D false, pus=
h_reply_deferred =3D false, push_ifconfig_defined =3D false, sent_push_repl=
y_expiry =3D 0, push_ifconfig_local =3D 0, push_ifconfig_remote_netmask =3D=
 0, push_ifconfig_local_alias =3D 0,=20
>             push_ifconfig_ipv6_defined =3D false, push_ifconfig_ipv6_loca=
l =3D {__u6_addr =3D {__u6_addr8 =3D '\000' <repeats 15 times>, __u6_addr16=
 =3D {0, 0, 0, 0, 0, 0, 0, 0}, __u6_addr32 =3D {0, 0, 0, 0}}}, push_ifconfi=
g_ipv6_netbits =3D 0, push_ifconfig_ipv6_remote =3D {
>               __u6_addr =3D {__u6_addr8 =3D '\000' <repeats 15 times>, __=
u6_addr16 =3D {0, 0, 0, 0, 0, 0, 0, 0}, __u6_addr32 =3D {0, 0, 0, 0}}}, con=
text_auth =3D 0, push_request_interval =3D {defined =3D false, n =3D 0, las=
t =3D 0}, n_sent_push_requests =3D 0, did_pre_pull_restore =3D false,=20
>             pulled_options_md5_init_done =3D false, pulled_options_state =
=3D {ctx =3D {md_info =3D 0x0, md_ctx =3D 0x0}}, pulled_options_digest =3D =
{digest =3D '\000' <repeats 15 times>}, server_poll_interval =3D {defined =
=3D false, n =3D 0, last =3D 0}, scheduled_exit =3D {defined =3D false,=20
>               n =3D 0, last =3D 0}, scheduled_exit_signal =3D 0, pf =3D {=
enabled =3D false, pfs =3D 0x0, filename =3D 0x0, file_last_mod =3D 0, n_ch=
eck_reload =3D 0, reload =3D {defined =3D false, n =3D 0, last =3D 0}}, mda=
_context =3D {cid =3D 0, flags =3D 0, mda_key_id_counter =3D 0,=20
>               bytecount_last_update =3D 0}}}
> #10 0x000000000044cac2 in main (argc=3D15, argv=3D0x7fffffffde08) at open=
vpn.c:345
> No locals.



