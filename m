From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <a06a95d2-54b0-0e57-3d9f-a21f735db5e2@...515...>
Date: Thu, 11 May 2017 17:18:00 +0300
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="b8vqknvTTLgHWv3xXB8giEclqqim8PNUl"
Subject: [Openvpn-devel] OpenVPN 2.4.2 released (with security fixes)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, openvpn-announce@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b8vqknvTTLgHWv3xXB8giEclqqim8PNUl
Content-Type: multipart/mixed; boundary="6cicsc64CCQAxHuKS9MKWVNsGcppv9rkH";
	protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>,
	"openvpn-users@lists.sourceforge.net"
	<openvpn-users@lists.sourceforge.net>, 
	openvpn-announce@lists.sourceforge.net
Message-ID: <a06a95d2-54b0-0e57-3d9f-a21f735db5e2@...515...>
Subject: OpenVPN 2.4.2 released (with security fixes)

--6cicsc64CCQAxHuKS9MKWVNsGcppv9rkH
Content-Type: multipart/mixed; boundary="------------4D4077BA7ACF605AD9844A93"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------4D4077BA7ACF605AD9844A93
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.4.2. It
can be downloaded from here:

<http://openvpn.net/index.php/open-source/downloads.html>

OpenVPN v2.4.0 was audited for security vulnerabilities independently by
Quarkslabs (funded by OSTIF) and Cryptography Engineering (funded by
Private Internet Access) between December 2016 and April 2017. The
primary findings were two remote denial-of-service vulnerabilities.
Fixes to them have been backported to v2.3.15.  Our official security
announcement is here:

<https://community.openvpn.net/openvpn/wiki/QuarkslabAndCryptographyEnginee=
rAudits>

A summary of the changes is available here:

<https://github.com/OpenVPN/openvpn/blob/release/2.4/Changes.rst>

A full list of changes is available here:

<https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn24>

Compared to OpenVPN 2.3 this is a major update with a large number of
new features, improvements and fixes. Some of the major features are
AEAD (GCM) cipher and Elliptic Curve DH key exchange support, improved
IPv4/IPv6 dual stack support and more seamless connection migration when
client's IP address changes (Peer-ID). Also, the new --tls-crypt feature
can be used to increase users' connection privacy.

OpenVPN GUI bundled with the Windows installer has a large number of new
features compared to the one bundled with OpenVPN 2.3. One of major
features is the ability to run OpenVPN GUI without administrator privileges.

For full details, look here:

<https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn24>

The new OpenVPN GUI features are documented here:

<https://github.com/OpenVPN/openvpn-gui>

Please note that OpenVPN 2.4 installers will not work on Windows XP.

For generic help use these support channels:

Official documentation:
<http://openvpn.net/index.php/open-source/documentation/howto.html>
Wiki: <https://community.openvpn.net>
Forums: <https://forums.openvpn.net>
User mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
User IRC channel: #openvpn at irc.freenode.net

Please report bugs and ask development questions here:

Bug tracker and wiki: <https://community.openvpn.net>
Developer mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
Developer IRC channel: #openvpn-devel at irc.freenode.net (requires
Freenode registration)
--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------4D4077BA7ACF605AD9844A93
Content-Type: application/pgp-keys;
 name="0x40864578.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x40864578.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

mQENBFilZHYBCADGVuvyV9yg2GW7bslnPylaa9cxb3IXmb0qC7hUJueGnz0vLdit
/fPPPfsI3/hgcQYK1Y8cP5p2Pq+CZL0TVQWBEu2naH2unwxtfNm1EJcWDsky9DzW
CZQrcZ/v/coaV4UqMTVzGQaxQOzzeaP5nRgdX95dVKqXqsG8wKoIJmBuILAqkOPi
4EG9NQt2Lbqaiszo3LdsqyeGYK2yc745xBX4UDgIN7XTrXcQDyUOb4dsJynbM+Z9
8NMQxdA5q0s6BwWSA1xK/gKUCzfF7D1fwWuO2MoedHveB45rOMSFlfVUgr7fa1CR
zCe7lccu0APfgXrTnNWwWMVoQMO8HIyk2iGnABEBAAG0JVNhbXVsaSBTZXBww6Ru
ZW4gPHNhbXVsaUBvcGVudnBuLm5ldD6JATgEEwECACIFAlilZtwCGwMGCwkIBwMC
BhUIAgkKCwQWAgMBAh4BAheAAAoJEClYTZ9AhkV46tEH/Aot7SnpcLHpEkkCX7Jm
ERrWuqIwYJp7fQlbOPAVZG1+iC/3KlhYxHmH1/Dj6rP3LEEfWpCQSHSbBFkzPtZ6
AGnEfaxovXjso/tgnAAjYnxy9R0+1t0g5T6anXzCAjl3+mOssjzWBICBDZaFW9Rd
R47vCA92Fp9kAy3N+AMOv1HfTabaPo6p8HbaBSUQtgdOrfoBSXaFzaPSp8uwonQW
xRvpG91XtDrEoQio13460025ww+sZe5mIH4c7xhKBEZPswO2xnFszcFp3u12Glbj
eloAn8oxNycEuw11DfsHf2ctlbQCOLlJJxh2MND5SyL0SjCWMqO7v2c8UUUe4igS
xeuIRgQQEQIABgUCWKVo6wAKCRDCnZftGY0ioxDUAJ45kbXxCH3hiUexMvlJzvgN
mZmpyACg0UKbcmHUiFhnhyjtTTmAS5TjB8G0LFNhbXVsaSBTZXBww6RuZW4gPHNh
bXVsaS5zZXBwYW5lbkBnbWFpbC5jb20+iQE4BBMBAgAiBQJYpWR2AhsDBgsJCAcD
AgYVCAIJCgsEFgIDAQIeAQIXgAAKCRApWE2fQIZFeLAeB/9lGhVfON8TR6o6+lbm
GslU2xqV3PQ3hVuAlEttxpP4hCTKU0PwLLb7gtc0UF642qyB7ho2RtU+bg1tiq5z
R93Ka92Aex4yJDI4viEJ04MTX2WLRv6ogGTRrytIqmYGbYHTFXlnMnQD7Tf+O4sv
8tJj5gguB/zT8MXQGqU6zq9CF6b3XXdPSITkC7df/CU425HI4V5HvluC/4GrzFZI
za4Hv/d8G1tXzHXDqoLIBdS44g6GRdXak3PfROKsuk7sG/MmtfbfUPnyBI+yaGQk
jhlj3BRY0b1dg7T5SiZ6NoMXFH9zKEh7KnG8CaoqiNWDSp2sazy8kbZR5HUp2jOt
yXmgiEYEEBECAAYFAlilaOsACgkQwp2X7RmNIqOStQCePGpvkvmpISX4fR+lGAlt
VtWf3XgAmwQTECYXlq3NMdefzLxA5dnxstlEuQENBFilZHYBCADEe46V63aYL+VL
nZbmBz78KA0fOb5qopFQsOp79FdCQevGXa6JtdibaOLhWUiaMNgkGXma0rSzv/yc
kDX310JSSrNvbXtbn29MdmCZhWum3lT0bhHltF2w23ha913AEneUq1TAESZz74zJ
wGtoej7f2H0e3qjOKtwIzItnHRQSHXFRZUh1IRbZAqXQKqRRWiYVLG3pgF1iC9gA
jLcihK9P89G8jUmB8Ko+9Guw6JszKN+l5SVuK+ttrKCRi8hrkOIiazQUL4gu9PZs
aGPxNdwnzKGHGZKT0WglXavZFMWHunb6I9/CrCK3ekyHWAvYF7IY95r4SH+CtKqj
QoW8fOeVABEBAAGJAR8EGAECAAkFAlilZHYCGwwACgkQKVhNn0CGRXiO1QgAh3/I
EELh+pTiII5IiolHXEKEmgJ6WUU4RzM26Pfv3yMQKqUKBeEvKc21ZWmMKzPWXOE8
1np7DVXcp0ayiXrfGheGbXSpFP5WGlquYdYjVegBgRJ+v/r/QR+Oy2kbq0lsWuNz
Eia08fEHr7PM7mct0d1rFVuSS1m+1YOZNN8e/eSox84HvboSq6xk+3IC1NGXXdUQ
qObWceUyU0KmmBFMV86pUgI/YbA2uMxkFK8XGsOqMgTBdBWHTTcSOfmPsu/04zDl
MuQ+GC2WcUHoTtxytA432TzOixF5wfunqTzXeZxAybQPkETmAFgHT0BmUVShwPQ0
XuwT7RpGDZ6jBfphYQ=3D=3D
=3DFKLE
-----END PGP PUBLIC KEY BLOCK-----

--------------4D4077BA7ACF605AD9844A93--

--6cicsc64CCQAxHuKS9MKWVNsGcppv9rkH--

--b8vqknvTTLgHWv3xXB8giEclqqim8PNUl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZFHKZAAoJEClYTZ9AhkV4c9sIAJspuHzy7TVTjgCbAp0dO3ac
E3Cec3wd3D48nn2ia9yTm1slhFnWXAAv/YRzsiobvOBUBCf2+q+u36ZwRwnxwrJH
qY/UqaPfHyLcZFigFS61SbdjfaSathTsmooAAhc2dPul5EYsrOiIOIZAN0P3EllH
3aBYQwRjcG9eEXDGhboVpKpmQlNF6KKdUJZ/HaW7l6tNouq6jCEuY7znqs1Prh1a
wOyK7/xWV1eNrc11XfXWfPUNop3HlfSCGNEXapfKjDexU+dKlZ0TgxQIwxFWqqHQ
LXJMT/CbsBgrvvwtKNlW9JNTcX/be2KvoZfXJJ7TKr2YUy2obqRUaDL0fmYM+wk=
=M/+g
-----END PGP SIGNATURE-----

--b8vqknvTTLgHWv3xXB8giEclqqim8PNUl--

