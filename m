Date: Wed, 23 Apr 2014 19:49:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140423174910.GM16637@...1296...>
References: <53572C4E.7010701@...1901...> <20140423081058.GJ16637@...1296...>
	<53579C5D.5000902@...1435...> <5357DDFC.2010401@...1901...>
	<20140423163811.GK16637@...1296...> <5357F7F7.4090401@...1901...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aD3VbYq6HWsw/f7D"
Content-Disposition: inline
In-Reply-To: <5357F7F7.4090401@...1901...>
Subject: Re: [Openvpn-devel] Progress on Version negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Timothe Litt <litt@...1901...>
Cc: openvpn-devel@lists.sourceforge.net

--aD3VbYq6HWsw/f7D
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 23, 2014 at 01:27:19PM -0400, Timothe Litt wrote:
> >now - does that sound like it could be the problem?  The initial handsha=
ke
> >packet "under some conditions" (like: the local OpenSSL build having
> >more available ciphers, depending on how it was built) being too big,
> >causing "surprises"?
> As I have noted, we're well past the client hello, so:
>    You are right that the number of ciphers does effect the hello size.
>    But if that was involved here, we should fail much sooner.

OK, right.  Sorry for wasting time here.  I said I'm not the crypto
expert...  just something I've come across before.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--aD3VbYq6HWsw/f7D
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU1f9FqkuBuNlUUl1AQIW+gQAvfmfjP3OWkigjWVY47HSC6DDouOV86gX
ibnRDrSpIx/zmyOdBOoLGtZ4ykIH2bTYieCmm9MGouZXj0+TTbJtHLNeNO2kujPe
QDJVkyHy6KZVfKsQujI7RraVYwpSSPy7+oqz3o2ZP35iEYJtAsBjoTaW5Ux4UKNY
DvTy/4eyIN0=
=mQNZ
-----END PGP SIGNATURE-----

--aD3VbYq6HWsw/f7D--

