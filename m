Date: Mon, 13 Jul 2020 09:14:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200713071436.GO1431@...1296...>
References: <a1cfd42d-e371-187a-55c2-f14a3a986b34@...1823...>
 <4562876f-45c1-d3bb-f725-52e9b78600de@...1227...>
 <20200623090252.GE1431@...1296...>
 <4f03e378-f327-21a6-9f11-fe06a42052b6@...1823...>
 <518ceb3d-e060-f777-f19f-4998b8d27170@...1227...>
 <3f6159de-c513-78d5-194c-989a8611c291@...1823...>
 <20200713061023.GK1431@...1296...>
 <20200713063303.GM1431@...1296...>
 <20200713065828.GN1431@...1296...>
 <0fd510b1-2d22-c860-79b2-e3ea01609c77@...1823...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rn1nbyIinsnfxg9e"
Content-Disposition: inline
In-Reply-To: <0fd510b1-2d22-c860-79b2-e3ea01609c77@...1823...>
Subject: Re: [Openvpn-devel] git master crashes on connect of 2.3 client
 with --enable-small
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Dmitry Melekhov <dm@...1823...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--rn1nbyIinsnfxg9e
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 13, 2020 at 11:12:30AM +0400, Dmitry Melekhov wrote:
> I just applied patch, now server works correctly with 2.3.18 client=20
> compiled with enable-small
>=20
> and with 2.5git with enable-small and ncp-disable in config.
>=20
> I.e. everything works as expected.

Thanks for testing and for confirmation.

I'll leave the decision if this is "the right fix" to Arne, but at
least we know where the problem is/was.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--rn1nbyIinsnfxg9e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfDAncAAoJEB2Cnv7KVigSHsoL+wTPIpf2UzkqQDuxPZqpFUp3
Czz+u9rO7fu36+Jh9H8RrLWYN6/3XUX2Sny71zKgUUej4OzO+wt096VdFC3EmrB/
JsaxFExQwOzfGUjVY+zv0DERUWpF9sjVqPK+kmsXOa37TiPby4++q6omfwIhmLH1
ZhqPy4ixBm5taLeeOCVUAl5f/2dLcEFu7W5OeXV9x7HqtQlPN8q303wSiDZXO4It
fMEV3AXd83No+OZ6YhWTip3ciOSdz8qwwoSDf+urn35k1fpbAo6UDcfcFIfqegZm
LJKH7nnV84PbkTJOErJWx0FF3a61ZS+sRudyKqexnHXtQXJi+MRQ1PaKZV75NjuO
7mVPCKa5y0b9Rg/vqGk+O9mFJNSPBUFtQdWXFHTYYQTdlU5nvj85s1orMQmwZFBx
wOFOO1Dn821B0g7O2z5d6SN4zifeKCfy4vUs1/6HiD8U3X8eOr9XqLZczeKPfExR
BqUTuBrByepEkaHelXyW6SqN2v7kQMTqB+jyf7SWUA==
=VUqs
-----END PGP SIGNATURE-----

--rn1nbyIinsnfxg9e--

