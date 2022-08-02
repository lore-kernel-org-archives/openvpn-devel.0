Date: Tue, 2 Aug 2022 12:53:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YukCJVgiawTVA59c@...1296...>
References: <20220624083809.23487-12-a@...2181...>
 <20220728194733.27721-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Wy9STORRH4s3M1lo"
Content-Disposition: inline
In-Reply-To: <20220728194733.27721-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 11/25] dco: split option parsing
 routines
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--Wy9STORRH4s3M1lo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 28, 2022 at 09:47:33PM +0200, Antonio Quartulli wrote:
> DCO will try to install keys upon generating them, however, this happens
> when parsing pushed cipher options (due to NCP).
>=20
> For this reason we need to postpone parsing pushed cipher options to *aft=
er*
> the tunnel interface has been opened, otherwise we would have no DCO netd=
ev
> object to operate on.
>=20
> At the same time we split the parsing code, so that we can ensure that
> the NEW_PEER call can happen after the received peer-id has been parsed
> (it is required by all DCO API calls).
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>

Some aspects of this patch I do not like, and others are broken,=20
unfortunately.

What I do not like is the naming of finish_options(), because I find
it confusing in relation to the "first half" of that, do_deferred_options()
- so maybe name this do_deferred_options_crypto()?  But this is somewhat
minor.

What I'm not sure about is the order of things in multi.c - but that
might be due to misunderstanding.  But I wonder why you are calling
"multi_client_generate_tls_keys()" *before* processing the incoming
crypto options in "finish_options()", which call update_crypto_params() -
is there an interdependency?  Or does this not matter?


The "broken" bit is: it breaks udp p2p TLS connections - the server
will segfault.  I guess this is due to moving p2p_ncp around...

The crash manifests as follows:

gdb openvpn
gdb> run server.conf
...
2022-08-02 12:50:45 us=3D144084 net_iface_mtu_set: mtu 1500 for tun5
2022-08-02 12:50:45 us=3D144179 net_iface_up: set tun5 up
2022-08-02 12:50:45 us=3D144241 net_addr_v6_add: fd00:abcd:204:8::1/64 dev =
tun5
2022-08-02 12:50:45 us=3D144396 Data Channel MTU parms [ mss_fix:0 max_frag=
:0 tun_mtu:1500 headroom:136 payload:1736 tailroom:557 ET:0 ]
2022-08-02 12:50:45 us=3D144457 Local Options String (VER=3DV4): 'V4,dev-ty=
pe tun,link-mtu 1545,tun-mtu 1500,proto UDPv4,tun-ipv6,ifconfig 10.204.8.2 =
10.204.8.1,comp-lzo,cipher BF-CBC,auth SHA1,keysize 128,secret'
2022-08-02 12:50:45 us=3D144480 Expected Remote Options String (VER=3DV4): =
'V4,dev-type tun,link-mtu 1545,tun-mtu 1500,proto UDPv4,tun-ipv6,ifconfig 1=
0.204.8.1 10.204.8.2,comp-lzo,cipher BF-CBC,auth SHA1,keysize 128,secret'
2022-08-02 12:50:45 us=3D144539 Socket Buffers: R=3D[212992->212992] S=3D[2=
12992->212992]
2022-08-02 12:50:45 us=3D144568 setsockopt(IPV6_V6ONLY=3D0)
2022-08-02 12:50:45 us=3D144616 UDPv6 link local (bound): [AF_INET6][undef]=
:51204
2022-08-02 12:50:45 us=3D144644 UDPv6 link remote: [AF_UNSPEC]

<waiting, client connects>

2022-08-02 12:52:13 us=3D388007 Peer Connection Initiated with [AF_INET6]::=
ffff:194.97.140.21:19880

Program received signal SIGSEGV, Segmentation fault0x00005555555d38e1 in ch=
eck_session_cipher (session=3Dsession@...1851...=3D0x448, options=3Doptions=
@...1851...=3D0x7fffffffd4d0) at ssl_ncp.c:499
499                                           && streq(options->ciphername,=
 session->opt->config_ciphername);

(gdb) where
#0  0x00005555555d38e1 in check_session_cipher (session=3Dsession@...2686...=
.=3D0x448,=20
    options=3Doptions@...1851...=3D0x7fffffffd4d0) at ssl_ncp.c:499
#1  0x00005555555cab8b in tls_session_update_crypto_params (multi=3D0x0,=20
    session=3D0x448, options=3D0x7fffffffd4d0, frame=3D0x7fffffffe0a0,=20
    frame_fragment=3D0x0, lsi=3D0x55555562bc80) at ssl.c:1716
#2  0x000055555557899f in finish_options (c=3D<optimized out>) at init.c:23=
58
#3  0x0000555555578a65 in do_up (c=3Dc@...1851...=3D0x7fffffffd4d0,=20
    pulled_options=3Dpulled_options@...1851...=3Dfalse,=20
    option_types_found=3Doption_types_found@...1851...=3D0) at init.c:2131
#4  0x0000555555571326 in check_connection_established (c=3D0x7fffffffd4d0)
    at forward.c:311
#5  process_coarse_timers (c=3D0x7fffffffd4d0) at forward.c:634
#6  check_coarse_timers (c=3D0x7fffffffd4d0) at forward.c:717
#7  pre_select (c=3Dc@...1851...=3D0x7fffffffd4d0) at forward.c:1823
#8  0x0000555555597b36 in tunnel_point_to_point (c=3D0x7fffffffd4d0)
    at openvpn.c:79
#9  openvpn_main (argc=3D2, argv=3D0x7fffffffe638) at openvpn.c:311
#10 0x00007ffff7cc21ea in ?? () from /lib64/libc.so.6
#11 0x00007ffff7cc229c in __libc_start_main () from /lib64/libc.so.6
#12 0x000055555555c0b1 in _start ()


gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Wy9STORRH4s3M1lo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi6QIlAAoJEB2Cnv7KVigS0awMAJ3fDYSZ5GLOIls4k2z1MFsJ
6UJab/rykRAStbURYNIWG8kGGxxb97iFCGst0m/luGfdYUjI/0fDZt9Xiaog8536
ty4YmmhR6w8z3V0z/GQLANih96Ju6nIQxsvVKhWFX80iTnx4J2+gnB9gBhJMYmWI
6HX+ZD4F1Fe0W/+qRvVg4NDuVs8UCkP6Bix2bn3LiW1bJFlCZH9y4yOz57uhoSE1
xwwE8w49LPwnIRfqsIXNBRtX00BV40yXAlq2qMx11vRsb7QYZ+pBRz92JzTfWCmG
tPPuFt3dilwuAtzmn4W1hU7Wepzhf0s1jCggzIzDP5w6g+bFcx+89YCh1mNP/dWm
4rQ5z6gRjda9TcQlsP7oPeggpjKV/JzcoS9AkV3cN0eA0jKrIBc7rE7/y5PyVFdR
B/jT9fiHcWT94BCRUwefAJ7TgemsfFcBTuJl5KgwSXE7yCEoAWiBHMzlrTjcag5w
eWZSLY70r6zphq28vqCVau5S3jQoBgxkmm4wPSiIAQ==
=i0kT
-----END PGP SIGNATURE-----

--Wy9STORRH4s3M1lo--

