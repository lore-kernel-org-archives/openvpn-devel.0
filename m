References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-4-James.Bottomley@...2316...>
 <31d467d4-59da-08b2-166b-13f62a59b82f@...1227...>
 <1591374528.4728.53.camel@...2316...>
 <1591377595.4728.67.camel@...2316...>
 <47ddb948-d12f-6372-1ca9-34b70dee3f25@...1227...>
 <20200606084110.GY1431@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <fe88bc2f-948d-d0c1-8969-b81ccfe1dba2@...1227...>
Date: Sat, 6 Jun 2020 12:43:10 +0200
MIME-Version: 1.0
In-Reply-To: <20200606084110.GY1431@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WnSxCqhtydIYA0eNEWLqoMWuF0FL0Dc2l"
Subject: Re: [Openvpn-devel] [PATCH v6 3/3] Add unit tests for engine keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: James Bottomley <James.Bottomley@...2317...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WnSxCqhtydIYA0eNEWLqoMWuF0FL0Dc2l
Content-Type: multipart/mixed; boundary="cL0GykQch8ZznFYUiW7mPvlULsQlGgnE6"

--cL0GykQch8ZznFYUiW7mPvlULsQlGgnE6
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 06.06.20 um 10:41 schrieb Gert Doering:
> Hi,
>=20
> On Sat, Jun 06, 2020 at 12:48:36AM +0200, Arne Schwabe wrote:
>>> So if this works, with the eval above and full path substitution in the
>>> openssl.cnf.in I think I might have a solution.
>>
>> Unfortunately not. Still creates the .so file.  If everything fails we
>> might just do a if mac then cp from .so to .dylib as part of the test
>> run. It is ugly but might be better than to wait forever on this patch.
>=20
> Naive question - can we not just use a .so on Mac?  Like, consistent,
> build .so, request .so from openssl.cnf?
>=20
> (Haven't dug into shlib weirdness on MacOS yet.  But if you want, I can
> tell stories about shlib on AIX.  Which will make you ask for lots of=20
> alcoholic beverages so you can forget again...)

I thought I tested that and it didn't work but I tested it again and
that also works.

Arne


--cL0GykQch8ZznFYUiW7mPvlULsQlGgnE6--

--WnSxCqhtydIYA0eNEWLqoMWuF0FL0Dc2l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7bcz4ACgkQFRhsZwKx
RFTcthAAsax6enc4qCBszscUKxiLzEtGyqXt2F/qoyRkBjUkqS+NL+9vGjEFv9iR
e6zUKeOaWSb6EyeGvr7Qy1Vo47SejDGl/vj+ToYI+cRvKYLTB0/dtXoQo8Ip1gML
vJaNlNcstL0sCJwqq/aG7SEU8ySjeJjr1j1kl+Pi+A7dsGI9/I/DPL7sa+EcZOH4
rEJjg2IMlTVWbFYROIJovb9byIN5RBUqDa4QK5WWQidm/Vm7s+4zmkzEc5ZYSb1p
ZG5JjaL7IsOsQdeCuPbvq6dzzwomLLy5GzhPIYyyKf5eX+SIe/aDjr/JHeKgaQVh
0Zk0ux9LkLEQkPxgvf264oHEAklGP1SrGWzanXuZ/rL4uGCYard1SWe5cWnn4qCD
bOJ7DKGnatk7D8i9yQXUXUPbr/UY8oX/rgAwJjJRkrDoO10TK3YCv9SU+3B4M4tX
kkRsKxuFl56wmcTZ9HqL1k1WVgbhHe4qGLZvoNB16MVOmFcleAiRvzOjcbqwFv9q
VT+EvLs0g+PxksU4Ys6nFLsFkYpMwiaqFukRvFYbOKwlqPGf4D9ur4oA0rFthEqb
8JeYY8JAaAOldqqotQQF/YHqHWo61dzkTGvdyE15v6QOQvJ23nuTWpJe4NgTga3E
0vx1Yli2xfHtBx+GzBtB/GbN5IEiEjamWFzHNmcRdHisu5LR0NE=
=q+A9
-----END PGP SIGNATURE-----

--WnSxCqhtydIYA0eNEWLqoMWuF0FL0Dc2l--

