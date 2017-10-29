Date: Sun, 29 Oct 2017 16:24:18 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171029152418.GF958@...1296...>
References: <1509192147.3021.6.camel@...2316...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LvnU4bbuCGLV8PtK"
Content-Disposition: inline
In-Reply-To: <1509192147.3021.6.camel@...2316...>
Subject: Re: [Openvpn-devel] [PATCH 0/1] add engine keys keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2316...>
Cc: openvpn-devel@lists.sourceforge.net

--LvnU4bbuCGLV8PtK
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Oct 28, 2017 at 01:02:27PM +0100, James Bottomley wrote:
> Engine keys are an openssl concept for a key file which can only be
> understood by an engine (usually because it's been wrapped by the
> engine itself). =A0We use this for TPM engine keys, so you can either
> generate them within your TPM or wrap them from existing private keys.
> =A0Once wrapped, the keys will only function in the TPM that generated
> them, so it means the VPN keys are tied to the physical platform, which
> is very useful. =A0Engine keys have to be loaded via a specific callback,
> so use this as a fallback in openvpn if an engine is specified and if
> the PEM read of the private key fails.

How does this work in an OpenVPN context, as in, what do I have to do
to make TPM keys work on client and server?

Do we need a new abstraction layer here somewhere, given that this=20
seems to do something similar to using the windows crypto layer to
access "private keys hidden in windows" (--cryptoapicert) and/or
pkcs11?

I see more #ifdef in the code and this is usually a sign of "it will
increase testing requirement, and we can't even test the abstraction if
none of us has the hardware".

But I leave the more specific discussion to Steffan and Antonio :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--LvnU4bbuCGLV8PtK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZ9fKiAAoJEB2Cnv7KVigSQB0L+wdZ/e/cz/1pPKDEFaVCCcQf
X2sCVw5Kv97rF4Y/6F3nn98pJ52wJo61UB/9Y1T7X8H8ahoNTGxP28rlQDMiXotA
uesUGDmwSgWkSoDtr3bZQjkw6nAZLb3fhlKxdis+5WnII1PMTuJ+eNgg4Tr7PbJ5
6yiD4kfZYzdvDPx7vYLgdAzDmqUbAh3+GiPDF4DOflgoyPYtSRQoca0WJH1Y/m3S
POHt+O3GjIYdo7aHoZW/EcDKlaviMz90O3wOHkyoLST4glvf9RHFAFOGCyaXfzw2
GOcIEy2ti29d9XXGhIot513caT5m22GWmhjXvHuI1mEli4cptkqx4yOyKO3APKdf
3MtjDRfzGtDTDf0PUQKd/jPLs4U50l01Pqd5DaxFRptXkVlgFJL7R1EhZvMHBEpt
kzyCzAJJ8Atm/z8LjejPOSZ4hsG3qKPYaPFDwQGoq8qpWdpKTg1bCb09VZCJXrcF
h9dQuF30L8xNCFmZCwE4Nwrd7fcCRjGwjD57VWzsbg==
=BBTo
-----END PGP SIGNATURE-----

--LvnU4bbuCGLV8PtK--

