Date: Fri, 14 Mar 2025 15:48:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Z9RBqpYQAwpxq2ja@...1296...>
References: <20240327162621.1792414-1-frank@...2641...>
 <202403311417.42VEHZx9028648@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cDnsoZSCPmDpqbCp"
Content-Disposition: inline
In-Reply-To: <202403311417.42VEHZx9028648@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: crypto_backend: fix type of
 enc parameter
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--cDnsoZSCPmDpqbCp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 31, 2024 at 04:17:35PM +0200, Gert Doering wrote:
> Lightly tested on a FreeBSD/MbedTLS 2.28.7, resulting code still works :-)
>=20
> Your patch has been applied to the master branch.
>=20
> commit 4d907bf46a470ccbd2940b9ecb64d6502d9d86bf
> Author: Frank Lichtenheld
> Date:   Wed Mar 27 17:26:21 2024 +0100

Recent pushes to release/2.6 have caused buildbot breakage on mbedTLS
builds on "very recent" Linux systems (newer GCC).  The patch referenced
fixes this in master already.

Given that it's a quite non-intrusive patch (replacing "int" with
a typedef mapped to the appropriate mbedTLS and OpenSSL [int] type)
we've decided to file it under "long term compat" and so it goes into
release/2.6 as well now :-)

commit a421e94344aa2a2f15575eb5c6d57af48d669599 (release/2.6)
Author: Frank Lichtenheld <frank@...2641...>
Date:   Wed Mar 27 17:26:21 2024 +0100

    crypto_backend: fix type of enc parameter

Buildbot and Github claim "warnings gone, compiles and tests fine" :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--cDnsoZSCPmDpqbCp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJn1EGqAAoJEB2Cnv7KVigSaX0L/j2z5R8A1yuVPObkQZt7gShs
INWrFK1JDLLRr2ME7yo0GYTU11L0Rk7CxzLO8o8mJQYj1Nzq2jGHRgYj8zOVuZ4d
VygFdHS1RB5j0l5Bj6hKP/+JQOG8RGTqbdMQeWRGgG+UaNrisWnN8PdFI+z/q9NE
8ShHZ6O8KjTz/7I19H2b8XNuAm0Oes1eEizhANCs0eMD6HNyG88M2eMwHkVRv1Rw
YONV8WSpYBNPuZT6pGyc16EfUEp+0Hp5H6CedCZmsPzHzFsNPT857C9sRI5eo0hE
8cBWUo0UmK1kzo4JRAzfYH2GaxzOHPpRaz3xHyE8UwJ4YcUQod97cfnZ6pkrKqP7
l6Y6M9CE66EHbxYV7m2o56Jab/nLzZXUhAOdnk20ck9WNGadVK+/eNxHEogMczFZ
50oEORb8I/95yCFVO/aqY3bixHstty20Ek3S5mTRHhlHk7CdYrbcocS8Pb5Dt51V
5zC3tpM3GTAzNwnWJZjMCrJ2/4du4mHeZFLk/ZM94g==
=04I2
-----END PGP SIGNATURE-----

--cDnsoZSCPmDpqbCp--

