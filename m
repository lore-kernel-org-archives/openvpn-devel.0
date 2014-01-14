Message-ID: <52D51737.1040201@...1114...>
Date: Tue, 14 Jan 2014 11:53:43 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20140113185822.GV226@...1296...>
In-Reply-To: <20140113185822.GV226@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="pedkf8tDaojmKa9RvIGTp6lefcxl4kBiQ"
Subject: Re: [Openvpn-devel] RFD: <net/route.h> and struct route (trac #340)
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pedkf8tDaojmKa9RvIGTp6lefcxl4kBiQ
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 13/01/14 19:58, Gert Doering wrote:
> Hi,
>=20
> there's an open bug in trac
>=20
> https://community.openvpn.net/openvpn/ticket/340
>=20
> that asks us to remove structures used in route.c that were copy-pasted
> from <net/route.h>, because OpenBSD will change some structure elements,
> leading to incompatibility with OpenVPN, and include <net/route.h> instea=
d.
>=20
> This makes sense, from a portability perspective, even if it needs
> careful testing across all supported platforms to see whether everything
> affected still works (this seems to primarily be the default gateway
> querying code, get-default_gateway()).
>=20
> There is a catch to it: <net/route.h> defines a "struct route", while
> OpenVPN's route.h also has a "struct route", which are wildly different,
> so including <net/route.h> would require is to change all occurrences
> of "struct route" to "struct route_ipv4" or such.  Which we can do,
> and I think it makes sense (we have "struct route_ipv6" for IPv6, so
> that would avoid the conflict while still aligning IPv4/IPv6 somewhat).
>=20
> Now comes the catch: git master/2.4 only, or 2.3.3?
>=20
>=20
> It's not exactly a bugfix, but is needed for portability, and since 2.3.x
> will be around a while, it would be good to have there.
>=20
> Also, changing it in master and 2.3.3 would make Arne's and my life much=
=20
> easier in future should we have to fix a bug relating to (then)=20
> "struct openvpn_route", as we wouldn't be able to cherry-pick master->2.3
> anymore otherwise...
>=20
>=20
> So I'm tempted to go for "git master and 2.3.3", but want to put this
> up for discussion here.

Generally speaking, I'd prefer as few changes to the 2.3 branch as
possible.  Try to let it be bugfixes mostly.  This is also to encourage
users to move over to 2.4 ASAP when that's ready, with more new
features.  It also helps stability and maintainability within the
OpenVPN project.

Arne's OpenVPN for Android seems to always have been more experimental
and bleeding edge than OpenVPN Connect.  So unless Arne screams back at
me telling me I'm wrong, I believe Arne will be one of the first ones to
move over to the 2.4/master codebase, thus not making things that
difficult for him.  But Arne is the one who can fully answer this.  If
he says it will be more complicated, then let it go into 2.3 too.

Having all that said.  Looking at your patches, they seem clean enough
and I'm not terrified by it.  I'd expect compile errors from our
buildslaves if this breaks something.

So I'd vote for master instantly.  And then 2.3 if really needed, after
it has been tested in master for a little while.


--=20
kind regards,

David Sommerseth


--pedkf8tDaojmKa9RvIGTp6lefcxl4kBiQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLVFzkACgkQDC186MBRfrpKxQCeLcc9FiUcQYFGQ8iQMTblxKt/
8GUAoJgM5zaib9DXQduKt9cJ+mvYrLlX
=R8Tz
-----END PGP SIGNATURE-----

--pedkf8tDaojmKa9RvIGTp6lefcxl4kBiQ--

