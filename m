From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <9f75757c-6668-c521-af6f-b18e8db3fa72@...515...>
Date: Wed, 24 Apr 2019 13:49:21 +0300
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HdEDUWP8H6JTugBQQlRJDycGXGHpiR27x"
Subject: [Openvpn-devel] New OpenVPN 2.4.7 Windows installers released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HdEDUWP8H6JTugBQQlRJDycGXGHpiR27x
Content-Type: multipart/mixed; boundary="f5w8mneRdZAzUh1QYtoSmNlKiJowC0EuF";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net,
 openvpn-announce@lists.sourceforge.net
Message-ID: <9f75757c-6668-c521-af6f-b18e8db3fa72@...515...>
Subject: New OpenVPN 2.4.7 Windows installers released

--f5w8mneRdZAzUh1QYtoSmNlKiJowC0EuF
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

New OpenVPN Windows installers have been released. The release
highlights are:

- Latest openvpn-gui
- Latest openvpnserv2 (OpenVPNService)
- Latest tap-windows6 driver
  - ARM64 support
  - NDIS 6.30 support
  - other enhancements
  - fix to local privilege exploit vulnerability

The installers come in two flavors. Windows 7/8/8.1/Server 2012r2:

<https://swupdate.openvpn.org/community/releases/openvpn-install-2.4.7-I606=
-Win7.exe>

Windows 10 (any version):

<https://swupdate.openvpn.org/community/releases/openvpn-install-2.4.7-I606=
-Win10.exe>

We're unable to release a version for Windows Server 2016 at this point,
 so you need to use the old installer:

<https://swupdate.openvpn.org/community/releases/openvpn-install-2.4.7-I603=
.exe>

We're working on getting tap-windows6 pass the HLK test suite on Windows
Server 2016. This will allow us to get a signature from Microsoft and
release an updated tap-windows6 on that platform as well. While waiting
please avoid running OpenVPN on nodes where all users are not trusted.

For further details see the download page:

<https://openvpn.net/community-downloads/>

Best regards,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--f5w8mneRdZAzUh1QYtoSmNlKiJowC0EuF--

--HdEDUWP8H6JTugBQQlRJDycGXGHpiR27x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlzAPzEACgkQKVhNn0CG
RXhIjAgAuvtG2ejf/F39Cwd95XibNppQ5X1709kbf6QmTX7T5dfnr0VQcfFAzv48
5JerAjxn8FU/NFn28Q00JYmDa+acpODLJCs1aqcuCZBprfJv2qx74qF86LiVQ5KQ
D1zWNhSp7iOPy5ksk8L/ixEWZgdQB0oo+Pg4TUfq6Ikd4r1hD2Mh1cFhbSxJTIQF
7w6aGVeCU+UTnG3DqGoCuvERIAI+qipSeehKk9LiBP6xuBVy3GnhocazBSIUCyW5
CbhvFAIn3FYLwocA69io8dwBuSMzQKTn4blq0rSsGWJNrBPYzrP1rUjBiRCgC6+8
Y80Ev5OPEjSQgGkhZqwrdOBr95begQ==
=vpZw
-----END PGP SIGNATURE-----

--HdEDUWP8H6JTugBQQlRJDycGXGHpiR27x--

