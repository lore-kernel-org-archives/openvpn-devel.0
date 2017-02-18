References: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
	<de60bac0-2491-44af-2a65-00654b14f55b@...2080...>
	<CAFHpkQFG5vKg95y6_7dUWA-cjtD0+HoV_BqEztxu0TjRJ42ezA@...278...>
	<CAFHpkQEqTK+v6T2WM7Kk6Eax3VmqJcP7r=goykuVPoef+oWatQ@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f3597b76-1fde-1ce0-67e8-577f7bc169bc@...2080...>
Date: Sun, 19 Feb 2017 00:16:51 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQEqTK+v6T2WM7Kk6Eax3VmqJcP7r=goykuVPoef+oWatQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kx6SfTgp4rJpssiGQ5FUqDJ94hsjpPUwf"
Subject: Re: [Openvpn-devel] build against openssl 1.1.0
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kx6SfTgp4rJpssiGQ5FUqDJ94hsjpPUwf
Content-Type: multipart/mixed; boundary="A0vEjEr5ICn9qqXESBRmlo4IHAJv0Teek";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
	"openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <f3597b76-1fde-1ce0-67e8-577f7bc169bc@...2080...>
Subject: Re: [Openvpn-devel] build against openssl 1.1.0
References: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
	<de60bac0-2491-44af-2a65-00654b14f55b@...2080...>
	<CAFHpkQFG5vKg95y6_7dUWA-cjtD0+HoV_BqEztxu0TjRJ42ezA@...278...>
	<CAFHpkQEqTK+v6T2WM7Kk6Eax3VmqJcP7r=goykuVPoef+oWatQ@...278...>
In-Reply-To: <CAFHpkQEqTK+v6T2WM7Kk6Eax3VmqJcP7r=goykuVPoef+oWatQ@...278...>

--A0vEjEr5ICn9qqXESBRmlo4IHAJv0Teek
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 18/02/17 08:34, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
>     I added openssl-1.0.1e to test matrix (do not pay attention to
>     commit title, it happened accidently from iPad), so ...
>=20
>     https://travis-ci.org/OpenVPN/openvpn/jobs/202709493
>=20
> t_cltsrv.sh + openssl-1.0.1f  =3D OK
> t_cltsrv.sh + openssl-1.0.1e =3D FAIL

Okay, lets get a few important details straight first.  When I spoke
about openssl-1.0.1e, it was in an RHEL context (including CentOS and
Scientific Linux).  In reality, that is not the same version as OpenSSL
upstream 1.0.1e.  Red Hat employs people to backport bugfixes and
security fixes from newer OpenSSL 1.0.x releases to 1.0.1e. So the
OpenSSL _baseline_ is 1.0.1e [1].  But it must not be compared directly
against v1.0.1e from openssl.org.  The baseline defines a /stable ABI/
(Application Binary Interface) which applications linking against the
library can rely on.  This is what makes RHEL and the clones so stable
over 7-10++ years.  And this is the challenge backporters in Red Hat
struggle with; not breaking applications which works.

So unless I have misunderstood your travis commit ... you set the
version to 1.0.1e regardless of Linux distribution.  This itself does
not provide any real value for us.  As there are a lot of bugfixes and
security implemented in the OpenSSL package RHEL ships ... you can get
an idea by looking at the changelog of the openssl RPM package:
<https://git.centos.org/blob/rpms!!openssl/1c5d99a56e70d3f668fd69f148538c63=
5dd990d6/SPECS!openssl.spec#L642>

RHEL6 was released in May 2010 while RHEL7 in June 2014.  What you see
above is the changelog for RHEL7.  If my count is correct, that is
currently 127 patches *on top of* the upstream OpenSSL v1.0.1e.  I
wouldn't expect this patch list to be much longer on RHEL 6 though.

So unless your travis script is clever enough to only test OpenSSL
v1.0.1e on RHEL, CentOS or ScientificLinux *or* build OpenSSL using the
CentOS source RPM ... then I am not surprised things may fail.  Red Hat
may very well have fixed some bugs which we're hitting.


--
kind regards,

David Sommerseth
OpenVPN Technologies, Inc




[1] The reason is that all the _baseline_ packages in major RHEL
    releases are certified against a lot of hardware (IBM, HP, Dell,
    EMC, NetApp, etc, etc) and third party software (SAP, Oracle, etc,
    etc).  So rebasing is out of question, as that requires new, time
    consuming and expensive re-certifications.  Which is why you
    extremely seldom see version updates on packages.  Those few times
    that happens, it is usually considered to not break any important
    certifications.  Like, a SAP server installation probably don't
    have any dependencies against the GNOME 3 packages.






--A0vEjEr5ICn9qqXESBRmlo4IHAJv0Teek--

--kx6SfTgp4rJpssiGQ5FUqDJ94hsjpPUwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJYqNXnAAoJEIbPlEyWcf3yEMkQAIZLsd5zmytVcfNGh6r2Ymjy
AbaakjGsnUppcL6zAni5mcg+b0O6sHTEkRhywj6O1G4jbzNCKddTA9m+pGAzge8H
tOJ8prF7kNUppHY/vBLx5oqUeQitQtpyHS6tT793Z4zXgoXYLd0kSdIKeIpCTHZ9
7K3p+AFjcUJEcOF8UkVFi/umqxDEwXzo9hAjjjiVO83Gc7ZGIhNl7rNt08XTsTtB
U/3xr0hK/Z6H/5DIdHSNGJArJOworYfBaarnZvzZGg4GDG7Qlejea4VWgJ24gB7g
bv9KWz/Ej/Crn2qHwsFcC1nZ5BprlZibR/kB43Y6Fk+Tka9ettWMYqh2fJRRJpmU
VHdQQgAbgkLYinEC+M+Z605lRnhLWz5UalQMcnqIDVsDB5Cvdsmab8eexgwPQObj
gjRMfkJ6hDDPUHMu/jzwkOtinnMX2ZcfuLamw9yl2gYkdo0vratHrqs+rqkF1uLZ
rOscs2e1cUBVqaZLw1JqrrLmuKmyeRP/BcD7T7PUUbu5iJkVDQqzU2ozz9aHtPIg
Ghg1RKIPznDqj1JsCWtQg6lwRZNMd55c6Nze85P/+emW0Eg3iD0WALdvE2ZjKPF3
iEc97UlhszahHCS8vCs9BwrXhLXwrOofav1jWR0E5S6mvddUMFoaf1UUagxYqH9X
uNhj2scNJB7eAUi4k6ps
=JgRI
-----END PGP SIGNATURE-----

--kx6SfTgp4rJpssiGQ5FUqDJ94hsjpPUwf--

