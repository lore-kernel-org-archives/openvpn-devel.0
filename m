References: <20180608052017.6696-1-a@...2181...>
 <20180613141213.5962-1-a@...2181...> <20180620155301.GY57262@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <c416ea67-e4ce-148b-eb19-6d18b35da559@...2181...>
Date: Fri, 22 Jun 2018 15:27:02 +0800
MIME-Version: 1.0
In-Reply-To: <20180620155301.GY57262@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="i0G9mKq468dWbcmMFCm4cjuLf7V7sWQoK"
Subject: Re: [Openvpn-devel] [PATCH v3 2/8] windows: properly configure TAP
 driver when no IPv4 is configured
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i0G9mKq468dWbcmMFCm4cjuLf7V7sWQoK
Content-Type: multipart/mixed; boundary="YVkFGt1EaBk7v7iFsJUXAfWUzKUOmjOeW";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <c416ea67-e4ce-148b-eb19-6d18b35da559@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/8] windows: properly configure TAP
 driver when no IPv4 is configured
References: <20180608052017.6696-1-a@...2181...>
 <20180613141213.5962-1-a@...2181...> <20180620155301.GY57262@...1296...>
In-Reply-To: <20180620155301.GY57262@...1296...>

--YVkFGt1EaBk7v7iFsJUXAfWUzKUOmjOeW
Content-Type: multipart/mixed;
 boundary="------------8968377C7E19E8788D7573AA"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------8968377C7E19E8788D7573AA
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 20/06/18 23:53, Gert Doering wrote:
[cut]
>=20
> ... because it's just "tt" here, so "tt->did_ifconfig_setup" should
> be fine...  at least it compiled :-) - I've sent you a link to an=20
> installer for testing.
>

Thanks for the installer Gert!
I just tried it on Windows 10 (not my laptop! just in case somebody
thinks I use Windows :-P) and unfortunately it does not work as expected.

The failure is reported as:

TUN: adding address failed using service: The parameter is incorrect.
[status=3D87 if_index=3D42]

I have to double check the code to understand what is different from
what Selva tested. In the meantime, you have the full log attached to
this email in case somebody wants to give it a look.


Cheers,

--=20
Antonio Quartulli

--------------8968377C7E19E8788D7573AA
Content-Type: text/x-log;
 name="windows-broken.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="windows-broken.log"

Fri Jun 22 13:43:48 2018 us=3D883035 Current Parameter Settings:
Fri Jun 22 13:43:48 2018 us=3D883535   config =3D 'client-lan.ovpn'
Fri Jun 22 13:43:48 2018 us=3D883535   mode =3D 0
Fri Jun 22 13:43:48 2018 us=3D883535   show_ciphers =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D883535   show_digests =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D883535   show_engines =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D883535   genkey =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D883535   key_pass_file =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D883535   show_tls_ciphers =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D883535   connect_retry_max =3D 0
Fri Jun 22 13:43:48 2018 us=3D883535 Connection profiles [0]:
Fri Jun 22 13:43:48 2018 us=3D883535   proto =3D udp
Fri Jun 22 13:43:48 2018 us=3D883535   local =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D883535   local_port =3D '1194'
Fri Jun 22 13:43:48 2018 us=3D883535   remote =3D '192.168.1.190'
Fri Jun 22 13:43:48 2018 us=3D883535   remote_port =3D '1194'
Fri Jun 22 13:43:48 2018 us=3D883535   remote_float =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D883535   bind_defined =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D883535   bind_local =3D ENABLED
Fri Jun 22 13:43:48 2018 us=3D883535   bind_ipv6_only =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D883535   connect_retry_seconds =3D 5
Fri Jun 22 13:43:48 2018 us=3D883535   connect_timeout =3D 120
Fri Jun 22 13:43:48 2018 us=3D883535   socks_proxy_server =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D883535   socks_proxy_port =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D883535   tun_mtu =3D 1500
Fri Jun 22 13:43:48 2018 us=3D883535   tun_mtu_defined =3D ENABLED
Fri Jun 22 13:43:48 2018 us=3D884034   link_mtu =3D 1500
Fri Jun 22 13:43:48 2018 us=3D884034   link_mtu_defined =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   tun_mtu_extra =3D 0
Fri Jun 22 13:43:48 2018 us=3D884034   tun_mtu_extra_defined =3D DISABLED=

Fri Jun 22 13:43:48 2018 us=3D884034   mtu_discover_type =3D -1
Fri Jun 22 13:43:48 2018 us=3D884034   fragment =3D 0
Fri Jun 22 13:43:48 2018 us=3D884034   mssfix =3D 1450
Fri Jun 22 13:43:48 2018 us=3D884034   explicit_exit_notification =3D 0
Fri Jun 22 13:43:48 2018 us=3D884034 Connection profiles END
Fri Jun 22 13:43:48 2018 us=3D884034   remote_random =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   ipchange =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884034   dev =3D 'tun'
Fri Jun 22 13:43:48 2018 us=3D884034   dev_type =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884034   dev_node =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884034   lladdr =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884034   topology =3D 1
Fri Jun 22 13:43:48 2018 us=3D884034   ifconfig_local =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884034   ifconfig_remote_netmask =3D '[UNDE=
F]'
Fri Jun 22 13:43:48 2018 us=3D884034   ifconfig_noexec =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   ifconfig_nowarn =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   ifconfig_ipv6_local =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884034   ifconfig_ipv6_netbits =3D 0
Fri Jun 22 13:43:48 2018 us=3D884034   ifconfig_ipv6_remote =3D '[UNDEF]'=

Fri Jun 22 13:43:48 2018 us=3D884034   shaper =3D 0
Fri Jun 22 13:43:48 2018 us=3D884034   mtu_test =3D 0
Fri Jun 22 13:43:48 2018 us=3D884034   mlock =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   keepalive_ping =3D 10
Fri Jun 22 13:43:48 2018 us=3D884034   keepalive_timeout =3D 120
Fri Jun 22 13:43:48 2018 us=3D884034   inactivity_timeout =3D 0
Fri Jun 22 13:43:48 2018 us=3D884034   ping_send_timeout =3D 10
Fri Jun 22 13:43:48 2018 us=3D884034   ping_rec_timeout =3D 120
Fri Jun 22 13:43:48 2018 us=3D884034   ping_rec_timeout_action =3D 2
Fri Jun 22 13:43:48 2018 us=3D884034   ping_timer_remote =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   remap_sigusr1 =3D 0
Fri Jun 22 13:43:48 2018 us=3D884034   persist_tun =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   persist_local_ip =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   persist_remote_ip =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   persist_key =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   passtos =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   resolve_retry_seconds =3D 10000000=
00
Fri Jun 22 13:43:48 2018 us=3D884034   resolve_in_advance =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   username =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884034   groupname =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884034   chroot_dir =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884034   cd_dir =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884034   writepid =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884034   up_script =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884034   down_script =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884034   down_pre =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   up_restart =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   up_delay =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   daemon =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   inetd =3D 0
Fri Jun 22 13:43:48 2018 us=3D884034   log =3D ENABLED
Fri Jun 22 13:43:48 2018 us=3D884034   suppress_timestamps =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   machine_readable_output =3D DISABL=
ED
Fri Jun 22 13:43:48 2018 us=3D884034   nice =3D 0
Fri Jun 22 13:43:48 2018 us=3D884034   verbosity =3D 4
Fri Jun 22 13:43:48 2018 us=3D884034   mute =3D 0
Fri Jun 22 13:43:48 2018 us=3D884034   gremlin =3D 0
Fri Jun 22 13:43:48 2018 us=3D884034   status_file =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884034   status_file_version =3D 1
Fri Jun 22 13:43:48 2018 us=3D884034   status_file_update_freq =3D 60
Fri Jun 22 13:43:48 2018 us=3D884034   occ =3D ENABLED
Fri Jun 22 13:43:48 2018 us=3D884034   rcvbuf =3D 0
Fri Jun 22 13:43:48 2018 us=3D884034   sndbuf =3D 0
Fri Jun 22 13:43:48 2018 us=3D884034   sockflags =3D 0
Fri Jun 22 13:43:48 2018 us=3D884034   fast_io =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   comp.alg =3D 0
Fri Jun 22 13:43:48 2018 us=3D884034   comp.flags =3D 0
Fri Jun 22 13:43:48 2018 us=3D884034   route_script =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884034   route_default_gateway =3D '[UNDEF]=
'
Fri Jun 22 13:43:48 2018 us=3D884034   route_default_metric =3D 0
Fri Jun 22 13:43:48 2018 us=3D884034   route_noexec =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   route_delay =3D 5
Fri Jun 22 13:43:48 2018 us=3D884034   route_delay_window =3D 30
Fri Jun 22 13:43:48 2018 us=3D884034   route_delay_defined =3D ENABLED
Fri Jun 22 13:43:48 2018 us=3D884034   route_nopull =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   route_gateway_via_dhcp =3D DISABLE=
D
Fri Jun 22 13:43:48 2018 us=3D884034   allow_pull_fqdn =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884034   management_addr =3D '127.0.0.1'
Fri Jun 22 13:43:48 2018 us=3D884034   management_port =3D '25340'
Fri Jun 22 13:43:48 2018 us=3D884034   management_user_pass =3D 'stdin'
Fri Jun 22 13:43:48 2018 us=3D884034   management_log_history_cache =3D 2=
50
Fri Jun 22 13:43:48 2018 us=3D884034   management_echo_buffer_size =3D 10=
0
Fri Jun 22 13:43:48 2018 us=3D884034   management_write_peer_info_file =3D=
 '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884034   management_client_user =3D '[UNDEF=
]'
Fri Jun 22 13:43:48 2018 us=3D884034   management_client_group =3D '[UNDE=
F]'
Fri Jun 22 13:43:48 2018 us=3D884532   management_flags =3D 6
Fri Jun 22 13:43:48 2018 us=3D884532   shared_secret_file =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884532   key_direction =3D not set
Fri Jun 22 13:43:48 2018 us=3D884532   ciphername =3D 'AES-256-CBC'
Fri Jun 22 13:43:48 2018 us=3D884532   ncp_enabled =3D ENABLED
Fri Jun 22 13:43:48 2018 us=3D884532   ncp_ciphers =3D 'AES-256-GCM:AES-1=
28-GCM'
Fri Jun 22 13:43:48 2018 us=3D884532   authname =3D 'SHA1'
Fri Jun 22 13:43:48 2018 us=3D884532   prng_hash =3D 'SHA1'
Fri Jun 22 13:43:48 2018 us=3D884532   prng_nonce_secret_len =3D 16
Fri Jun 22 13:43:48 2018 us=3D884532   keysize =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   engine =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   replay =3D ENABLED
Fri Jun 22 13:43:48 2018 us=3D884532   mute_replay_warnings =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   replay_window =3D 64
Fri Jun 22 13:43:48 2018 us=3D884532   replay_time =3D 15
Fri Jun 22 13:43:48 2018 us=3D884532   packet_id_file =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884532   test_crypto =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   tls_server =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   tls_client =3D ENABLED
Fri Jun 22 13:43:48 2018 us=3D884532   key_method =3D 2
Fri Jun 22 13:43:48 2018 us=3D884532   ca_file =3D '[[INLINE]]'
Fri Jun 22 13:43:48 2018 us=3D884532   ca_path =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884532   dh_file =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884532   cert_file =3D '[[INLINE]]'
Fri Jun 22 13:43:48 2018 us=3D884532   extra_certs_file =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884532   priv_key_file =3D '[[INLINE]]'
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs12_file =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884532   cryptoapi_cert =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884532   cipher_list =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884532   tls_cert_profile =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884532   tls_verify =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884532   tls_export_cert =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884532   verify_x509_type =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   verify_x509_name =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884532   crl_file =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884532   ns_cert_type =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   remote_cert_ku[i] =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   remote_cert_ku[i] =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   remote_cert_ku[i] =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   remote_cert_ku[i] =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   remote_cert_ku[i] =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   remote_cert_ku[i] =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   remote_cert_ku[i] =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   remote_cert_ku[i] =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   remote_cert_ku[i] =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   remote_cert_ku[i] =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   remote_cert_ku[i] =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   remote_cert_ku[i] =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   remote_cert_ku[i] =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   remote_cert_ku[i] =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   remote_cert_ku[i] =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   remote_cert_ku[i] =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   remote_cert_eku =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884532   ssl_flags =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   tls_timeout =3D 2
Fri Jun 22 13:43:48 2018 us=3D884532   renegotiate_bytes =3D -1
Fri Jun 22 13:43:48 2018 us=3D884532   renegotiate_packets =3D 0
Fri Jun 22 13:43:48 2018 us=3D884532   renegotiate_seconds =3D 3600
Fri Jun 22 13:43:48 2018 us=3D884532   handshake_window =3D 60
Fri Jun 22 13:43:48 2018 us=3D884532   transition_window =3D 3600
Fri Jun 22 13:43:48 2018 us=3D884532   single_session =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   push_peer_info =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   tls_exit =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   tls_auth_file =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884532   tls_crypt_file =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_protected_authentication =3D=
 DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_protected_authentication =3D=
 DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_protected_authentication =3D=
 DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_protected_authentication =3D=
 DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_protected_authentication =3D=
 DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_protected_authentication =3D=
 DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_protected_authentication =3D=
 DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_protected_authentication =3D=
 DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_protected_authentication =3D=
 DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_protected_authentication =3D=
 DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_protected_authentication =3D=
 DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_protected_authentication =3D=
 DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_protected_authentication =3D=
 DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_protected_authentication =3D=
 DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_protected_authentication =3D=
 DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_protected_authentication =3D=
 DISABLED
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_private_mode =3D 00000000
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_private_mode =3D 00000000
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_private_mode =3D 00000000
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_private_mode =3D 00000000
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_private_mode =3D 00000000
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_private_mode =3D 00000000
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_private_mode =3D 00000000
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_private_mode =3D 00000000
Fri Jun 22 13:43:48 2018 us=3D884532   pkcs11_private_mode =3D 00000000
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_private_mode =3D 00000000
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_private_mode =3D 00000000
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_private_mode =3D 00000000
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_private_mode =3D 00000000
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_private_mode =3D 00000000
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_private_mode =3D 00000000
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_private_mode =3D 00000000
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_cert_private =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_cert_private =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_cert_private =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_cert_private =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_cert_private =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_cert_private =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_cert_private =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_cert_private =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_cert_private =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_cert_private =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_cert_private =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_cert_private =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_cert_private =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_cert_private =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_cert_private =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_cert_private =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_pin_cache_period =3D -1
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_id =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D885031   pkcs11_id_management =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   server_network =3D 0.0.0.0
Fri Jun 22 13:43:48 2018 us=3D885031   server_netmask =3D 0.0.0.0
Fri Jun 22 13:43:48 2018 us=3D885031   server_network_ipv6 =3D ::
Fri Jun 22 13:43:48 2018 us=3D885031   server_netbits_ipv6 =3D 0
Fri Jun 22 13:43:48 2018 us=3D885031   server_bridge_ip =3D 0.0.0.0
Fri Jun 22 13:43:48 2018 us=3D885031   server_bridge_netmask =3D 0.0.0.0
Fri Jun 22 13:43:48 2018 us=3D885031   server_bridge_pool_start =3D 0.0.0=
=2E0
Fri Jun 22 13:43:48 2018 us=3D885031   server_bridge_pool_end =3D 0.0.0.0=

Fri Jun 22 13:43:48 2018 us=3D885031   ifconfig_pool_defined =3D DISABLED=

Fri Jun 22 13:43:48 2018 us=3D885031   ifconfig_pool_start =3D 0.0.0.0
Fri Jun 22 13:43:48 2018 us=3D885031   ifconfig_pool_end =3D 0.0.0.0
Fri Jun 22 13:43:48 2018 us=3D885031   ifconfig_pool_netmask =3D 0.0.0.0
Fri Jun 22 13:43:48 2018 us=3D885031   ifconfig_pool_persist_filename =3D=
 '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D885031   ifconfig_pool_persist_refresh_freq=
 =3D 600
Fri Jun 22 13:43:48 2018 us=3D885031   ifconfig_ipv6_pool_defined =3D DIS=
ABLED
Fri Jun 22 13:43:48 2018 us=3D885031   ifconfig_ipv6_pool_base =3D ::
Fri Jun 22 13:43:48 2018 us=3D885031   ifconfig_ipv6_pool_netbits =3D 0
Fri Jun 22 13:43:48 2018 us=3D885031   n_bcast_buf =3D 256
Fri Jun 22 13:43:48 2018 us=3D885031   tcp_queue_limit =3D 64
Fri Jun 22 13:43:48 2018 us=3D885031   real_hash_size =3D 256
Fri Jun 22 13:43:48 2018 us=3D885031   virtual_hash_size =3D 256
Fri Jun 22 13:43:48 2018 us=3D885031   client_connect_script =3D '[UNDEF]=
'
Fri Jun 22 13:43:48 2018 us=3D885031   learn_address_script =3D '[UNDEF]'=

Fri Jun 22 13:43:48 2018 us=3D885031   client_disconnect_script =3D '[UND=
EF]'
Fri Jun 22 13:43:48 2018 us=3D885031   client_config_dir =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D885031   ccd_exclusive =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   tmp_dir =3D 'C:\Users\Nicol\AppDat=
a\Local\Temp\'
Fri Jun 22 13:43:48 2018 us=3D885031   push_ifconfig_defined =3D DISABLED=

Fri Jun 22 13:43:48 2018 us=3D885031   push_ifconfig_local =3D 0.0.0.0
Fri Jun 22 13:43:48 2018 us=3D885031   push_ifconfig_remote_netmask =3D 0=
=2E0.0.0
Fri Jun 22 13:43:48 2018 us=3D885031   push_ifconfig_ipv6_defined =3D DIS=
ABLED
Fri Jun 22 13:43:48 2018 us=3D885031   push_ifconfig_ipv6_local =3D ::/0
Fri Jun 22 13:43:48 2018 us=3D885031   push_ifconfig_ipv6_remote =3D ::
Fri Jun 22 13:43:48 2018 us=3D885031   enable_c2c =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   duplicate_cn =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   cf_max =3D 0
Fri Jun 22 13:43:48 2018 us=3D885031   cf_per =3D 0
Fri Jun 22 13:43:48 2018 us=3D885031   max_clients =3D 1024
Fri Jun 22 13:43:48 2018 us=3D885031   max_routes_per_client =3D 256
Fri Jun 22 13:43:48 2018 us=3D885031   auth_user_pass_verify_script =3D '=
[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D885031   auth_user_pass_verify_script_via_f=
ile =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   auth_token_generate =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   auth_token_lifetime =3D 0
Fri Jun 22 13:43:48 2018 us=3D885031   client =3D ENABLED
Fri Jun 22 13:43:48 2018 us=3D885031   pull =3D ENABLED
Fri Jun 22 13:43:48 2018 us=3D885031   auth_user_pass_file =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D885031   show_net_up =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   route_method =3D 3
Fri Jun 22 13:43:48 2018 us=3D885031   block_outside_dns =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   ip_win32_defined =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   ip_win32_type =3D 3
Fri Jun 22 13:43:48 2018 us=3D885031   dhcp_masq_offset =3D 0
Fri Jun 22 13:43:48 2018 us=3D885031   dhcp_lease_time =3D 31536000
Fri Jun 22 13:43:48 2018 us=3D885031   tap_sleep =3D 0
Fri Jun 22 13:43:48 2018 us=3D885031   dhcp_options =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   dhcp_renew =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885031   dhcp_pre_release =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885530   domain =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D885530   netbios_scope =3D '[UNDEF]'
Fri Jun 22 13:43:48 2018 us=3D885530   netbios_node_type =3D 0
Fri Jun 22 13:43:48 2018 us=3D885530   disable_nbt =3D DISABLED
Fri Jun 22 13:43:48 2018 us=3D885530 OpenVPN 2.5_git x86_64-w64-mingw32 [=
SSL (OpenSSL)] [LZO] [LZ4] [PKCS11] [AEAD] built on Jun 20 2018
Fri Jun 22 13:43:48 2018 us=3D885530 Windows version 6.2 (Windows 8 or gr=
eater) 64bit
Fri Jun 22 13:43:48 2018 us=3D885530 library versions: OpenSSL 1.0.2n  7 =
Dec 2017, LZO 2.10
Enter Management Password:
Fri Jun 22 13:43:48 2018 us=3D886030 MANAGEMENT: TCP Socket listening on =
[AF_INET]127.0.0.1:25340
Fri Jun 22 13:43:48 2018 us=3D886030 Need hold release from management in=
terface, waiting...
Fri Jun 22 13:43:49 2018 us=3D188374 MANAGEMENT: Client connected from [A=
F_INET]127.0.0.1:25340
Fri Jun 22 13:43:49 2018 us=3D289279 MANAGEMENT: CMD 'state on'
Fri Jun 22 13:43:49 2018 us=3D289279 MANAGEMENT: CMD 'log all on'
Fri Jun 22 13:43:49 2018 us=3D418667 MANAGEMENT: CMD 'echo all on'
Fri Jun 22 13:43:49 2018 us=3D420666 MANAGEMENT: CMD 'hold off'
Fri Jun 22 13:43:49 2018 us=3D421661 MANAGEMENT: CMD 'hold release'
Fri Jun 22 13:43:49 2018 us=3D422162 WARNING: No server certificate verif=
ication method has been enabled.  See http://openvpn.net/howto.html#mitm =
for more info.
Fri Jun 22 13:43:49 2018 us=3D529463 Control Channel MTU parms [ L:1621 D=
:1212 EF:38 EB:0 ET:0 EL:3 ]
Fri Jun 22 13:43:49 2018 us=3D529463 Data Channel MTU parms [ L:1621 D:14=
50 EF:121 EB:406 ET:0 EL:3 ]
Fri Jun 22 13:43:49 2018 us=3D529463 Local Options String (VER=3DV4): 'V4=
,dev-type tun,link-mtu 1557,tun-mtu 1500,proto UDPv4,cipher AES-256-CBC,a=
uth SHA1,keysize 256,key-method 2,tls-client'
Fri Jun 22 13:43:49 2018 us=3D529463 Expected Remote Options String (VER=3D=
V4): 'V4,dev-type tun,link-mtu 1557,tun-mtu 1500,proto UDPv4,cipher AES-2=
56-CBC,auth SHA1,keysize 256,key-method 2,tls-server'
Fri Jun 22 13:43:49 2018 us=3D529463 TCP/UDP: Preserving recently used re=
mote address: [AF_INET]192.168.1.190:1194
Fri Jun 22 13:43:49 2018 us=3D529463 Socket Buffers: R=3D[65536->65536] S=
=3D[65536->65536]
Fri Jun 22 13:43:49 2018 us=3D529962 UDP link local (bound): [AF_INET][un=
def]:1194
Fri Jun 22 13:43:49 2018 us=3D529962 UDP link remote: [AF_INET]192.168.1.=
190:1194
Fri Jun 22 13:43:49 2018 us=3D529962 MANAGEMENT: >STATE:1529646229,WAIT,,=
,,,,
Fri Jun 22 13:43:49 2018 us=3D667818 MANAGEMENT: >STATE:1529646229,AUTH,,=
,,,,
Fri Jun 22 13:43:49 2018 us=3D667818 TLS: Initial packet from [AF_INET]19=
2.168.1.190:1194, sid=3D63a560b7 d2d590fb
Fri Jun 22 13:43:49 2018 us=3D677343 VERIFY OK: depth=3D1, CN=3DEasy-RSA =
CA
Fri Jun 22 13:43:49 2018 us=3D677842 VERIFY OK: depth=3D0, CN=3Dserver
Fri Jun 22 13:43:49 2018 us=3D687341 Control Channel: TLSv1.2, cipher TLS=
v1/SSLv3 ECDHE-RSA-AES256-GCM-SHA384, 2048 bit RSA
Fri Jun 22 13:43:49 2018 us=3D687341 [server] Peer Connection Initiated w=
ith [AF_INET]192.168.1.190:1194
Fri Jun 22 13:43:50 2018 us=3D886603 MANAGEMENT: >STATE:1529646230,GET_CO=
NFIG,,,,,,
Fri Jun 22 13:43:50 2018 us=3D886603 SENT CONTROL [server]: 'PUSH_REQUEST=
' (status=3D1)
Fri Jun 22 13:43:51 2018 us=3D116232 PUSH: Received control message: 'PUS=
H_REPLY,redirect-gateway !ipv4 ipv6,tun-ipv6,ping 10,ping-restart 120,ifc=
onfig-ipv6 2002::1001/112 2002::2,peer-id 0,cipher AES-256-GCM'
Fri Jun 22 13:43:51 2018 us=3D116232 OPTIONS IMPORT: timers and/or timeou=
ts modified
Fri Jun 22 13:43:51 2018 us=3D116232 OPTIONS IMPORT: --ifconfig/up option=
s modified
Fri Jun 22 13:43:51 2018 us=3D116232 OPTIONS IMPORT: route options modifi=
ed
Fri Jun 22 13:43:51 2018 us=3D116232 OPTIONS IMPORT: peer-id set
Fri Jun 22 13:43:51 2018 us=3D116232 OPTIONS IMPORT: adjusting link_mtu t=
o 1624
Fri Jun 22 13:43:51 2018 us=3D116232 OPTIONS IMPORT: data channel crypto =
options modified
Fri Jun 22 13:43:51 2018 us=3D116232 Data Channel: using negotiated ciphe=
r 'AES-256-GCM'
Fri Jun 22 13:43:51 2018 us=3D116232 Data Channel MTU parms [ L:1552 D:14=
50 EF:52 EB:406 ET:0 EL:3 ]
Fri Jun 22 13:43:51 2018 us=3D116232 Outgoing Data Channel: Cipher 'AES-2=
56-GCM' initialized with 256 bit key
Fri Jun 22 13:43:51 2018 us=3D116232 Incoming Data Channel: Cipher 'AES-2=
56-GCM' initialized with 256 bit key
Fri Jun 22 13:43:51 2018 us=3D116232 interactive service msg_channel=3D73=
6
Fri Jun 22 13:43:51 2018 us=3D214906 ROUTE_GATEWAY 192.168.1.1/255.255.25=
5.0 I=3D8 HWADDR=3D2c:6e:85:80:d4:aa
Fri Jun 22 13:43:51 2018 us=3D228188 GDG6: remote_host_ipv6=3Dn/a
Fri Jun 22 13:43:51 2018 us=3D228188 GetBestInterfaceEx() returned if=3D8=

Fri Jun 22 13:43:51 2018 us=3D228188 GDG6: II=3D8 DP=3D::/0 NH=3Dfe80::9e=
3d:cfff:feca:d8f0
Fri Jun 22 13:43:51 2018 us=3D228188 GDG6: Metric=3D256, Loopback=3D0, AA=
=3D1, I=3D0
Fri Jun 22 13:43:51 2018 us=3D228188 ROUTE6_GATEWAY fe80::9e3d:cfff:feca:=
d8f0 I=3D8
Fri Jun 22 13:43:51 2018 us=3D228688 open_tun
Fri Jun 22 13:43:51 2018 us=3D229170 TAP-WIN32 device [Ethernet 2] opened=
: \\.\Global\{E780B359-DDDD-4B96-B70F-657F8DC3D55F}.tap
Fri Jun 22 13:43:51 2018 us=3D229685 TAP-Windows Driver Version 9.21=20
Fri Jun 22 13:43:51 2018 us=3D229685 TAP-Windows MTU=3D1500
Fri Jun 22 13:43:51 2018 us=3D229685 Set TAP-Windows TUN with fake IPv4 [=
SUCCEEDED]
Fri Jun 22 13:43:51 2018 us=3D230166 Successful ARP Flush on interface [4=
2] {E780B359-DDDD-4B96-B70F-657F8DC3D55F}
Fri Jun 22 13:43:51 2018 us=3D230166 do_ifconfig, ipv4=3D0, ipv6=3D1
Fri Jun 22 13:43:51 2018 us=3D230166 MANAGEMENT: >STATE:1529646231,ASSIGN=
_IP,,,,,,,2002::1001
Fri Jun 22 13:43:51 2018 us=3D230665 TUN: adding address failed using ser=
vice: The parameter is incorrect.   [status=3D87 if_index=3D42]
Fri Jun 22 13:43:51 2018 us=3D230665 add_route_ipv6(2002::/112 -> 2002::1=
001 metric 0) dev Ethernet 2
Fri Jun 22 13:43:51 2018 us=3D230665 IPv6 route addition via service succ=
eeded
Fri Jun 22 13:43:56 2018 us=3D729483 TEST ROUTES: 0/0 succeeded len=3D-1 =
ret=3D1 a=3D0 u/d=3Dup
Fri Jun 22 13:43:56 2018 us=3D729483 MANAGEMENT: Client disconnected
Fri Jun 22 13:43:56 2018 us=3D729483 Assertion failed at argv.c:299 (0)
Fri Jun 22 13:43:56 2018 us=3D729483 Exiting due to fatal error
Fri Jun 22 13:43:56 2018 us=3D729483 Closing TUN/TAP interface
Fri Jun 22 13:43:56 2018 us=3D729483 delete_route_ipv6(2002::/112)
Fri Jun 22 13:43:56 2018 us=3D729980 IPv6 route deletion via service succ=
eeded
Fri Jun 22 13:43:56 2018 us=3D729980 TUN: deleting address failed using s=
ervice: The parameter is incorrect.   [status=3D87 if_index=3D42]
Fri Jun 22 13:43:56 2018 us=3D853901 NOTE: Release of DHCP-assigned IP ad=
dress lease on TAP-Windows adapter failed: An address has not yet been as=
sociated with the network endpoint.   (code=3D1228)

--------------8968377C7E19E8788D7573AA--

--YVkFGt1EaBk7v7iFsJUXAfWUzKUOmjOeW--

--i0G9mKq468dWbcmMFCm4cjuLf7V7sWQoK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsspMkACgkQB6U8WA7y
zXRkShAAufl9HXGXGmOnum4yx3NnSCy3k7ACrCGTm/EKCsQFtoAhCavyZDpzuYnv
38m1UcX9RXpC+W1X0TgWiuTqgxI8QtcP2LPPseLg4ByVDyEEZHI7XR/eNynHpQ/0
67KqrjqU9lPsCet85DihPKoahIBGox+LjLyXiq2o0vUifhrInEc6ef0ToIiG11T9
yRCFCnaMOYYZqcSyifY42zLBimIMsWuEcR2l/ugFokFvDtO3H3JKT8MRvjEY2CPn
kspRuvxxrobwR6L2f8mc1ttzgQswhyXqzF/y375pGyuAbd7BqYKs40vBVmR+DEWw
a6WVc/BSGQK5MBLY+NAb5oD0ZU4Ra75Y4a0HbfkAYJRUpeI1oLKaUcP4pXNKl5EX
HkDKL0/aRiddJmSE5TN9xnO2XcMdAxSXoxoTPrEBe4rvyT//8zeZsj+3LmgqR7i0
Yo6TFKpbsHQz0P8U0qmrpDgAwiN1ATgLUjVAEYe7vqPS/Eefgpt1y03moeejGRlI
Kh3SCvnB1IzfgpGYO26cub1MhyERwsY9rg2SlJ7Iv4vUPajBQeYW90s9kEaem877
834edo63CjJmNDnkjiKSrkjQixnXToqlW6DXP8lnU8kxFd+2u893Qv/1w+CrT+0i
lpA6qo4AqmFNROnIxyoAZte0fdxX1s0cDA+sIBzf4+Vr8n7mC28=
=xb31
-----END PGP SIGNATURE-----

--i0G9mKq468dWbcmMFCm4cjuLf7V7sWQoK--

