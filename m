Date: Wed, 21 Feb 2018 08:36:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180221073610.GS69387@...1296...>
References: <1516909513-31683-1-git-send-email-selva.nair@...277...>
 <201802201030.w1KAUZKR065496@...2054...>
 <20180220120355.GA66512@...1296...>
 <CAKuzo_g2Rhkh10PMp7cuCW8m7zpMESQ4fq9TBz202zbaB2Zj7A@...278...>
 <CAKuzo_gCQBNWcxhsVKn86xM5sRr38fS2HCqgz0NS1Y8vxbtQAw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3KjGcObhCP65ZtLm"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gCQBNWcxhsVKn86xM5sRr38fS2HCqgz0NS1Y8vxbtQAw@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Allow external EC key
 through --management-external-key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3KjGcObhCP65ZtLm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Feb 21, 2018 at 02:07:03AM -0500, Selva Nair wrote:
> >> *This* one breaks LibreSSL compilation (namely, the OpenBSD buildbot),
> >> because
[..]
> Tested using the freebsd-11 box in openvpn-vagrant and did pkg install
> libressl-2.6.4 (that replaces openssl 1.1.0).
>=20
> This particular error gets fixed by adding
> !defined(LIBRESSL_VERSION_NUMBER) in two places.
>=20
> I can send a patch for this.=20

This would be appreciated (please --cc me directly as the list is still
not working properly).

> But there are other errors:
>=20
> In file included from crypto_openssl.c:44:
> ./openssl_compat.h:699:1: error: static declaration of
> 'SSL_CTX_set_min_proto_version' follows
[..]
> ./openssl_compat.h:728:1: error: static declaration of
> 'SSL_CTX_set_max_proto_version' follows
>       non-static declaration
[..]
> In openssl those are macros but not in libressl so the current
> openssl_compat.h defs don't work.

This is interesting.  Seems my OpenBSD version is too old, as I've not
seen these errors in my buildbots.

Let's fix one thing at a time, and start with the easy ones, which will
make the buildbots happy for the time being :-) - and then look at
"more recent LibreSSL fallouts".

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--3KjGcObhCP65ZtLm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJajSFqAAoJEB2Cnv7KVigSEbkL/1dtFpZD4lb19Z3eWVBVLtWD
XqQo7FAaXlQg76kk5P6jLUbqQ/dzaYFNoFm7z74nYTbrwmq6wGJ+LXkmNJ0XrZUq
0+xyYPUSqvakCDTLlU1QaL5DyJ7DNEBZZI/BwY3zvhIKpUPhYDIvRijo++P2fioY
xPD2Of5Q1GILBfwZcIv7PNJoc42Tp0xmEFtuj6wBmDIzSr25SEhBKDwCMLUCF1AW
3pko0LM7q8y4UfP/mge9BX5NI42cMvcPuEexLBjyIzzRcSfy+oqk1MRXYX6n0TzT
zvJHCzachRdx3PzGIzvm1f41ne9Zc6fGLpesoYHSlFIRNhUIma0AW2WZG6HIfGwU
M4hGLHTxWrrSuU+5G4ACPsN5Jll8h0m/pAegWkd1PuGIEb4dtdfr6LW/A/jnJo1Z
GIgEYfLYpfwapU4gLwCEWpzQ1/8zUK+PY3/FbjLVHD9MbRls9aBOqhNiOKBmbdPi
Lsc2IabPbFj2u+zrkdWhG/oqzEETtzW8NAk2nHYsRQ==
=n3T9
-----END PGP SIGNATURE-----

--3KjGcObhCP65ZtLm--

