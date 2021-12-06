Date: Mon, 6 Dec 2021 16:41:17 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Ya4vHXBmR+20/xQP@...1296...>
References: <20211201180727.2496903-1-arne@...1227...>
 <YazysuRMayAaxCwo@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5WxhMqaj8h2X6Pc+"
Content-Disposition: inline
In-Reply-To: <YazysuRMayAaxCwo@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 1/9] Implement optional cipher in
 --data-ciphers prefixed with ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--5WxhMqaj8h2X6Pc+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 05, 2021 at 06:11:14PM +0100, Gert Doering wrote:
> On Wed, Dec 01, 2021 at 07:07:19PM +0100, Arne Schwabe wrote:
> > This allows to use the same configuration multiple platforms/ssl librar=
ies
> > and include optional algorithms that are not available on all platforms
> >=20
> > For example "AES-256-GCM:AES-128-GCM:?CHACHA20-POLY1305" can be used to
> > emulate the default behaviour of OpenVPN 2.6.
>=20
> NAK on this, for two small and one big reason...

Turns out that this is an ACK after all.  It was not *that* late yesterday,
but it seems my brain already went south...  I merged this, tested it,
figured I did not like the result, and forgot to "git reset" the tree...

... and today it slipped out with the next patch.

Thus:

commit 766044507497c41f0319159c37992788ecb681e6
Author: Arne Schwabe <arne@...1227...>
Date:   Wed Dec 1 19:07:19 2021 +0100

    Implement optional cipher in --data-ciphers prefixed with ?

    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: <20211201180727.2496903-1-arne@...1227...>
    URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/m=
sg23279.html


(the patch does not *break* anything, does what it says on the lid, just
is not strict enough about erroring out - and Arne already sent a final
one for that)

Sorry for the confusion.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--5WxhMqaj8h2X6Pc+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhri8dAAoJEB2Cnv7KVigSJPYL/2/eJQRLPoYD3pNnkIKr3GVi
0to1PpPbJLsXfDqReGXIMZGFlSBFt21v6m246n7gP5yA6EYPSfhgoUXgz7makygP
XB/mJf/vGwMiZdsC2/p2pMyIKzvDS5uDmhGGnXus4R6N86L/Z18NhVW/UkvZet3c
ATZlJD0RTK91nA5oER8i1OD++I0zBDhnrAvARana699S8lx8QA7gVk0SNXnJlJ5r
UdT938ycDMQ4e4N6UMPrn+bvOeA8h7O185XcG/SznZhzwDBGt8lylB3zgJ7aCgiU
5181J+lFYU9BbEjUejWlMcBMWGcwF/hVZuzPMO/m/8wIhUW11AO417tZzetIbHen
7AOdr8X970LgAGrCIa9yuP9p+a/t2ZOsMZjD/ckWZC3Wp68/owvm3lEz174FFN4e
EOoTERgqxOa8yoc/pk/vwEGLXCR/Sb9AVqRiO3kKJEzRFvePQYlBgol4xct9CyRX
eDBLQ1xwbXxE9yC9t3lxf85dU2qT71FBsRwLho4qjQ==
=OY76
-----END PGP SIGNATURE-----

--5WxhMqaj8h2X6Pc+--

