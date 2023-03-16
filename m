Date: Thu, 16 Mar 2023 18:49:51 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZBNWv5qLDCZw0atc@...1296...>
References: <20230228042645.38863-1-heiko@...2662...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="032i5PtTuupNcRsF"
Content-Disposition: inline
In-Reply-To: <20230228042645.38863-1-heiko@...2662...>
Subject: Re: [Openvpn-devel] [PATCH] dns option: allow up to two addresses
 per family
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

--032i5PtTuupNcRsF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 28, 2023 at 05:26:45AM +0100, Heiko Hund wrote:
> Signed-off-by: Heiko Hund <heiko@...2662...>
> ---
>  doc/man-sections/client-options.rst |  7 +--
>  src/openvpn/dns.c                   | 70 ++++++++++++++++-------------
>  src/openvpn/dns.h                   | 19 +++++---
>  src/openvpn/options.c               | 30 +++++++------
>  4 files changed, 72 insertions(+), 54 deletions(-)

For the sake of the archivers: this has been superseded by the new
patchset "dns option: allow up to eight addresses per server".

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--032i5PtTuupNcRsF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkE1a/AAoJEB2Cnv7KVigS8k8L/3xsv4DwicjntFPf2knJtxJ3
f8/VwrwDBjYm3E6QuLKiMOiwC9fZvYjTkkaxYr89QS7NS6P7Ga2YKyIx1Bs+zdys
eKZY4ewan90sKD5A0EFk3SIdCnxjvSuxEwSR+3x6BLurAGmtskGzlHh0evpt1xMH
sOGP1/KhcM54BhtqfbJLe+YUKGfH80JMESMZsvVHxMUIETy6qipRbHX+pB6C/qPX
46x3dYpEUS89fadSpqNa4isKkBjjLCdqPJ0AnFM8Rg+e3vMRWUjlbTrzZsBFKqtU
0qlevkpe1lV2d5+NmQWkDJnsRkOvZdnckWf0dlhS2dNAMoVhHhzHrUCcU9mV2ujV
ssVfktyZJMRcpmGbC90zgQeZHID46C8aER/vF9/ESW1cOFGtnLtCiY3zEq85kF4w
0LL19P/Bi9t/HNk4CBkSMyl6lHqNUGY3CsgHGxAOX2OTIQ1GDM4n7BXJmgOtfa2S
FFv+jLTV2uobtEvd0c9ubZuOG8FhMbDARm52ctt+tw==
=5KRP
-----END PGP SIGNATURE-----

--032i5PtTuupNcRsF--

