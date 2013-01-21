Message-ID: <50FD833A.3000607@...68...>
Date: Mon, 21 Jan 2013 19:04:42 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1358411009-2350-1-git-send-email-steffan.karger@...1435...>
	<1358411009-2350-4-git-send-email-steffan.karger@...1435...>
	<50FBEC82.2050503@...68...>
	<1CED409804E2164C8104F9E623B08B90133FB458E5@...1436...>
	<20130121102317.GV22465@...1296...>
	<20130121132330.GA22465@...1296...>
In-Reply-To: <20130121132330.GA22465@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF6CFAAA0027588B570A9A1DF"
Subject: Re: [Openvpn-devel] [PATCH 3/3] PolarSSL-1.2 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF6CFAAA0027588B570A9A1DF
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 21.01.2013 14:23, schrieb Gert Doering:
> Hi,
>=20
> just for the sake of those not following the discussion on IRC...
>=20
> On Mon, Jan 21, 2013 at 11:23:17AM +0100, Gert Doering wrote:
>> I'm more concernced about maintainability of the OpenVPN code base, and
>> having more #ifdef in there is not the way forward.
>=20
> ... we have now come to some sort of conclusion on this:
>=20
>  - 2.3.x will support PolarSSL 1.1 and 1.2, to help people building OpenV=
PN
>          with PolarSSL on distributions that ship 1.1
>=20
>  - 2.4.x will drop support for PolarSSL 1.1, to simplify the code

Thank you.  This is a very reasonable approach - and exactly what I was
proposing, perhaps not spelt out clearly enough.

BTW I wouldn't bother too much about distributions shipping outdated
stuff either; if people run Debian with outdated PolarSSL, they are
bound to also use whatever OpenVPN version Debian has packaged.


--------------enigF6CFAAA0027588B570A9A1DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlD9gzoACgkQvmGDOQUufZV2LwCgy7gAUHbrrEOkLSNQvl6rjW4F
EroAn2knCJeFEblnzJiWdoT9Kb9TC3z+
=NsNg
-----END PGP SIGNATURE-----

--------------enigF6CFAAA0027588B570A9A1DF--

