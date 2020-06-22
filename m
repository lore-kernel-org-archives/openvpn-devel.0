References: <20200622113022.23047-1-davids@...515...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <0c62f389-39dc-b896-ec89-c864a1076089@...1227...>
Date: Mon, 22 Jun 2020 14:21:50 +0200
MIME-Version: 1.0
In-Reply-To: <20200622113022.23047-1-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aiaA9qTCxwCKdtz33uIQtegvQuoGM9nyk"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Change the default cipher to
 AES-256-GCM for server configs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aiaA9qTCxwCKdtz33uIQtegvQuoGM9nyk
Content-Type: multipart/mixed; boundary="6BJCC8267quqOLI7XvSnygPp0enz1kx1l"

--6BJCC8267quqOLI7XvSnygPp0enz1kx1l
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


>  PrivateTmp=3Dtrue
>  WorkingDirectory=3D/etc/openvpn/server
> -ExecStart=3D@...2235...@/openvpn --status %t/openvpn-server/status-%i.log -=
-status-version 2 --suppress-timestamps --config %i.conf
> +ExecStart=3D@...2235...@/openvpn --status %t/openvpn-server/status-%i.log -=
-status-version 2 --suppress-timestamps --cipher AES-256-GCM --ncp-ciphers =
AES-256-GCM:AES-128-GCM:AES-256-CBC:AES-128-CBC:BF-CBC --config %i.conf
>  CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE =
CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE CAP_AUDIT=
_WRITE
>  LimitNPROC=3D10
>  DeviceAllow=3D/dev/null rw
>=20

NACK.

Setting ncp-cipher to include BF-CBC by default allows BF-CBC in configs
that did not allow it before. Basically any config that had something
other than cipher BF-CBC and no ncp-ciphers in it will now allow clients
with BF-CBC to connect. I don't want force users to set ncp-cipher to a
sane value since the systemd unit file doesn't.

Arne


--6BJCC8267quqOLI7XvSnygPp0enz1kx1l--

--aiaA9qTCxwCKdtz33uIQtegvQuoGM9nyk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7wol4ACgkQFRhsZwKx
RFSYzQ//eeY393Q2pzkJAL5PziADM9wBtzRroGDQSfDr5Mln5VATZvKl6X7R7x8U
5sIjYmUSpLs734c1croLJixeuEs4t+FIbNH+8BQjDNSI/Oqc4mcRQT8H+iYlDaxV
wkVsIlMLU7aMiIewl9w6H4HFPg39sqyWcCfYt3B7c+FanknIk/3GRkDwqf5eD6qf
aPQrOw1Q5hnvEz/Qij1Gglb7Xh4sMK3LxmiWcQeosC8Yr9Ci2zWeNNVK6w43bQ5m
LarZBNnSriv91cvRFyYR8mtC80LBxV6kVTqzVRJBLyhW9Mn5CnWWf+JbOgAK/Nox
cv720zSrL0Sl9P+2tAbzdvCGg4Ur0eP5FlUwtewDf/F0Vf71l31zGEKxALE+2o7J
F/zlimHsD9Av4BEBq/tosMFeSJc2xnQfEJvxMMdeUh2VeJNKXBsG/n1pBSopAckh
oBmqzT4lqWMddKcfPgjK4WIp0BXNu4/Hk3PeTbNJhNJbCJm/xDZCKa/441KN0kuq
MDkoU1NGqeR64zEIP//KTNMtreH8OZKg9umVzvusNS5Vs/D2NvifjVWetpsd7S/E
t+Coc6BDTQbkrl0RMFEMiGgm4E/ssGTJXR+IoIcS9efsfo094baz9FucLgqt4y85
B1DBN03axhFbWaaoUmJSVLMojsbEq1BKmTPfossSri9xtm6MXu8=
=aiB9
-----END PGP SIGNATURE-----

--aiaA9qTCxwCKdtz33uIQtegvQuoGM9nyk--

