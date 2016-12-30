Date: Fri, 30 Dec 2016 16:54:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161230155423.GA78624@...1296...>
References: <CAFHpkQEeLcCtu3RrbzQLEzS8-2B74DTT_5yh1MRnVL7CZ3xcdg@...278...>
	<CAKuzo_ijVNp8jszViyEf0sePM2i6-OHhS6gcAV=g6h5KbTruBA@...278...>
	<CAFHpkQEOFo86emyCq5LwzTsn9Tw7u2EYBNDFkNv8GrgZ_DdJmw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EnT6sQnqsTJq4oDy"
Content-Disposition: inline
In-Reply-To: <CAFHpkQEOFo86emyCq5LwzTsn9Tw7u2EYBNDFkNv8GrgZ_DdJmw@...278...>
Subject: Re: [Openvpn-devel] couple of questions on trac#665
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

--EnT6sQnqsTJq4oDy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 29, 2016 at 10:30:58AM +0500, ???????? ?????????????? wrote:
> I would split !read || !write into 2 separate calls with separate debug l=
og
> messages...=20

NAK on this.  This code can basically not fail unless the interactive
service dies - and then, it does not really matter which one failed
(because both will fail).=20=20

So unless you see *this* error message ("TUN: could not talk to service:")=
=20
and wonder whether read or write is causing is, there is no benefit in=20
making this part of the code more lines.

> and move FlushIpNet error closer to FlushIpNet call.
>=20
> right ?

No.  The error check is *right* under the line where it is set.

No need to have duplicate code in both if/else clauses before that.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--EnT6sQnqsTJq4oDy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYZoMpAAoJEB2Cnv7KVigSCv0L+gJXJs/2T3XwKHDeGdHOUa6A
n2end37/W69UazbsO/iCJkV7yXyrwekc2y/SMWsNW9H3dM1dX+NkKu/bdKBqsdgI
OndJBBxQIfQbETR/bsCKKRP3q1z6fwKUVFYXO/oX9ePuTLoZXsj9fB1ys9VGapoJ
ArK1CGVJKi0NfCvMyrw1JTZT3/Tb3eY3MgJO59D4TNOizjjqyC5aK4jVHBgG5oRQ
/YpJAOb7gAABof+/7lmIwajnV3assCg8utyFs06mV6BrbmM4OxRi7Z9utJhdBBVD
pPJUe7/AxRwE86GjbZ9QQ9lUHGwu6R7/bENWMhM+1XWXNbpPNR/WaDVgW4Id9M26
nef/5AVc8SooK8JjnXyXKWIkQ2xco5kvzDKn0xoj69thVow9BNp5N7P9Pc/Ry7GT
DIxoiQauImZEKRudsIYcpesyUaICEHdwdE+gBpUI2Kk70rTsFpNqs75CQU8wkjP9
cj1/eWLj3EDUVUvM+ntGxcY/FWwe6PoEFWUxvUBS6A==
=hHkk
-----END PGP SIGNATURE-----

--EnT6sQnqsTJq4oDy--

