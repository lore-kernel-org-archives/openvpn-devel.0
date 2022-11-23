Date: Wed, 23 Nov 2022 14:25:49 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y34fXbu5wTgMQVmJ@...1296...>
References: <20221012133457.1927871-1-arne@...1227...>
 <20221026164522.3773718-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vEzMFleroXKKABGy"
Content-Disposition: inline
In-Reply-To: <20221026164522.3773718-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] Move dco_installed from
 sock->info to sock->info.lsa.actual
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--vEzMFleroXKKABGy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 26, 2022 at 06:45:22PM +0200, Arne Schwabe wrote:
> For tcp this makes no difference as the remote address of the
> socket never changes. For udp this allows OpenVPN to differentiate
> if a reconnecting client is using the same address as before or
> from a different one. This allow sending via the normal userspace
> socket in that case.
>=20
> Patch v2: fix windows code path

Subjected this to the usual torturing, and while everything *looks*
good, it breaks

  FreeBSD tcp client (old code) --> Linux DCO server (master + patch)

freshly started regular TCP/TLS server instance, handshakes just fine,
until the PUSH_REPLY wants to be sent (peer-id allocation?), then

2022-11-23 14:22:50 us=3D358335 freebsd-14-amd64/194.97.140.5:54725 Data Ch=
annel MTU parms [ mss_fix:1366 max_frag:0 tun_mtu:1500 tun_max_mtu:1600 hea=
droom:136 payload:1768 tailroom:562 ET:0 ]
2022-11-23 14:22:50 us=3D358871 freebsd-14-amd64/194.97.140.5:54725 SENT CO=
NTROL [freebsd-14-amd64]: 'PUSH_REPLY,route 10.220.0.0 255.255.0.0,route-ip=
v6 fd00:abcd:220::/48,tun-ipv6,route-gateway 10.220.1.1,topology subnet,pin=
g 10,ping-restart 30,compress stub-v2,ifconfig-ipv6 fd00:abcd:220:1::1002/6=
4 fd00:abcd:220:1::1,ifconfig 10.220.1.4 255.255.255.0,peer-id 0,cipher AES=
-256-GCM' (status=3D1)
2022-11-23 14:22:50 us=3D359153 freebsd-14-amd64/194.97.140.5:54725 write T=
CPv6_SERVER []: Bad file descriptor (fd=3D-1,code=3D9)
2022-11-23 14:22:52 us=3D525667 freebsd-14-amd64/194.97.140.5:54725 PUSH: R=
eceived control message: 'PUSH_REQUEST'
2022-11-23 14:22:52 us=3D526099 freebsd-14-amd64/194.97.140.5:54725 write T=
CPv6_SERVER []: Bad file descriptor (fd=3D-1,code=3D9)
2022-11-23 14:22:56 us=3D611511 freebsd-14-amd64/194.97.140.5:54725 write T=
CPv6_SERVER []: Bad file descriptor (fd=3D-1,code=3D9)
2022-11-23 14:23:04 us=3D694791 freebsd-14-amd64/194.97.140.5:54725 PUSH: R=
eceived control message: 'PUSH_REQUEST'
2022-11-23 14:23:04 us=3D694916 freebsd-14-amd64/194.97.140.5:54725 write T=
CPv6_SERVER []: Bad file descriptor (fd=3D-1,code=3D9)
2022-11-23 14:23:04 us=3D694966 freebsd-14-amd64/194.97.140.5:54725 PUSH: R=
eceived control message: 'PUSH_REQUEST'
2022-11-23 14:23:05 us=3D853345 freebsd-14-amd64/194.97.140.5:54725 write T=
CPv6_SERVER []: Bad file descriptor (fd=3D-1,code=3D9)


on the client I have

2022-11-23 14:22:50 Control Channel: TLSv1.2, cipher TLSv1.2 ECDHE-RSA-CHAC=
HA20-POLY1305, peer certificate: 2048 bit RSA, signature: RSA-SHA1
2022-11-23 14:22:50 [server] Peer Connection Initiated with [AF_INET]195.30=
.8.84:51194
2022-11-23 14:22:51 SENT CONTROL [server]: 'PUSH_REQUEST' (status=3D1)
2022-11-23 14:22:56 SENT CONTROL [server]: 'PUSH_REQUEST' (status=3D1)
2022-11-23 14:23:00 TLS Error: local/remote TLS keys are out of sync: [AF_I=
NET]195.30.8.84:51194 (received key id: 0, known key ids:  [key#0 state=3DS=
_ACTIVE auth=3DKS_AUTH_TRUE id=3D0 sid=3D934b2d6e 14c3286f] [key#1 state=3D=
S_UNDEF auth=3DKS_AUTH_FALSE id=3D0 sid=3D00000000 00000000] [key#2 state=
=3DS_UNDEF auth=3DKS_AUTH_FALSE id=3D0 sid=3D00000000 00000000])
2022-11-23 14:23:01 SENT CONTROL [server]: 'PUSH_REQUEST' (status=3D1)
2022-11-23 14:23:06 SENT CONTROL [server]: 'PUSH_REQUEST' (status=3D1)
2022-11-23 14:23:10 TLS Error: local/remote TLS keys are out of sync: [AF_I=
NET]195.30.8.84:51194 (received key id: 0, known key ids:  [key#0 state=3DS=
_ACTIVE auth=3DKS_AUTH_TRUE id=3D0 sid=3D934b2d6e 14c3286f] [key#1 state=3D=
S_UNDEF auth=3DKS_AUTH_FALSE id=3D0 sid=3D00000000 00000000] [key#2 state=
=3DS_UNDEF auth=3DKS_AUTH_FALSE id=3D0 sid=3D00000000 00000000])


Not exactly sure why it hickups.  This is fully reproduceable, so if you
want me to increas debug, just let me know.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--vEzMFleroXKKABGy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjfh9dAAoJEB2Cnv7KVigSpQML/iP4gHg0e/uhdBRoX3ZwtG+4
emzDSXaiuGE7VA1+M8l2pxYMD06CnAcj7qe2AX3JFuc5G1RtObguFBbLpGVoGStG
mWC7C62d+KYAZxMvpdhcWYyUjC38BRMDIXJOQ44eMl0tYkeRL2nUXTl3wXGgvwEf
yZ9+lVSsEtLhajN5GT/fGflthpyNlaqo99BWxISqcP0CF9vu/PJ8RfnD4Bxp6NxU
5YYnEkYuDejMZR7P75605gT3eCTaVXeg9nZxS7lTjVsPCd4EGEDdyjJasURjhE8O
l7tiZQtECgy+ienQkdqEmD7KvrmSnWF+q/HCi7Bx38j0r+49n+yTfgTImOtfwSSw
S5hI3QIp3AAFNyUB6Lfsm287f99XSsVNkDXLFttPrybZOyU0oIsdxGpUEzMipD+b
Gf+HJWehIGFFZXJxzo6dpyPOft8XqK4tdZ+tyzekt9Gdh7L6qY3Tpei5rfD4V2wt
i2SHqOlafktq4BsPprMG6e/CUzAdmxWhFZhG7PuB5g==
=WfPf
-----END PGP SIGNATURE-----

--vEzMFleroXKKABGy--

