From: Manon Goo <manon@...287...>
Reply-To: Manon Goo <manon@...287...>
Message-ID: <33A1B960952916C53E05191C@[10.106.103.44]>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="==========31EB073ABDA6FA7C3A7D=========="
Subject: [Openvpn-devel] Thanks for OpenVPN
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Sep 30 23:03:28 2004
To: openvpn-devel@lists.sourceforge.net

--==========31EB073ABDA6FA7C3A7D==========
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

First of all thanks for Open VPN. I have installed it and it solves almoast=
=20
all the problems I had with ipsec for roaming users !


I have discovered some small issues with with openvpn:
1.) ifconfig and route with non root user.
I have worked around thie with sudo by configuring
/configure --prefix=3D/usr/local/openvpn2=20
--with-ifconfig-path=3D/usr/local/openvpn2/bin/ifconfig=20
--with-iproute-path=3D/usr/local/openvpn2/bin/route

and putting
#!/bin/sh
sudo ifconfig $@

(same for route) into the wrapper scripts defined. Perhaps this would be an=
=20
issue for the howto / configuration option.

2.)openvpn calls "ifconfig tun0 delete" under openbsd this should be=20
"ifconfig tun0 destroy"

3.) Sving IP addresses (Please correct me if I am wrong with this one)
	the client ist configured

	ifconfig tun0 [local IP]  [local IP + 1 ] .....

	As far as I remember from other tun/tap setups

	ifconfig tun0 [local IP]  [tunnel end IP]  ...

	would work as well and save half of the IP addresses used in a pool (this=
=20
is
	espcialy good for Officaly Assinged Ip addresses because they may be=20
limited (as in
	my case )) Is there any way to set this up ?





Thanks again

Manon Goo=

--==========31EB073ABDA6FA7C3A7D==========
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFBXPL/Gsjj3OYWNZERArKtAJ0Vd94AiBOau0YVjs/yNKEwm+vjRACfcdM3
ubp1nxrMqkqXoWsUzPnwW5A=
=PHCY
-----END PGP SIGNATURE-----

--==========31EB073ABDA6FA7C3A7D==========--



