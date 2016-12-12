Date: Mon, 12 Dec 2016 10:32:28 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161212093228.GG78624@...1296...>
References: <CAFHpkQE7qT8JZM+ZazgJy7PcGMbWawh+HE7OW-=SGNhnnL1pwA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y9FGoQKSF2AxjRbT"
Content-Disposition: inline
In-Reply-To: <CAFHpkQE7qT8JZM+ZazgJy7PcGMbWawh+HE7OW-=SGNhnnL1pwA@...278...>
Subject: Re: [Openvpn-devel] openvpn windows feed ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Y9FGoQKSF2AxjRbT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 11, 2016 at 11:44:24PM +0500, ???????? ?????????????? wrote:
> as we release new versions of openvpn installer, there are at least two
> "channels"
>=20
> a) beta
> b) stable
>=20
> should we also host some rss/atom feed with the most recent versions of 2
> channels ?
>=20
> so, that openvpn-gui could check "for updates"

I've put some ideas into http://community.openvpn.net/openvpn/ticket/769,
but it has not yet received much traction...

> also, there's an exception for WinXP (which I've no idea what to do with).

My idea was that the "rss/atom/..." feed has categories per OS, and=20
winxp would then just be "on 2.3.x", forever.

> it will help users to understand "new version is released, probably I
> should upgrade".
>=20
> it is great amount of work, I think we can schedule it after 2.4

It would be absolutely great to have.

I think the coding side is not that complicated (assuming some reasonable
parsing library exists on windows side), but the design of the "how do we
signal this to the client" needs great care, because this will stay with
us for a long time - so it needs to be easy to work with for Samuli,
reasonably easy to understand and extend, etc.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Y9FGoQKSF2AxjRbT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYTm6sAAoJEB2Cnv7KVigSsnML/j9WekSt2tLN+qu3AEGklnVM
T+dGPtTgzhCeURbCbIxpwQouF9ZgAs5AS592TUrDeng2RqMhphoT70WWm84YGS4P
7Ar+6myMBRZo3YVb8NaE0kAW6YrMdZkdzOugR5+QOjAmPqcNEucqieN4AbQOhw1K
wO2uLYBfUjOGffVDesDdYtfrZZINe7AKufaeXUzraLTane1llUGnALwe82o/94c3
jT1BrwabE+P7cOjd3CKJB5aJPOfjSltUWvpsVyOjjMufnFKqahBnTXscH9C+kTWB
Dhnc+BpmKC0emGI7nNfiub3QyEmwHEtjgGXbGjrUxV7+26EzkNIqTVWIqNyJXC4i
TcCrJoFVVDD8uis1ba3Rj0xqmiXFNukzK7tCoxAWqlpc3DV81Za7Mgf0/S2oU1VB
sLImfQsP9dwpBEzL0qnY8pVr2QZDxvp2RZI/N6sPbPSBXtXF1lRUfq1O9lzJTnVm
Nai9l8+TZ2glFv2YwTx45SobjOc7AE9SMyYwE+xAKw==
=Zjh1
-----END PGP SIGNATURE-----

--Y9FGoQKSF2AxjRbT--

