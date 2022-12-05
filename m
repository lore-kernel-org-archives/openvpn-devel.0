Date: Mon, 5 Dec 2022 13:00:44 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y43dbDUw9m+dgrJG@...1296...>
References: <20221012133457.1927871-1-arne@...1227...>
 <20221026164522.3773718-1-arne@...1227...>
 <CAGyAFMU6RDJOo6YOYaHXPxfqS0Xt1ctGx_wrF2X-GKoiYsM+wg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="YNQnfaFPlFv6d5CN"
Content-Disposition: inline
In-Reply-To: <CAGyAFMU6RDJOo6YOYaHXPxfqS0Xt1ctGx_wrF2X-GKoiYsM+wg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] Move dco_installed from
 sock->info to sock->info.lsa.actual
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--YNQnfaFPlFv6d5CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 01, 2022 at 11:21:40AM +0200, Lev Stipakov wrote:
> > @@ -1190,7 +1190,7 @@ link_socket_write(struct link_socket *sock,
> >                    struct buffer *buf,
> >                    struct link_socket_actual *to)
> >  {
> > -    if (proto_is_udp(sock->info.proto) || sock->info.dco_installed)
> > +    if (proto_is_udp(sock->info.proto) || to->dco_installed)
> >      {
>=20
> Previously we used to check the dco flag from sock->info and now it is ch=
anged
> to "to", which is a separate member in c->c2 (c->c2.to_link_addr vs
> c->c2.link_socket).
>=20
> Why not use "sock->info.lsa->actual.dco_installed" ? My understanding
> is that this patch
> only moves the flag to a different place and is not supposed to change
> the behavior.

For the sake of the archives:  I asked Arne today, and the reply
was "this is not pretty, but with Antonio's upcoming changes to DCO,
it's likely that the dco_installed field goes away, or is reworked
significantly".

So for now, we leave it as it is, knowing it's working but not perfect.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--YNQnfaFPlFv6d5CN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjjd1sAAoJEB2Cnv7KVigSq7wL/0R/GG3TV9FyZVR36kEF++EE
yerXZbjTXbeq0CrAYnYEId9tMuM0qvosBQE6/EcF448PgGRaxJVkD9jWPcs6xszc
KqiMHvIICW0t6Q5SaKK9rTySL6ENAkNDABTpUl+7p8Md0/aRNwvKd9H5E1gGEej7
9k+TTmylW93dhDKmCEh8gwsR/FrqIYzj0BFNkVzB2IFauRwkkv95p2mafe3Q4SZv
u69Zd4c8GH18cC4yAywJYW7phNjRV9PgONDpwann8vqgGzNV0L1jlhSzodCyHHYT
MMVsbf8BbxbVOW3yUREMF29NtMRKwHgYkbtzsVd3D3d26k0uCSmrKFqsKeUOAU8+
EOo6ag7aNk8rRGZ/vKt9QLcDqBTIO2a6fMB+Od4D0dNZfD040Q/FPor8vafYyBu1
l80In/Uf5UWK7GpfI5QWPfKRpcCtQhwf6yBtpxcxNoGHTr6SBMLsjB+kY1qY6qwK
b5PLIqTYbzTX08mQrPcAgIknMJGD372jN6n1l4CR1Q==
=9GGr
-----END PGP SIGNATURE-----

--YNQnfaFPlFv6d5CN--

