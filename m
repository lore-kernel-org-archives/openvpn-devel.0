Date: Sun, 7 Mar 2021 19:40:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210307184019.GR976@...1296...>
References: <20210305141352.21847-1-arne@...1227...>
 <a49bbbe0-c92b-abd9-ac60-000d7b31717f@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="BkLofH2SCg2BlGUz"
Content-Disposition: inline
In-Reply-To: <a49bbbe0-c92b-abd9-ac60-000d7b31717f@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v6] Prefer TLS libraries TLS PRF
 function, fix OpenVPN in FIPS mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--BkLofH2SCg2BlGUz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Mar 06, 2021 at 09:56:36PM +0100, Antonio Quartulli wrote:
> On 05/03/2021 15:13, Arne Schwabe wrote:
> > This moves from using our own copy of the TLS1 PRF function to using
> > TLS library provided function where possible. This includes currently
> > OpenSSL 1.1.0+ and mbed TLS 2.18+.
[..]
> It looks good and passes my basic tests.
>=20
> Acked-by: Antonio Quartulli <antonio@...515...>

ACKs are good, but SIGSEGV are bad.=20=20

This crashes for me on the "--tls-client, but no --client" test case,=20
with "Linux, mbed TLS 2.25.0"  (talking to a server with the same code,
"3338f2d5a2b7 + this patch"

 run openvpn --ca /home/gert/src/openvpn.git-keys/ca.crt --cert /home/gert/=
src/openvpn.git-keys/cron2-gentoo-i386.crt --key /home/gert/src/openvpn.git=
-keys/cron2-gentoo-i386.key     --remote-cert-tls server --nobind --comp-lz=
o --verb 3=20
         --tls-client --dev tap --proto tcp-client --remote gentoo.ov.green=
ie.net 51204 --ifconfig 10.204.9.2 255.255.255.0 --comp-lzo --tun-ipv6 --if=
config-ipv6 fd00:abcd:204:9::2/64 fd00:abcd:204:9::1 --route 10.204.0.0 255=
.255.0.0 10.204.9.1 --route-ipv6 fd00:abcd:204::/48=20
         Segmentation fault

GDB tells me:

...
2021-03-07 19:27:15 ++ Certificate has EKU (str) TLS Web Server Authenticat=
ion, expects TLS Web Server Authentication
2021-03-07 19:27:15 VERIFY EKU OK
2021-03-07 19:27:15 VERIFY OK: depth=3D0, C=3DUS, ST=3DCalifornia, L=3DPlea=
santon, O=3DOpenVPN community project, CN=3Dserver, emailAddress=3Dsamuli@...220...=
..515...

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff7f34ef8 in ?? () from /usr/lib64/libmbedtls.so.13
(gdb) where
#0  0x00007ffff7f34ef8 in ?? () from /usr/lib64/libmbedtls.so.13
#1  0x00007ffff7f35945 in ?? () from /usr/lib64/libmbedtls.so.13
#2  0x00007ffff7f37234 in ?? () from /usr/lib64/libmbedtls.so.13
#3  0x00007ffff7f3a727 in mbedtls_ssl_handshake_client_step () from /usr/li=
b64/libmbedtls.so.13
#4  0x00007ffff7f4c12d in mbedtls_ssl_handshake_step () from /usr/lib64/lib=
mbedtls.so.13
#5  0x00007ffff7f4c1b8 in mbedtls_ssl_handshake () from /usr/lib64/libmbedt=
ls.so.13
#6  0x00007ffff7f429b8 in mbedtls_ssl_read () from /usr/lib64/libmbedtls.so=
.13
#7  0x00005555555d0c38 in key_state_read_plaintext (ks=3Dks@...1851...=3D0x=
555555627d00,=20
    buf=3Dbuf@...1851...=3D0x555555627eb0, maxlen=3Dmaxlen@...1851...=3D204=
8) at ../../../openvpn/src/openvpn/buffer.h:231
#8  0x00005555555c9a38 in tls_process (wakeup=3D0x7fffffffd8b4, to_link_soc=
ket_info=3D<optimized out>,=20
    to_link_addr=3D0x7fffffffd7c8, to_link=3D<optimized out>, session=3D<op=
timized out>, multi=3D0x555555627720)
    at ../../../openvpn/src/openvpn/ssl.c:2806
#9  tls_multi_process (multi=3D0x555555627720, to_link=3Dto_link@...1851...=
=3D0x7fffffffe6d0,=20
    to_link_addr=3Dto_link_addr@...1851...=3D0x7fffffffe3c0, to_link_socket=
_info=3D<optimized out>,=20
    wakeup=3Dwakeup@...1851...=3D0x7fffffffd8d4) at ../../../openvpn/src/op=
envpn/ssl.c:3009
#10 0x000055555556c593 in check_tls (c=3Dc@...1851...=3D0x7fffffffd910) at =
../../../openvpn/src/openvpn/forward.c:148
#11 0x000055555556fc68 in pre_select (c=3Dc@...1851...=3D0x7fffffffd910)
    at ../../../openvpn/src/openvpn/forward.c:1837
#12 0x000055555559375e in tunnel_point_to_point (c=3D0x7fffffffd910)
    at ../../../openvpn/src/openvpn/openvpn.c:79
#13 openvpn_main (argc=3D35, argv=3D0x7fffffffe998) at ../../../openvpn/src=
/openvpn/openvpn.c:283

It passes the test same case (same OS, same build tree) for OpenSSL 1.1.1j
and also for FreeBSD/OpenSSL 1.0.2u and FreeBSD/mbed TLS 2.16.9.

As the commit message talks about "mbed TLS 2.18+", it seems that code=20
gets irked by --tls-client/p2p.

I do not understand these code paths enough to do further educated guesses,
but we can't merge it like that.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--BkLofH2SCg2BlGUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgRR4SAAoJEB2Cnv7KVigSziEMAIq1+FyNsxmF1RDq3RsrSKvO
y+JQLJkt2FTq2bNCSVb2cZpWCwqXEwR+YXZBqQ/fsp2BWmlmbZsbH26DgpEs9Icb
MRB8Du9vFWE+j4eymzVYh6pRJWaYcugg9T2WM/i4dgHJncYPqJBX/9foG6R/c+ni
dUgz1yaPJxw+txRIy4R/vf4adHZIogLcg/5gg9Xgj9EoaT1lxKwndP16jBdBw7DJ
vyOVGqBDiHn6gPvgJ7sNNk+bcLx7HZp9cw99vyMDTQUOrx90rpMEu/UF2fCoeosO
dBT2fcL2dsvQ7pAG1JVnVOIS0MsEStHzwcUaxilsyJTm86tBWBM64YIB4WcNqs02
kuGzuTZDSi1RzPZOV6+TOaajUv0UM8KtrRCuVEYySW752rh6OqLtXGASoFdY6xfV
TdX0/ndF3sQgzf0YZR2trHLNHyrmRWVHudM5ySuU2hfWlseVkdHWggSJRabkGb3f
DMLWvAZ5FaT9r6JBlMXz5aFhV8cmHpzJ3CCF8gDEWg==
=l9KF
-----END PGP SIGNATURE-----

--BkLofH2SCg2BlGUz--

