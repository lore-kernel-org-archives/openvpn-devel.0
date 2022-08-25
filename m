Date: Thu, 25 Aug 2022 22:36:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YwfdRXTtp91VfJYd@...1296...>
References: <20220824165718.102002-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="m2+w/4P1CNHkSpDe"
Content-Disposition: inline
In-Reply-To: <20220824165718.102002-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix delcarion of pubkeys in
 test_provider.c in MSVC builds
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

--m2+w/4P1CNHkSpDe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 24, 2022 at 06:57:18PM +0200, Arne Schwabe wrote:
>   Error: test_provider.c(74): error C2099: initializer is not a constant
>=20
> Fix this issue by making the const char* to const char[]. This is probably
> of one the weird array decay corner cases

Out of curiosity - does the error go away if you just remove all these
"const" from the declaration?  Making this just a "static char *"?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--m2+w/4P1CNHkSpDe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjB91FAAoJEB2Cnv7KVigS3zwL+wZgyn4/zw66mcYfWqi/BqOj
EFH9GU9BFE3G88M6DboensJDNVRwavDi4UkgP1/QJgUPytjhCCaVdJGf94ptaSIc
Z8V0SoAE1tPrTk5VEhvjjNEXTdKcdBteqLU6eTLayJmS6Tk9Hrc9w2BDlnn35LkN
/1mhY8yqs5bvNz+/CFwQI9vXE4AVNS8zIBO9zWnLOVNoA1qSN3qUnaX9AVDFa4pI
t1elN1iSwAhZi4Mi+1Yt49U4pFRIYNZIsF3shFRgHo8Ov8NtIXuvmo+B2TQqV0NB
Dvmcr/LufJN6l71QenUhpDXGKHr578icIwgoN9ptXEuQ4DmzID9nNP8HxxcJgsEV
cD8tFpL/NfngqGepad6nHP/e+vmj/2hnn9EvxTjXrUPbqsn65PvOEuoIq5lPP8s9
Ta8PpRV/StnXkSIu0I2FtduPr4lH9qZo/EDSTsghWUKgi+sDo9D+0s6gMErohyIv
6SsUsXKOTl92qREkXa8VEGTQO6TfAYrboYrq/b/g2g==
=U3e3
-----END PGP SIGNATURE-----

--m2+w/4P1CNHkSpDe--

