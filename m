Date: Tue, 7 Feb 2017 09:07:29 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170207080729.GK93896@...1296...>
References: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
	<20170207041451.GA11922@...2182...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <20170207041451.GA11922@...2182...>
Subject: Re: [Openvpn-devel] [PATCH] Fix building with LibreSSL 2.5.1 by
 cleaning a hack.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 07, 2017 at 12:14:51PM +0800, Antonio Quartulli wrote:
> > +        if (!ssl)
> > +        {
> > +            crypto_msg(M_FATAL, "SSL_new failed");
> > +        }
> > +        pkey =3D SSL_get_privatekey(ssl);
> > +        SSL_free(ssl);
>=20
> I have a question (sorry if I couldn't check myself): did you check that
> SSL_get_privatekey() and SSL_free() won't crash when ssl is NULL ?

crypto_msg(M_FATAL, ...) will not return.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYmYBAAAoJEB2Cnv7KVigSdD8L/1qgOsr7TiTo2nZGiDZWrDGh
pak57riE6dS8QLoMnooUufBNCsS3NlxlPd2ACaa3x1A6T3mmtiG9YGBWOyH1T/UI
rd93Lsp4SiwBdJTQ14wfhWaq9j2JJJAi8NWot6NzWNZ8bsCWh59q82EZfxxxLaCl
DWS3jIqk9K3j8VlLzMEwNO2gkrU9j4H0H0ti+aktH7yeEwm0EdfEOlUIw9uutlcI
O33ZvhOB50mXppwlCrUmPXk53TyY2Lj2jqsUy64IEff6dF9SbjCZP8VkvRk32/Dz
XWutOGDnWgleOxuU9/mTfvP5BwuHw2xiKACXNyVrbODLX7gRLGrc1CjEYD3zRHrz
CnRMbfmVh47YphujrwHBTYM+NJZRfRnXKxQvqLj7W/W6tFvHB67FFBpPOfLOAlcD
uFdeVgoe0azcwez/TU8gTIvWXnJiKvQ5wwolqjxDjI2129/zOktCpWZvwodNWAFb
9gvVz2vfrZyWjyWapxd2eMK3F6bkANnFTxx29l8Bkg==
=Jg/h
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--

