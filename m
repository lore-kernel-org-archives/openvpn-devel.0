Date: Wed, 6 Jun 2018 09:10:31 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180606071031.GX57262@...1296...>
References: <CAAEV3TywmcYYidTfa6oWaex-24rjeqh7iJZ28p1rQONS3Ev0ag@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jh06fhy6YTawvwPV"
Content-Disposition: inline
In-Reply-To: <CAAEV3TywmcYYidTfa6oWaex-24rjeqh7iJZ28p1rQONS3Ev0ag@...278...>
Subject: Re: [Openvpn-devel] OpenVPN Custom Client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rafael Herrera <rafael.herrera@...2405...>
Cc: openvpn-devel@lists.sourceforge.net

--jh06fhy6YTawvwPV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 05, 2018 at 05:54:05PM -0300, Rafael Herrera wrote:
> We are developing a custom client for OpenVPN 2.4.x and it would be nice =
to
> have some support from experienced community developers.
>=20
> Is there anybody here available to help us with a consultancy regarding to
> network protocols and its required state machines?

David was working on an RFC to document the protocol - no idea if that
has progressed to "readable first draft" status already, but it might
be a good test for the document.

Besides this, I wonder why you're not basing your work on the existing
(2.x or 3.x) client, possibly with a new GUI wrapped on top - duplicating=20
all the code and logic inside OpenVPN is a fairly big task, especially=20
in the "this is not really very well defined, it just happens to be=20
this way today" areas.

Also, you'll have to end up following all developments that we do on
the 2.x and 3.x clients - like, right now we're working on making the
client work in an IPv6-only environment.  We test against 2.x and 3.x,
but if we break "other implementations that we do not know about", it
is not something we can avoid.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--jh06fhy6YTawvwPV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbF4jmAAoJEB2Cnv7KVigStNgMAK1a2p9iT8XqgRE8GqDjGRvx
N3dsCoOJFY2MTGniPkV18ksDUwSYJ+8MagKxHF87YwzJVjvReMgeu7hk2D39ec07
Vsf2tw1UBGi7PJBh4PZPzU9mz+xe53Svl/YAogBN5kr3/DiOoy49ipM35g0gKtiL
pWPPJYnssLjo0b9AIJk0OHXa4iH95i0CdEUyGtGNPMq7ATtKpdxNnUC4pApxVY9x
o7bGRgJtc+zjz6w/G8r7F61PJcdwtVaVL+QrGGwhcjSr5vn3aNkOImnE+MK1mjk8
NzW+/ShI04GYdY/80U2voN9daLyqwfTtzyD7vD/xUn96pFGyFmuREANOrYfl/Cnd
0yIjNdaWTDAAMtINpbEYVWljdb0b8cBMeVOOZtsNjcTy2uCAoMjrUBnHfIqr8rNd
YBqWW6XfOWEdEY4GOcED/O/cjcE8UnvMzMmV2Bt+vxvRB6ezX7CT6iMMXVLbvGtA
8YDE9IU8oZHhRH47muxXEKdZDLdKB3HbFBXk+TUxCA==
=/y9D
-----END PGP SIGNATURE-----

--jh06fhy6YTawvwPV--

