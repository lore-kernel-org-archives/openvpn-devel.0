Date: Thu, 1 Apr 2021 14:37:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210401123701.GN976@...1296...>
References: <CAAUX2SVQRn4zuDC947HE9M38nDNK1oNqyUv0GKeAw2dasHo62Q@...278...>
 <ad7e8624-6f87-2874-9786-d5de521bc6a2@...2181...>
 <f10fc09e-5d7b-c678-02f8-04f80f004b24@...2181...>
 <CAAUX2SU9u8sdsN08ynDTVD15q+qP0yOF-RxMzF5hMRg-pFCWFg@...278...>
 <CAAUX2SXiT1=-5HtKzQRay-R1zreT0_7QpEvjc40H3-0U2nqcAA@...278...>
 <69feee58-499e-98c7-5fec-e78368198d4a@...1227...>
 <20210401121014.GK976@...1296...>
 <962534bc-5687-0ffb-df63-0e968d6e68d1@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EFfbqXYkOh/Ekkqb"
Content-Disposition: inline
In-Reply-To: <962534bc-5687-0ffb-df63-0e968d6e68d1@...2181...>
Subject: Re: [Openvpn-devel] [ovpn-dco] sudden network disconnection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>, Tony He <huangya90@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EFfbqXYkOh/Ekkqb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 01, 2021 at 02:16:25PM +0200, Antonio Quartulli wrote:
> > (Of course it makes lots of sense to defer this to iptables etc. on
> > all platforms that have DCO *and* a reasonable firewall layer... dco-win
> > will be interesting)
>=20
> Features that are not compatible with DCO are being documented in the
> code as we go.
>=20
> If you try to explicitly use one of those with DCO, openvpn2 will log a
> big warning and will tell you that it is switching to non-DCO mode to
> make sure your connection can work.

Which is actually interesting for mssfix, as that is "on by default",
so "all configs are incompatible with DCO", by that definition :-)

> However, we will definitely make some larger doc explaining what we
> decided that DCO should not do and what are possible alternatives.

*like*

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--EFfbqXYkOh/Ekkqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgZb5rAAoJEB2Cnv7KVigSrh0MAI8VXxtL1RGVK0NKw6l59nKJ
XRS1OyjpStzXYoX1sN4o0DXI/CS/hB3TgaVGA+29S5Rk5xV1Jk9UOjE+rAdk1x1m
PzbIywnNJFyKtQ7Blr9sH8QxhT09NcwnoMmU3y0kl+WFlh/+oRGCwKvlV7sgmlzN
mMIc3zHAiw8ZwvgXO9tEn/j3NE9aDjUsjL2Pxers6RU0MMqbNScWIP6PqGGEIqFM
XTjeweFoKcFzIY/FEwJX4MAoIkqoC7qVRMt1OSzsuzVzzDIzqKVuuGVwFX+juSPa
UQYhT+jegQgPhe4gOURIdIhUZb3lOuI1c1sE6jRDv/aJWPTGysNHv0LVUw4tzQna
PWTKRNhw78kkxdAJqVHqy2TEbqeVVp+ieP3H+rLFRz4sKaiVqgQL8uJSKWM1jIz0
8ZyGpHrU8bRGkPrwWyYLMUd8NFIG1dzzHmlNQq38tJytJMz/hNgJp5J6LmSiVYkl
RaUo9xhBYjjGN+nTHodDKqTtTaaY/3Cs7U5nphMnHA==
=pVCv
-----END PGP SIGNATURE-----

--EFfbqXYkOh/Ekkqb--

