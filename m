Date: Tue, 23 Aug 2022 20:55:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YwUinOP01/bMpf6l@...1296...>
References: <20220822154037.44320-1-maximilian.fillinger@...2507...>
 <202208221832.27MIWLif003899@...2054...>
 <66bcce76f7df4aa1861a3f44fb723ac7@...2507...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1Dkelarow/VCiMDx"
Content-Disposition: inline
In-Reply-To: <66bcce76f7df4aa1861a3f44fb723ac7@...2507...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Update openssl_compat.h for
 newer LibreSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Maximilian Fillinger <maximilian.fillinger@...2507...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--1Dkelarow/VCiMDx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 23, 2022 at 10:21:30AM +0000, Maximilian Fillinger wrote:
> > I'm a bit unsure if we need this for 2.5 - it's "long term compat"
> > and not very intrusive, but on the other hand, not too many people
> > seem to care about LibreSSL.
>=20
> OpenBSD has packaged 2.5.7 for snapshots, so they must already have a wor=
karound.=20

Might be worth looking at their ports tree and see what patches they
apply...  (putting that on my heap of things to do "really soon")

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--1Dkelarow/VCiMDx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjBSKcAAoJEB2Cnv7KVigS2WAL/i+iIxdV2a/S8bdBDERKwhA+
18GNHZ4f9rMxqQ6iB7ldXqRy1w7tWjsKlH3m/eBONtHqladx3UqVYX33b5wpcLFs
WaQWgmRZEYQlABCfJVzw3upPTzC2iQjHTbnRtKQqMAI1wqw1xF2AM45moBl9D6LV
WBsQssXQHeHrwPtbI9Bp4DhNDosa0c4qUbikXNH1A1X2UEPiup/J+zPvUoWXVI4N
cL4UxcKigqhZzXBzg32o0QpffIq6lCLIkulBuMcJuLa4FPa9Wp4Atb9zK+LsEQzd
cQAQ4ZjjjxzjxGLs3u5wRa1TDVrqQpAuLiS7Z5ivAZ7LZL8FQwUKsAjxFmHgYoOJ
KAYYBjGuqB2XBIlwKDoDRemybQr+8qXsdabBA7E7riwfu/OB6uxdJeyaqar7T5yJ
Ybpr9QaVfYIfUYsygwc8ED7a3F/17gXyWjR+g+fX30pqmzCKrdhQfCjWpY8r1JYf
wvpCC0J3aktk+QgT4Eqz/mHaDT72y81KVCvsvMxUkA==
=wunF
-----END PGP SIGNATURE-----

--1Dkelarow/VCiMDx--

