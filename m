Date: Sun, 26 Feb 2023 11:04:28 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y/surGeMiBj01brz@...1296...>
References: <20230130172936.3444840-1-arne@...1227...>
 <20230130172936.3444840-2-arne@...1227...>
 <Y/suKJIyDKICDxXu@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2bilG+t2+dtxhsFr"
Content-Disposition: inline
In-Reply-To: <Y/suKJIyDKICDxXu@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 2/5] Fix unaligned access in
 macOS/Solaris hwaddr
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

--2bilG+t2+dtxhsFr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Feb 26, 2023 at 11:02:16AM +0100, Gert Doering wrote:
> I'll check the other BSDs if LL_IFADDR() is available everywhere, but
> if not, we can just do the same thing (struct ifr is aligned) and
> get rid of the "sdl" and the first memcpy().

Of course neither Solaris nor OpenBSD have the LL_IFADDR(), but that's
trivial enough.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--2bilG+t2+dtxhsFr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJj+y6sAAoJEB2Cnv7KVigSkIYL/RUurV9Qyjso+oAm8Vo93pcr
o+qM8T+tYbrJpT/7XbpGr/mXds6VIQu1RDabNlmsw9vmMv6aKlTWwW1VI45m8h9T
5nsToszGaBeSA2bxDvtrC+Az9rfr6TFMtz/xCqv4WZtsgAMT3bwMnq5ZulVOGF+u
k0nEkRFZHSt7UoTGVHI07iZzQAgzDKQS2Vt1tyD2shdBa62iB6TRZNgdLHic7MdK
UhDGeVeLuIilWpxA1ij7Oeu+ZMG4ArJEFdaIsj/BbFD99nTVc6dt3Lb+XU7lywKH
vx9vqElbL+m5Wy2YKPSPIfvZ2VgTuhR4ee9r+Q3HeRLhMaU0LGlNElAEe8916omZ
UaA+BfSc9/xHHuchOyGCiLyYm+L4Xt85vbQArKLlC5yHAK7pdl6of5vxzBgqzGDc
1l6ZmibSyP/BR4Zol5XaXdJOkl9ugprH/qZXxNdvD5G+/uYu6kDp262ImsuVjNN4
W4HbD69ZR8VwLIlu+CQJFAyj7YGZJbv2Ucew+VHMWw==
=+FqW
-----END PGP SIGNATURE-----

--2bilG+t2+dtxhsFr--

