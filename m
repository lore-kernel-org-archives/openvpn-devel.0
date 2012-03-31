Date: Sat, 31 Mar 2012 17:35:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120331153502.GV1359@...1296...>
References: <CAEsd45TVCJKRrag9FRKnXhTVhOWO=pjMq3wXkz_bd43_mwhWAA@...278...>
	<4F576C3B.9090308@...1114...>
	<CAEsd45TaK6gpOivakP85Lb2ndb9LE8s59NmJ1_=z3Ggzj4EDDA@...278...>
	<20120323141815.GC1359@...1296...>
	<CAEsd45Rzo14YeaYAWnMi65i__z3TuvqwQwzjTSdMRy8JMkWHMQ@...278...>
	<4F73545A.8020303@...1114...>
	<CAEsd45RkyJw6yUk1Jwkip70HkCjKYoU+V=do3N7SH7JOaHBZdw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9dhkaBkwM1QzkQhP"
Content-Disposition: inline
In-Reply-To: <CAEsd45RkyJw6yUk1Jwkip70HkCjKYoU+V=do3N7SH7JOaHBZdw@...278...>
Subject: Re: [Openvpn-devel] 2.3alpha1 fails on OS X when the --up argument
	contains more than an execution path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--9dhkaBkwM1QzkQhP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Mar 31, 2012 at 07:47:34AM -0400, Jonathan K. Bullard wrote:
> Thanks for this suggestion, David, but I believe it is better to create a
> separate routine for this:
>=20
>    1. The input is not a path, but a "command". A "command" is processed
>    (single- and double-quote and backslashes are processed and leading sp=
aces
>    are removed), and it consists not only of a path, but may include argu=
ments.
>    2. Having two separate functions makes two cleaner and more readable (=
to
>    me) functions, instead of a single function that accepts strings with =
two
>    different formats and is more complicated.
>=20
> The first attached patch incorporates Fabian's comments. But if the
> consensus is that I should incorporate David's suggestion, I will do that.
>=20
> The first patch also updates the usage message to clarify what a "cmd" is.
> (That is, it is *not* a shell script or path.)
>=20
> The second patch updates the man page to:

I'm fine with these changes (and I don't particularily mind if it's a
separate function or integrated in the other one - both arguments have
their merits).  So I'll ACK both, and leave it to David to NAK it if
he insists on "I want it integrated".

> Thanks again to Fabian, Gert, and David for their help.

Thanks for contributing :-) - there's only so much we can do, given
the amount of different scenarios where people are using OpenVPN, so
we can't test all of it...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--9dhkaBkwM1QzkQhP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3ckJqkuBuNlUUl1AQLX1QP9GyfxKKoGWVyt6LrCXAZtBgfhx/xmm+Ob
X+wUV7E+g6DS7MiZqfadiHD1RgYirUcKvlRLDHcyIBT+C8Qtlel/NRa2d0R1pVaD
xb3wrpTskuUKz++BfDfFOwRhtohqI8CU6jywQuzkGOeGaf/bwcWSdJYJKO9pzgB+
EwD2AhwoA1A=
=FT4Z
-----END PGP SIGNATURE-----

--9dhkaBkwM1QzkQhP--

