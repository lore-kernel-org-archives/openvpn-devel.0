Date: Mon, 7 Dec 2015 16:18:38 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151207151838.GB24952@...1296...>
References: <1449446507-16654-1-git-send-email-selva.nair@...277...>
	<1449446507-16654-2-git-send-email-selva.nair@...277...>
	<20151207071906.GS24952@...1296...>
	<CAKuzo_irs7y+41FMM6i3T6Y1Xo-bA+DXgN7hxuS1TXvPFKWFwQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8YpBv3tE2B8vKY6r"
Content-Disposition: inline
In-Reply-To: <CAKuzo_irs7y+41FMM6i3T6Y1Xo-bA+DXgN7hxuS1TXvPFKWFwQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2.3] Add an autoconf macro to check
 WINAPI functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--8YpBv3tE2B8vKY6r
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

On Mon, Dec 07, 2015 at 10:10:55AM -0500, Selva Nair wrote:
> > On Sun, Dec 06, 2015 at 07:01:47PM -0500, Selva Nair wrote:
> > > Signed-off-by: Selva Nair <selva.nair@...277...>
> >
> > NAK for 2.3 - what we have there works well enough.
>=20
> The reason for adding it to 2.3 was anticipating it will have to be built
> for vista+ if the dns-leak patch goes in.
>=20
> In fact I wrote it the intet_ntop issue showed up (fixed by commit
> f96baabc6cf1.. in master)  -- had I seen that commit first, wouldn't have
> though of this macro, probably.

You're right - as soon as we'll try to build with VISTA settings, it will
blow up on mingw ("as it happened for me on master").  So maybe we need to
backport that commit at least, or Samuli will need to apply it to the
local tree that is used for building vista+-binaries-from-2.3

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--8YpBv3tE2B8vKY6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVmWjTakuBuNlUUl1AQIDfwP/fZfSlBQ0iQ+gqzHlWGjhb4qIlwrNWivN
Cck973F2A9AwyKK0p02tmbg1ZoteWPakTp/rejLLR16HvfFs7X2KhRjev2WTBIDS
F7Wij9Crjeco99QSzwVOqdHKjHGgtCpENkXK3UMhOMB8vDnkzAxwpJZrjhz+pKea
rwJe50oJFjE=
=SYkz
-----END PGP SIGNATURE-----

--8YpBv3tE2B8vKY6r--

