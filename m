References: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
	<de60bac0-2491-44af-2a65-00654b14f55b@...2080...>
	<CAFHpkQFG5vKg95y6_7dUWA-cjtD0+HoV_BqEztxu0TjRJ42ezA@...278...>
	<CAFHpkQEqTK+v6T2WM7Kk6Eax3VmqJcP7r=goykuVPoef+oWatQ@...278...>
	<f3597b76-1fde-1ce0-67e8-577f7bc169bc@...2080...>
	<CAFHpkQFNi0w665vv2tqvbx+L5-_ap003S6kZViwLLecDu0ATmw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c9f72a59-ca4e-6066-ae3c-4cb2a9cdf7d2@...2080...>
Date: Sun, 19 Feb 2017 16:12:02 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFNi0w665vv2tqvbx+L5-_ap003S6kZViwLLecDu0ATmw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="T9adEdfgg0rd65IloGiNUaTfonf0DjE8d"
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
--T9adEdfgg0rd65IloGiNUaTfonf0DjE8d
Content-Type: multipart/mixed; boundary="lSP9SdId2A5ht0MD9I1lG93ikXi5uU89k";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
	"openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <c9f72a59-ca4e-6066-ae3c-4cb2a9cdf7d2@...2080...>
Subject: Re: [Openvpn-devel] build against openssl 1.1.0
References: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
	<de60bac0-2491-44af-2a65-00654b14f55b@...2080...>
	<CAFHpkQFG5vKg95y6_7dUWA-cjtD0+HoV_BqEztxu0TjRJ42ezA@...278...>
	<CAFHpkQEqTK+v6T2WM7Kk6Eax3VmqJcP7r=goykuVPoef+oWatQ@...278...>
	<f3597b76-1fde-1ce0-67e8-577f7bc169bc@...2080...>
	<CAFHpkQFNi0w665vv2tqvbx+L5-_ap003S6kZViwLLecDu0ATmw@...278...>
In-Reply-To: <CAFHpkQFNi0w665vv2tqvbx+L5-_ap003S6kZViwLLecDu0ATmw@...278...>

--lSP9SdId2A5ht0MD9I1lG93ikXi5uU89k
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 19/02/17 05:48, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
>=20
>=20
> 2017-02-19 4:16 GMT+05:00 David Sommerseth
> <openvpn@...2080...
> <mailto:openvpn@...2080...>>:
>=20
>     On 18/02/17 08:34, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:
>     >     I added openssl-1.0.1e to test matrix (do not pay attention to
>     >     commit title, it happened accidently from iPad), so ...
>     >
>     >     https://travis-ci.org/OpenVPN/openvpn/jobs/202709493
>     <https://travis-ci.org/OpenVPN/openvpn/jobs/202709493>
>     >
>     > t_cltsrv.sh + openssl-1.0.1f  =3D OK
>     > t_cltsrv.sh + openssl-1.0.1e =3D FAIL
>=20
>     Okay, lets get a few important details straight first.  When I spoke
>     about openssl-1.0.1e, it was in an RHEL context (including CentOS and
>     Scientific Linux).  In reality, that is not the same version as OpenS=
SL
>     upstream 1.0.1e.  Red Hat employs people to backport bugfixes and
>     security fixes from newer OpenSSL 1.0.x releases to 1.0.1e. So the
>     OpenSSL _baseline_ is 1.0.1e [1].  But it must not be compared direct=
ly
>     against v1.0.1e from openssl.org <http://openssl.org>.  The baseline
>     defines a /stable ABI/
>     (Application Binary Interface) which applications linking against the
>     library can rely on.  This is what makes RHEL and the clones so stable
>     over 7-10++ years.  And this is the challenge backporters in Red Hat
>     struggle with; not breaking applications which works.
>=20
>     So unless I have misunderstood your travis commit ... you set the
>     version to 1.0.1e regardless of Linux distribution.  This itself does
>     not provide any real value for us.  As there are a lot of bugfixes and
>     security implemented in the OpenSSL package RHEL ships ... you can get
>     an idea by looking at the changelog of the openssl RPM package:
>     <https://git.centos.org/blob/rpms!!openssl/1c5d99a56e70d3f668fd69f148=
538c635dd990d6/SPECS!openssl.spec#L642
>     <https://git.centos.org/blob/rpms%21%21openssl/1c5d99a56e70d3f668fd69=
f148538c635dd990d6/SPECS%21openssl.spec#L642>>
>=20
>     RHEL6 was released in May 2010 while RHEL7 in June 2014.  What you see
>     above is the changelog for RHEL7.  If my count is correct, that is
>     currently 127 patches *on top of* the upstream OpenSSL v1.0.1e.  I
>     wouldn't expect this patch list to be much longer on RHEL 6 though.
>=20
>     So unless your travis script is clever enough to only test OpenSSL
>     v1.0.1e on RHEL, CentOS or ScientificLinux *or* build OpenSSL using t=
he
>     CentOS source RPM ... then I am not surprised things may fail.  Red H=
at
>     may very well have fixed some bugs which we're hitting.
>=20
>=20
>=20
> well, RedHat not only ship their very own openssl, but also their own
> openvpn package
>=20
> https://dl.fedoraproject.org/pub/epel/7/SRPMS/o/

The Fedora EPEL packages are not really Red Hat (even though many Red
Hatters maintain EPEL packages).  The difference is, EPEL packages are
unsupported by Red Hat's support plans.  Packages coming from the
official Red Hat source repositories (which CentOS "clones"), are fully
supported by their support plans.

> I see, there's %check section, but it is commented. Not sure how thay
> test it. We should get in touch with redhat people if we want openvpn
> properly tested and packaged

OpenVPN is not tested by Red Hat.  Official packages by Red Hat (from
the proper RHEL repositories) go through a massive QE process, with
loads of automated regression testing, specially written for each
distributed package.  All bugzillas tied to a package gets its own test
case written and is explicitly tested.  Then the package is installed,
uninstalled, upgraded and downgraded on systems which tries to simulate
a production environment.  And I've probably forgotten a bunch of other
steps as well.

> I'll have a look at 'make check' under centos later

You won't find any explicit OpenVPN package in the CentOS 6 or later
repositories.  You will find el5 packages though, as OpenVPN was an
official package in RHEL5 (but that is 2.1_rc-something, IIRC)

As of RHEL 6, Red Hat removed OpenVPN from the official repositories and
decided users needing it should use Fedora EPEL for it.  The reasoning
is probably to cost related.  Otherwise they need to allocate at least
on person to be the package maintainer, plus the QE and release
management machinery.  If few Enterprise customers depend on OpenVPN for
their critical workloads, it probably wasn't worth the cost.  In
addition they might have looked at the stability and the amount of
security related issues in OpenVPN over many years (which are quite good!)

But things may change again.  I heard recently that Red Hat is migrating
over to OpenVPN as the only internal IT supported VPN solution.  So
about 10k employees will soon depend on OpenVPN for their daily VPN
need.  We will see when RHEL 8 gets released :)


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--lSP9SdId2A5ht0MD9I1lG93ikXi5uU89k--

--T9adEdfgg0rd65IloGiNUaTfonf0DjE8d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJYqbXCAAoJEIbPlEyWcf3yNO4P/2vg4AWFp97cAlhbhJMhMc3Z
iW4N4hNN1T6Gez45ENy7A+hLPr1lSxLnkTNcAoAGZJt4Q4VbqaUnM7lwV2+CjU/4
iRS/Im19Z2jcGc+0XA6oYQSAvUczhikeLvNKVJAE5PaWIJ2iguqscvE6MfsOXgpn
KMTsK7+bDjgfs5WT0IQr6sBPL5l66UbT+Kl7tayOQ3IeXU17S6JpnVaFuPf8nnJj
9gM0I+UAihn0Zl79NJAYVGJ14Y+MlvSxNKJSdghzvTgsV+wxTHIYy6RL5/Sux1AE
9eEm74QCgPMs0DcrPuQC5sT0SMZWd+OQoc2fuh0tcfYffiWIrJpHEofVRMRy5jFF
MgtgFB2HppLlZgW4ej4uAfFEZf9+3LICf1gsqeABdQRJrdJco/HNwHgBIMjMx2b4
rsd6vu05Ww5mbyiYyQH4jGzuIriUSyDhJJx+l81mpSFQdxvKyseSZZK5RVLUYvGF
fRGt1tC4wxOR1yK+MC1iXs6mA8Es7BxV9usTbwviUpfWkdNfQGYGimMHZnKi5+Sw
A/G8ngKRs/aQcieH1rLhjura6YgQUbS95TlzQHExoM9J7XD3ZMdZydtI8DpjV+E4
xVgI1UFLSSzArusRhIcePEOtFLlMAsUP2lvEF7/fw8ALEpNVwOSoVWb5ViNICp2A
U9tGlzCZUDOYiE5ILcuA
=xBvn
-----END PGP SIGNATURE-----

--T9adEdfgg0rd65IloGiNUaTfonf0DjE8d--

