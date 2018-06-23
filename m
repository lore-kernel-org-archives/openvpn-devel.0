References: <20180608052017.6696-1-a@...2181...>
 <20180613141213.5962-1-a@...2181...> <20180620155301.GY57262@...1296...>
 <c416ea67-e4ce-148b-eb19-6d18b35da559@...2181...>
 <20180622094635.GI57262@...1296...>
 <d496bbf5-3c55-f2d9-2ab2-bc89ded80131@...2181...>
 <CAKuzo_jDrcGjQeMaVm3X6yzgKBZecbYHfAAxxCFAuycagTe22Q@...278...>
 <20180622182709.GO57262@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <8117ab50-c3d1-2210-6665-9ea86b7110ac@...2181...>
Date: Sat, 23 Jun 2018 10:07:21 +0800
MIME-Version: 1.0
In-Reply-To: <20180622182709.GO57262@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5U5vbo0iWRJ34WFPrrKFfOSXfQ1ITg12v"
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
To: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5U5vbo0iWRJ34WFPrrKFfOSXfQ1ITg12v
Content-Type: multipart/mixed; boundary="xlzRnxBSmwPBaJCn4NDVr2ZNQ8B8c4mLq";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <8117ab50-c3d1-2210-6665-9ea86b7110ac@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/8] windows: properly configure TAP
 driver when no IPv4 is configured
References: <20180608052017.6696-1-a@...2181...>
 <20180613141213.5962-1-a@...2181...> <20180620155301.GY57262@...1296...>
 <c416ea67-e4ce-148b-eb19-6d18b35da559@...2181...>
 <20180622094635.GI57262@...1296...>
 <d496bbf5-3c55-f2d9-2ab2-bc89ded80131@...2181...>
 <CAKuzo_jDrcGjQeMaVm3X6yzgKBZecbYHfAAxxCFAuycagTe22Q@...278...>
 <20180622182709.GO57262@...1296...>
In-Reply-To: <20180622182709.GO57262@...1296...>

--xlzRnxBSmwPBaJCn4NDVr2ZNQ8B8c4mLq
Content-Type: multipart/mixed;
 boundary="------------51701B1C693F2F1193CA537C"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------51701B1C693F2F1193CA537C
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 23/06/18 02:27, Gert Doering wrote:
> Hi,
>=20
> On Fri, Jun 22, 2018 at 02:12:24PM -0400, Selva Nair wrote:
>> My tap adapter has a link local address (169.254.98.86) on it possibly d=
ue
>> to a previous dhcp failure. May be I need to get rid of that (how?) to
>> activate this code path?
>=20
> I guess this is related - the branch in question is triggered by
> is_on_link(), so maybe in Antonio's case the tap adapter is set to
> 0.0.0.0 - or it actually tried to install a route related to
> redirect-gateway.
>=20
> Are you connecting to your VPN server over IPv6 or IPv4?  You already
> spotted one weirdness with "redirect-gateway !ipv4" which still seems
> to setup "something" in the route_list - so maybe it's related to that,
> but needs "VPN over IPv4" to trigger.
>=20
> In other words, no idea - hoping for a log from Antonio that shows the=20
> "route.exe ..." call with "IF <ifindex>" so we can see what openvpn
> tried to do :-)
>=20

attached you have the log, however there is no message containing
"route.exe ..".

Gert, the ASSERT was triggered with your binary: was it simply master +
2/8 (this patch)?

What I used for my last test is:
* master +
* all the remaining patches from ipv6-only +
* the fix for argv_printf()

The server side is running master + ipv6-only and there is no --server
directive in the configuration.

In the log "Ethernet 2" is the TAP interface".

My guts say that the issue might be related to "gateway-redirect",
because only 8/8 makes sure that no logic is activated for IPv4 and
without that patch there might be some IPv4 route being installed
nonetheless.

Cheers,


--=20
Antonio Quartulli

--------------51701B1C693F2F1193CA537C
Content-Type: text/x-log;
 name="client-lan.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="client-lan.log"

Sat Jun 23 00:38:44 2018 us=3D143551 Current Parameter Settings:
Sat Jun 23 00:38:44 2018 us=3D144050   config =3D 'client-lan.ovpn'
Sat Jun 23 00:38:44 2018 us=3D144050   mode =3D 0
Sat Jun 23 00:38:44 2018 us=3D144531   show_ciphers =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   show_digests =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   show_engines =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   genkey =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   key_pass_file =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D144531   show_tls_ciphers =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   connect_retry_max =3D 0
Sat Jun 23 00:38:44 2018 us=3D144531 Connection profiles [0]:
Sat Jun 23 00:38:44 2018 us=3D144531   proto =3D udp
Sat Jun 23 00:38:44 2018 us=3D144531   local =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D144531   local_port =3D '1194'
Sat Jun 23 00:38:44 2018 us=3D144531   remote =3D '192.168.1.190'
Sat Jun 23 00:38:44 2018 us=3D144531   remote_port =3D '1194'
Sat Jun 23 00:38:44 2018 us=3D144531   remote_float =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   bind_defined =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   bind_local =3D ENABLED
Sat Jun 23 00:38:44 2018 us=3D144531   bind_ipv6_only =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   connect_retry_seconds =3D 5
Sat Jun 23 00:38:44 2018 us=3D144531   connect_timeout =3D 120
Sat Jun 23 00:38:44 2018 us=3D144531   socks_proxy_server =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D144531   socks_proxy_port =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D144531   tun_mtu =3D 1500
Sat Jun 23 00:38:44 2018 us=3D144531   tun_mtu_defined =3D ENABLED
Sat Jun 23 00:38:44 2018 us=3D144531   link_mtu =3D 1500
Sat Jun 23 00:38:44 2018 us=3D144531   link_mtu_defined =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   tun_mtu_extra =3D 0
Sat Jun 23 00:38:44 2018 us=3D144531   tun_mtu_extra_defined =3D DISABLED=

Sat Jun 23 00:38:44 2018 us=3D144531   mtu_discover_type =3D -1
Sat Jun 23 00:38:44 2018 us=3D144531   fragment =3D 0
Sat Jun 23 00:38:44 2018 us=3D144531   mssfix =3D 1450
Sat Jun 23 00:38:44 2018 us=3D144531   explicit_exit_notification =3D 0
Sat Jun 23 00:38:44 2018 us=3D144531 Connection profiles END
Sat Jun 23 00:38:44 2018 us=3D144531   remote_random =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   ipchange =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D144531   dev =3D 'tun'
Sat Jun 23 00:38:44 2018 us=3D144531   dev_type =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D144531   dev_node =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D144531   lladdr =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D144531   topology =3D 1
Sat Jun 23 00:38:44 2018 us=3D144531   ifconfig_local =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D144531   ifconfig_remote_netmask =3D '[UNDE=
F]'
Sat Jun 23 00:38:44 2018 us=3D144531   ifconfig_noexec =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   ifconfig_nowarn =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   ifconfig_ipv6_local =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D144531   ifconfig_ipv6_netbits =3D 0
Sat Jun 23 00:38:44 2018 us=3D144531   ifconfig_ipv6_remote =3D '[UNDEF]'=

Sat Jun 23 00:38:44 2018 us=3D144531   shaper =3D 0
Sat Jun 23 00:38:44 2018 us=3D144531   mtu_test =3D 0
Sat Jun 23 00:38:44 2018 us=3D144531   mlock =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   keepalive_ping =3D 10
Sat Jun 23 00:38:44 2018 us=3D144531   keepalive_timeout =3D 120
Sat Jun 23 00:38:44 2018 us=3D144531   inactivity_timeout =3D 0
Sat Jun 23 00:38:44 2018 us=3D144531   ping_send_timeout =3D 10
Sat Jun 23 00:38:44 2018 us=3D144531   ping_rec_timeout =3D 120
Sat Jun 23 00:38:44 2018 us=3D144531   ping_rec_timeout_action =3D 2
Sat Jun 23 00:38:44 2018 us=3D144531   ping_timer_remote =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   remap_sigusr1 =3D 0
Sat Jun 23 00:38:44 2018 us=3D144531   persist_tun =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   persist_local_ip =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   persist_remote_ip =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   persist_key =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   passtos =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   resolve_retry_seconds =3D 10000000=
00
Sat Jun 23 00:38:44 2018 us=3D144531   resolve_in_advance =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   username =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D144531   groupname =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D144531   chroot_dir =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D144531   cd_dir =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D144531   writepid =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D144531   up_script =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D144531   down_script =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D144531   down_pre =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   up_restart =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   up_delay =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   daemon =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   inetd =3D 0
Sat Jun 23 00:38:44 2018 us=3D144531   log =3D ENABLED
Sat Jun 23 00:38:44 2018 us=3D144531   suppress_timestamps =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D144531   machine_readable_output =3D DISABL=
ED
Sat Jun 23 00:38:44 2018 us=3D144531   nice =3D 0
Sat Jun 23 00:38:44 2018 us=3D144531   verbosity =3D 4
Sat Jun 23 00:38:44 2018 us=3D144531   mute =3D 0
Sat Jun 23 00:38:44 2018 us=3D144531   gremlin =3D 0
Sat Jun 23 00:38:44 2018 us=3D144531   status_file =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D144531   status_file_version =3D 1
Sat Jun 23 00:38:44 2018 us=3D144531   status_file_update_freq =3D 60
Sat Jun 23 00:38:44 2018 us=3D144531   occ =3D ENABLED
Sat Jun 23 00:38:44 2018 us=3D144531   rcvbuf =3D 0
Sat Jun 23 00:38:44 2018 us=3D144531   sndbuf =3D 0
Sat Jun 23 00:38:44 2018 us=3D144531   sockflags =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   fast_io =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145049   comp.alg =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   comp.flags =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   route_script =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145049   route_default_gateway =3D '[UNDEF]=
'
Sat Jun 23 00:38:44 2018 us=3D145049   route_default_metric =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   route_noexec =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145049   route_delay =3D 5
Sat Jun 23 00:38:44 2018 us=3D145049   route_delay_window =3D 30
Sat Jun 23 00:38:44 2018 us=3D145049   route_delay_defined =3D ENABLED
Sat Jun 23 00:38:44 2018 us=3D145049   route_nopull =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145049   route_gateway_via_dhcp =3D DISABLE=
D
Sat Jun 23 00:38:44 2018 us=3D145049   allow_pull_fqdn =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145049   management_addr =3D '127.0.0.1'
Sat Jun 23 00:38:44 2018 us=3D145049   management_port =3D '25340'
Sat Jun 23 00:38:44 2018 us=3D145049   management_user_pass =3D 'stdin'
Sat Jun 23 00:38:44 2018 us=3D145049   management_log_history_cache =3D 2=
50
Sat Jun 23 00:38:44 2018 us=3D145049   management_echo_buffer_size =3D 10=
0
Sat Jun 23 00:38:44 2018 us=3D145049   management_write_peer_info_file =3D=
 '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145049   management_client_user =3D '[UNDEF=
]'
Sat Jun 23 00:38:44 2018 us=3D145049   management_client_group =3D '[UNDE=
F]'
Sat Jun 23 00:38:44 2018 us=3D145049   management_flags =3D 6
Sat Jun 23 00:38:44 2018 us=3D145049   shared_secret_file =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145049   key_direction =3D not set
Sat Jun 23 00:38:44 2018 us=3D145049   ciphername =3D 'AES-256-CBC'
Sat Jun 23 00:38:44 2018 us=3D145049   ncp_enabled =3D ENABLED
Sat Jun 23 00:38:44 2018 us=3D145049   ncp_ciphers =3D 'AES-256-GCM:AES-1=
28-GCM'
Sat Jun 23 00:38:44 2018 us=3D145049   authname =3D 'SHA1'
Sat Jun 23 00:38:44 2018 us=3D145049   prng_hash =3D 'SHA1'
Sat Jun 23 00:38:44 2018 us=3D145049   prng_nonce_secret_len =3D 16
Sat Jun 23 00:38:44 2018 us=3D145049   keysize =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   engine =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145049   replay =3D ENABLED
Sat Jun 23 00:38:44 2018 us=3D145049   mute_replay_warnings =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145049   replay_window =3D 64
Sat Jun 23 00:38:44 2018 us=3D145049   replay_time =3D 15
Sat Jun 23 00:38:44 2018 us=3D145049   packet_id_file =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145049   test_crypto =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145049   tls_server =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145049   tls_client =3D ENABLED
Sat Jun 23 00:38:44 2018 us=3D145049   key_method =3D 2
Sat Jun 23 00:38:44 2018 us=3D145049   ca_file =3D '[[INLINE]]'
Sat Jun 23 00:38:44 2018 us=3D145049   ca_path =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145049   dh_file =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145049   cert_file =3D '[[INLINE]]'
Sat Jun 23 00:38:44 2018 us=3D145049   extra_certs_file =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145049   priv_key_file =3D '[[INLINE]]'
Sat Jun 23 00:38:44 2018 us=3D145049   pkcs12_file =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145049   cryptoapi_cert =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145049   cipher_list =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145049   tls_cert_profile =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145049   tls_verify =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145049   tls_export_cert =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145049   verify_x509_type =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   verify_x509_name =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145049   crl_file =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145049   ns_cert_type =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   remote_cert_ku[i] =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   remote_cert_ku[i] =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   remote_cert_ku[i] =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   remote_cert_ku[i] =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   remote_cert_ku[i] =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   remote_cert_ku[i] =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   remote_cert_ku[i] =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   remote_cert_ku[i] =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   remote_cert_ku[i] =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   remote_cert_ku[i] =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   remote_cert_ku[i] =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   remote_cert_ku[i] =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   remote_cert_ku[i] =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   remote_cert_ku[i] =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   remote_cert_ku[i] =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   remote_cert_ku[i] =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   remote_cert_eku =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145049   ssl_flags =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   tls_timeout =3D 2
Sat Jun 23 00:38:44 2018 us=3D145049   renegotiate_bytes =3D -1
Sat Jun 23 00:38:44 2018 us=3D145049   renegotiate_packets =3D 0
Sat Jun 23 00:38:44 2018 us=3D145049   renegotiate_seconds =3D 3600
Sat Jun 23 00:38:44 2018 us=3D145049   handshake_window =3D 60
Sat Jun 23 00:38:44 2018 us=3D145049   transition_window =3D 3600
Sat Jun 23 00:38:44 2018 us=3D145049   single_session =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145049   push_peer_info =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145049   tls_exit =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145049   tls_auth_file =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145049   tls_crypt_file =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145049   pkcs11_protected_authentication =3D=
 DISABLED
Sat Jun 23 00:38:44 2018 us=3D145049   pkcs11_protected_authentication =3D=
 DISABLED
Sat Jun 23 00:38:44 2018 us=3D145049   pkcs11_protected_authentication =3D=
 DISABLED
Sat Jun 23 00:38:44 2018 us=3D145049   pkcs11_protected_authentication =3D=
 DISABLED
Sat Jun 23 00:38:44 2018 us=3D145049   pkcs11_protected_authentication =3D=
 DISABLED
Sat Jun 23 00:38:44 2018 us=3D145049   pkcs11_protected_authentication =3D=
 DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_protected_authentication =3D=
 DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_protected_authentication =3D=
 DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_protected_authentication =3D=
 DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_protected_authentication =3D=
 DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_protected_authentication =3D=
 DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_protected_authentication =3D=
 DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_protected_authentication =3D=
 DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_protected_authentication =3D=
 DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_protected_authentication =3D=
 DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_protected_authentication =3D=
 DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_private_mode =3D 00000000
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_private_mode =3D 00000000
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_private_mode =3D 00000000
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_private_mode =3D 00000000
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_private_mode =3D 00000000
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_private_mode =3D 00000000
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_private_mode =3D 00000000
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_private_mode =3D 00000000
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_private_mode =3D 00000000
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_private_mode =3D 00000000
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_private_mode =3D 00000000
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_private_mode =3D 00000000
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_private_mode =3D 00000000
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_private_mode =3D 00000000
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_private_mode =3D 00000000
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_private_mode =3D 00000000
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_cert_private =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_cert_private =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_cert_private =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_cert_private =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_cert_private =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_cert_private =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_cert_private =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_cert_private =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_cert_private =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_cert_private =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_cert_private =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_cert_private =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_cert_private =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_cert_private =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_cert_private =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_cert_private =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_pin_cache_period =3D -1
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_id =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145547   pkcs11_id_management =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   server_network =3D 0.0.0.0
Sat Jun 23 00:38:44 2018 us=3D145547   server_netmask =3D 0.0.0.0
Sat Jun 23 00:38:44 2018 us=3D145547   server_network_ipv6 =3D ::
Sat Jun 23 00:38:44 2018 us=3D145547   server_netbits_ipv6 =3D 0
Sat Jun 23 00:38:44 2018 us=3D145547   server_bridge_ip =3D 0.0.0.0
Sat Jun 23 00:38:44 2018 us=3D145547   server_bridge_netmask =3D 0.0.0.0
Sat Jun 23 00:38:44 2018 us=3D145547   server_bridge_pool_start =3D 0.0.0=
=2E0
Sat Jun 23 00:38:44 2018 us=3D145547   server_bridge_pool_end =3D 0.0.0.0=

Sat Jun 23 00:38:44 2018 us=3D145547   ifconfig_pool_defined =3D DISABLED=

Sat Jun 23 00:38:44 2018 us=3D145547   ifconfig_pool_start =3D 0.0.0.0
Sat Jun 23 00:38:44 2018 us=3D145547   ifconfig_pool_end =3D 0.0.0.0
Sat Jun 23 00:38:44 2018 us=3D145547   ifconfig_pool_netmask =3D 0.0.0.0
Sat Jun 23 00:38:44 2018 us=3D145547   ifconfig_pool_persist_filename =3D=
 '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145547   ifconfig_pool_persist_refresh_freq=
 =3D 600
Sat Jun 23 00:38:44 2018 us=3D145547   ifconfig_ipv6_pool_defined =3D DIS=
ABLED
Sat Jun 23 00:38:44 2018 us=3D145547   ifconfig_ipv6_pool_base =3D ::
Sat Jun 23 00:38:44 2018 us=3D145547   ifconfig_ipv6_pool_netbits =3D 0
Sat Jun 23 00:38:44 2018 us=3D145547   n_bcast_buf =3D 256
Sat Jun 23 00:38:44 2018 us=3D145547   tcp_queue_limit =3D 64
Sat Jun 23 00:38:44 2018 us=3D145547   real_hash_size =3D 256
Sat Jun 23 00:38:44 2018 us=3D145547   virtual_hash_size =3D 256
Sat Jun 23 00:38:44 2018 us=3D145547   client_connect_script =3D '[UNDEF]=
'
Sat Jun 23 00:38:44 2018 us=3D145547   learn_address_script =3D '[UNDEF]'=

Sat Jun 23 00:38:44 2018 us=3D145547   client_disconnect_script =3D '[UND=
EF]'
Sat Jun 23 00:38:44 2018 us=3D145547   client_config_dir =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D145547   ccd_exclusive =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D145547   tmp_dir =3D 'C:\Users\Nicol\AppDat=
a\Local\Temp\'
Sat Jun 23 00:38:44 2018 us=3D145547   push_ifconfig_defined =3D DISABLED=

Sat Jun 23 00:38:44 2018 us=3D145547   push_ifconfig_local =3D 0.0.0.0
Sat Jun 23 00:38:44 2018 us=3D145547   push_ifconfig_remote_netmask =3D 0=
=2E0.0.0
Sat Jun 23 00:38:44 2018 us=3D145547   push_ifconfig_ipv6_defined =3D DIS=
ABLED
Sat Jun 23 00:38:44 2018 us=3D145547   push_ifconfig_ipv6_local =3D ::/0
Sat Jun 23 00:38:44 2018 us=3D145547   push_ifconfig_ipv6_remote =3D ::
Sat Jun 23 00:38:44 2018 us=3D146049   enable_c2c =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D146049   duplicate_cn =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D146049   cf_max =3D 0
Sat Jun 23 00:38:44 2018 us=3D146049   cf_per =3D 0
Sat Jun 23 00:38:44 2018 us=3D146049   max_clients =3D 1024
Sat Jun 23 00:38:44 2018 us=3D146049   max_routes_per_client =3D 256
Sat Jun 23 00:38:44 2018 us=3D146049   auth_user_pass_verify_script =3D '=
[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D146049   auth_user_pass_verify_script_via_f=
ile =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D146049   auth_token_generate =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D146049   auth_token_lifetime =3D 0
Sat Jun 23 00:38:44 2018 us=3D146049   client =3D ENABLED
Sat Jun 23 00:38:44 2018 us=3D146049   pull =3D ENABLED
Sat Jun 23 00:38:44 2018 us=3D146049   auth_user_pass_file =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D146049   show_net_up =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D146049   route_method =3D 3
Sat Jun 23 00:38:44 2018 us=3D146049   block_outside_dns =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D146049   ip_win32_defined =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D146049   ip_win32_type =3D 3
Sat Jun 23 00:38:44 2018 us=3D146049   dhcp_masq_offset =3D 0
Sat Jun 23 00:38:44 2018 us=3D146049   dhcp_lease_time =3D 31536000
Sat Jun 23 00:38:44 2018 us=3D146049   tap_sleep =3D 0
Sat Jun 23 00:38:44 2018 us=3D146049   dhcp_options =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D146049   dhcp_renew =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D146049   dhcp_pre_release =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D146049   domain =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D146049   netbios_scope =3D '[UNDEF]'
Sat Jun 23 00:38:44 2018 us=3D146049   netbios_node_type =3D 0
Sat Jun 23 00:38:44 2018 us=3D146049   disable_nbt =3D DISABLED
Sat Jun 23 00:38:44 2018 us=3D146049 OpenVPN 2.5_git x86_64-w64-mingw32 [=
SSL (OpenSSL)] [LZO] [LZ4] [PKCS11] [AEAD] built on Jun 22 2018
Sat Jun 23 00:38:44 2018 us=3D146049 Windows version 6.2 (Windows 8 or gr=
eater) 64bit
Sat Jun 23 00:38:44 2018 us=3D146049 library versions: OpenSSL 1.0.2n  7 =
Dec 2017, LZO 2.10
Enter Management Password:
Sat Jun 23 00:38:44 2018 us=3D146528 MANAGEMENT: TCP Socket listening on =
[AF_INET]127.0.0.1:25340
Sat Jun 23 00:38:44 2018 us=3D146528 Need hold release from management in=
terface, waiting...
Sat Jun 23 00:38:44 2018 us=3D557288 MANAGEMENT: Client connected from [A=
F_INET]127.0.0.1:25340
Sat Jun 23 00:38:44 2018 us=3D663132 MANAGEMENT: CMD 'state on'
Sat Jun 23 00:38:44 2018 us=3D663132 MANAGEMENT: CMD 'log all on'
Sat Jun 23 00:38:44 2018 us=3D789409 MANAGEMENT: CMD 'echo all on'
Sat Jun 23 00:38:44 2018 us=3D791407 MANAGEMENT: CMD 'hold off'
Sat Jun 23 00:38:44 2018 us=3D792919 MANAGEMENT: CMD 'hold release'
Sat Jun 23 00:38:44 2018 us=3D793401 WARNING: No server certificate verif=
ication method has been enabled.  See http://openvpn.net/howto.html#mitm =
for more info.
Sat Jun 23 00:38:44 2018 us=3D897279 Control Channel MTU parms [ L:1621 D=
:1212 EF:38 EB:0 ET:0 EL:3 ]
Sat Jun 23 00:38:44 2018 us=3D897780 Data Channel MTU parms [ L:1621 D:14=
50 EF:121 EB:406 ET:0 EL:3 ]
Sat Jun 23 00:38:44 2018 us=3D897780 Local Options String (VER=3DV4): 'V4=
,dev-type tun,link-mtu 1557,tun-mtu 1500,proto UDPv4,cipher AES-256-CBC,a=
uth SHA1,keysize 256,key-method 2,tls-client'
Sat Jun 23 00:38:44 2018 us=3D897780 Expected Remote Options String (VER=3D=
V4): 'V4,dev-type tun,link-mtu 1557,tun-mtu 1500,proto UDPv4,cipher AES-2=
56-CBC,auth SHA1,keysize 256,key-method 2,tls-server'
Sat Jun 23 00:38:44 2018 us=3D897780 TCP/UDP: Preserving recently used re=
mote address: [AF_INET]192.168.1.190:1194
Sat Jun 23 00:38:44 2018 us=3D897780 Socket Buffers: R=3D[65536->65536] S=
=3D[65536->65536]
Sat Jun 23 00:38:44 2018 us=3D897780 UDP link local (bound): [AF_INET][un=
def]:1194
Sat Jun 23 00:38:44 2018 us=3D897780 UDP link remote: [AF_INET]192.168.1.=
190:1194
Sat Jun 23 00:38:44 2018 us=3D897780 MANAGEMENT: >STATE:1529685524,WAIT,,=
,,,,
Sat Jun 23 00:38:44 2018 us=3D919785 MANAGEMENT: >STATE:1529685524,AUTH,,=
,,,,
Sat Jun 23 00:38:44 2018 us=3D919785 TLS: Initial packet from [AF_INET]19=
2.168.1.190:1194, sid=3D26b4cac9 530ee636
Sat Jun 23 00:38:44 2018 us=3D931266 VERIFY OK: depth=3D1, CN=3DEasy-RSA =
CA
Sat Jun 23 00:38:44 2018 us=3D931787 VERIFY OK: depth=3D0, CN=3Dserver
Sat Jun 23 00:38:44 2018 us=3D945339 Control Channel: TLSv1.2, cipher TLS=
v1/SSLv3 ECDHE-RSA-AES256-GCM-SHA384, 2048 bit RSA
Sat Jun 23 00:38:44 2018 us=3D945339 [server] Peer Connection Initiated w=
ith [AF_INET]192.168.1.190:1194
Sat Jun 23 00:38:46 2018 us=3D20355 MANAGEMENT: >STATE:1529685526,GET_CON=
FIG,,,,,,
Sat Jun 23 00:38:46 2018 us=3D20355 SENT CONTROL [server]: 'PUSH_REQUEST'=
 (status=3D1)
Sat Jun 23 00:38:46 2018 us=3D339449 PUSH: Received control message: 'PUS=
H_REPLY,redirect-gateway !ipv4 ipv6,tun-ipv6,ping 10,ping-restart 120,ifc=
onfig-ipv6 2001:db8:cafe::1000/112 2001:db8:cafe::1,peer-id 0,cipher AES-=
256-GCM'
Sat Jun 23 00:38:46 2018 us=3D339449 OPTIONS IMPORT: timers and/or timeou=
ts modified
Sat Jun 23 00:38:46 2018 us=3D339449 OPTIONS IMPORT: --ifconfig/up option=
s modified
Sat Jun 23 00:38:46 2018 us=3D339449 OPTIONS IMPORT: route options modifi=
ed
Sat Jun 23 00:38:46 2018 us=3D339449 OPTIONS IMPORT: peer-id set
Sat Jun 23 00:38:46 2018 us=3D339449 OPTIONS IMPORT: adjusting link_mtu t=
o 1624
Sat Jun 23 00:38:46 2018 us=3D339449 OPTIONS IMPORT: data channel crypto =
options modified
Sat Jun 23 00:38:46 2018 us=3D339449 Data Channel: using negotiated ciphe=
r 'AES-256-GCM'
Sat Jun 23 00:38:46 2018 us=3D339449 Data Channel MTU parms [ L:1552 D:14=
50 EF:52 EB:406 ET:0 EL:3 ]
Sat Jun 23 00:38:46 2018 us=3D339449 Outgoing Data Channel: Cipher 'AES-2=
56-GCM' initialized with 256 bit key
Sat Jun 23 00:38:46 2018 us=3D339449 Incoming Data Channel: Cipher 'AES-2=
56-GCM' initialized with 256 bit key
Sat Jun 23 00:38:46 2018 us=3D339969 interactive service msg_channel=3D60=
8
Sat Jun 23 00:38:46 2018 us=3D431773 ROUTE_GATEWAY 192.168.1.1/255.255.25=
5.0 I=3D8 HWADDR=3D2c:6e:85:80:d4:aa
Sat Jun 23 00:38:46 2018 us=3D431773 GDG6: remote_host_ipv6=3Dn/a
Sat Jun 23 00:38:46 2018 us=3D431773 GetBestInterfaceEx() returned if=3D8=

Sat Jun 23 00:38:46 2018 us=3D431773 GDG6: II=3D8 DP=3D::/0 NH=3Dfe80::9e=
3d:cfff:feca:d8f0
Sat Jun 23 00:38:46 2018 us=3D431773 GDG6: Metric=3D256, Loopback=3D0, AA=
=3D1, I=3D0
Sat Jun 23 00:38:46 2018 us=3D431773 ROUTE6_GATEWAY fe80::9e3d:cfff:feca:=
d8f0 I=3D8
Sat Jun 23 00:38:46 2018 us=3D431773 open_tun
Sat Jun 23 00:38:46 2018 us=3D432771 TAP-WIN32 device [Ethernet 2] opened=
: \\.\Global\{E780B359-DDDD-4B96-B70F-657F8DC3D55F}.tap
Sat Jun 23 00:38:46 2018 us=3D432771 TAP-Windows Driver Version 9.21=20
Sat Jun 23 00:38:46 2018 us=3D432771 TAP-Windows MTU=3D1500
Sat Jun 23 00:38:46 2018 us=3D433270 Set TAP-Windows TUN with fake IPv4 [=
SUCCEEDED]
Sat Jun 23 00:38:46 2018 us=3D433270 Successful ARP Flush on interface [4=
2] {E780B359-DDDD-4B96-B70F-657F8DC3D55F}
Sat Jun 23 00:38:46 2018 us=3D433270 do_ifconfig, ipv4=3D0, ipv6=3D1
Sat Jun 23 00:38:46 2018 us=3D433270 MANAGEMENT: >STATE:1529685526,ASSIGN=
_IP,,,,,,,2001:db8:cafe::1000
Sat Jun 23 00:38:46 2018 us=3D433270 add_route_ipv6(2001:db8:cafe::/112 -=
> 2001:db8:cafe::1000 metric 0) dev Ethernet 2
Sat Jun 23 00:38:46 2018 us=3D433270 IPv6 route addition via service succ=
eeded
Sat Jun 23 00:38:51 2018 us=3D615720 TEST ROUTES: 0/0 succeeded len=3D-1 =
ret=3D1 a=3D0 u/d=3Dup
Sat Jun 23 00:38:51 2018 us=3D615720 add_route_ipv6(::/3 -> 2001:db8:cafe=
::1 metric -1) dev Ethernet 2
Sat Jun 23 00:38:51 2018 us=3D615965 IPv6 route addition via service succ=
eeded
Sat Jun 23 00:38:51 2018 us=3D615965 add_route_ipv6(2000::/4 -> 2001:db8:=
cafe::1 metric -1) dev Ethernet 2
Sat Jun 23 00:38:51 2018 us=3D615965 IPv6 route addition via service succ=
eeded
Sat Jun 23 00:38:51 2018 us=3D615965 add_route_ipv6(3000::/4 -> 2001:db8:=
cafe::1 metric -1) dev Ethernet 2
Sat Jun 23 00:38:51 2018 us=3D615965 IPv6 route addition via service succ=
eeded
Sat Jun 23 00:38:51 2018 us=3D615965 add_route_ipv6(fc00::/7 -> 2001:db8:=
cafe::1 metric -1) dev Ethernet 2
Sat Jun 23 00:38:51 2018 us=3D615965 IPv6 route addition via service succ=
eeded
Sat Jun 23 00:38:51 2018 us=3D615965 WARNING: this configuration may cach=
e passwords in memory -- use the auth-nocache option to prevent this
Sat Jun 23 00:38:51 2018 us=3D615965 Initialization Sequence Completed
Sat Jun 23 00:38:51 2018 us=3D615965 MANAGEMENT: >STATE:1529685531,CONNEC=
TED,SUCCESS,,192.168.1.190,1194,,,2001:db8:cafe::1000
Sat Jun 23 00:40:39 2018 us=3D283635 TCP/UDP: Closing socket
Sat Jun 23 00:40:39 2018 us=3D283635 delete_route_ipv6(::/3)
Sat Jun 23 00:40:39 2018 us=3D283635 IPv6 route deletion via service succ=
eeded
Sat Jun 23 00:40:39 2018 us=3D284135 delete_route_ipv6(2000::/4)
Sat Jun 23 00:40:39 2018 us=3D284135 IPv6 route deletion via service succ=
eeded
Sat Jun 23 00:40:39 2018 us=3D284135 delete_route_ipv6(3000::/4)
Sat Jun 23 00:40:39 2018 us=3D284135 IPv6 route deletion via service succ=
eeded
Sat Jun 23 00:40:39 2018 us=3D284135 delete_route_ipv6(fc00::/7)
Sat Jun 23 00:40:39 2018 us=3D284633 IPv6 route deletion via service succ=
eeded
Sat Jun 23 00:40:39 2018 us=3D284633 Closing TUN/TAP interface
Sat Jun 23 00:40:39 2018 us=3D284633 delete_route_ipv6(2001:db8:cafe::/11=
2)
Sat Jun 23 00:40:39 2018 us=3D284633 IPv6 route deletion via service succ=
eeded
Sat Jun 23 00:40:39 2018 us=3D392963 NOTE: Release of DHCP-assigned IP ad=
dress lease on TAP-Windows adapter failed: An address has not yet been as=
sociated with the network endpoint.   (code=3D1228)
Sat Jun 23 00:40:39 2018 us=3D393464 SIGTERM[hard,] received, process exi=
ting
Sat Jun 23 00:40:39 2018 us=3D393464 MANAGEMENT: >STATE:1529685639,EXITIN=
G,SIGTERM,,,,,

--------------51701B1C693F2F1193CA537C--

--xlzRnxBSmwPBaJCn4NDVr2ZNQ8B8c4mLq--

--5U5vbo0iWRJ34WFPrrKFfOSXfQ1ITg12v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlstq1kACgkQB6U8WA7y
zXRfzxAAwCE7xXYxQbQcDe1lPbUUJM9OKd9wfufruRF7rEX3RJOATEhnT5T1043w
oAadfCJ1SizEThz8RjhA1BtjURqgbz4/R64dj8fyXdGL12O80PW05rKhf3CCJNU3
pQB3BF8TC9JP2iu/vxKalpNbzT3Cy8pp8wxO3lTFNB4mAkTQHV1BDgLiNdnPfGdi
jh6m4fRUMEYHJRiarDM6GKJPHBHp7FZ4sGCnmkLoy4VYpold2mGQiAuCS+hJbt1F
qnFT9vihw1mvYh7RgLnYHABlFakWRE0SgRZ4MrKgPGkIl5z+nOsrUTMQS880r0uO
WUMLdmNiVqMHlHnsqzZD+eF854rskLPLE7CyycnnGgMEdOqV2+cwp8JFi52fz6bC
r4kGjkj9WUSuWh+Lq5riUSGegiHaOm+TneQRdrOOsImObTKgmHrUr44o01UhGwk1
WgrDiRb/tFsgxTyLiwfqbqMqRV7HTGek50CtcEUZpOJ8JzSuGLTdrKIi4lLefhUL
2UJqCSDRqt0Bu+DY70Ewe7AdB8BjOKb5IFJO92/TYCdhytpsJDypvaQN1HyAkZsH
gJz7ZHkuFfFnKexC2jhQOXXDn/tpfaN0VtrJfhPFN4x74Rw4YMuT5XfWuCWUNLC5
5O2UtNZnqktPIRxoW/n1CTw3k3K+k1X5j0iWulrsOFdKGmODFlo=
=TACZ
-----END PGP SIGNATURE-----

--5U5vbo0iWRJ34WFPrrKFfOSXfQ1ITg12v--

