Date: Wed, 29 Apr 2015 23:30:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150429213036.GF382@...1296...>
References: <1427784294-22175-1-git-send-email-samuli@...515...>
	<551A4A9B.6010508@...68...> <1430309264.1291.59.camel@...1866...>
	<55413AFE.4080906@...68...>
	<4d1cdaaa3258006757ba75e40a8de9f4.squirrel@...2027...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jSXJDi5r/aeatSyx"
Content-Disposition: inline
In-Reply-To: <4d1cdaaa3258006757ba75e40a8de9f4.squirrel@...2027...>
Subject: Re: [Openvpn-devel] [PATCH] Remove useless dash escapes from the
	man-page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Woodhouse <dwmw2@...1866...>
Cc: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

--jSXJDi5r/aeatSyx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 29, 2015 at 08:33:02PM -0000, David Woodhouse wrote:
> > That would mean we either go into autoconf territory to test for groff
> > run-time behaviour, or we use a particular unique sequence and do our
> > own post-processing.
>=20
> The latter is baaically the approach I took in
> http://git.infradead.org/users/dwmw2/openconnect.git/commitdiff/5f15c83f2

So you put "&minus;" in the .8 file, which is converted to "-" for
HTML - but what happens for "man openconnect"?  Will groff understand
"&minus;" and output a "proper U+002D HYPHEN-MINUS"?  (Not that it's
particular fun to edit such .8 files then...)

(There's a famous saying about "it would be much easier to teach them
all English" when it comes to internationalization, charsets, and all
that pain...)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--jSXJDi5r/aeatSyx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVUFNfKkuBuNlUUl1AQKEkQP+OePg2hdbWK48hwbB+y4K7TI/NP4uSIfY
tYiFiD0uwpjbYePUqbw32dxCQwWxx9HctREC6w6WicfiqRoLJSRWZ4ufGzlwJjtD
zjsF7bAyT1DAiTr3sLhRgTxUf857fiZTm8j1lx9Qahu+cAH8NK8wytZhVLSJDbC+
D7c1F8JlByk=
=BE1d
-----END PGP SIGNATURE-----

--jSXJDi5r/aeatSyx--

