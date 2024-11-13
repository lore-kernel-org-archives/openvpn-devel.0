Date: Wed, 13 Nov 2024 14:40:49 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZzSsYbPCj1-KyjcK@...1296...>
References: <CAC8x_z0TS=A_KcSZGT0H-EYR5_v03jVi=uEJMCC+83UELnEs4w@...278...>
 <67c0a3ca-4d9e-498b-a70c-5e0c292b23f7@...1227...>
 <CAC8x_z3SoZhoZf6gjcCacdvUJN3ZCZthUiBJVkQKTj7o8aXQtQ@...278...>
 <ZzShea1-8V3rT8ET@...1296...>
 <CAC8x_z0i5zRHd8_29AQ-DkuZWr_rF_kMms1RHJLUBFwtbrT3ow@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="lePsx49HRZzKlisl"
Content-Disposition: inline
In-Reply-To: <CAC8x_z0i5zRHd8_29AQ-DkuZWr_rF_kMms1RHJLUBFwtbrT3ow@...278...>
Subject: Re: [Openvpn-devel] Inquiry About Potential Vulnerabilities in
 OpenVPN for Remote Code Execution (RCE)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ?????? ???????? <nsh531@...277...>
Cc: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>, Openvpn-devel@lists.sourceforge.net

--lePsx49HRZzKlisl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 13, 2024 at 03:05:11PM +0200, ?????? ???????? wrote:
> I am reaching out in the hopes of getting assistance with a potential
> zero-day Remote Code Execution (RCE) vulnerability that I am investigating
> on an Ubuntu-based OpenVPN system.

If you have *found* something, please let us know on security@...515...,
so we can fix it.

If you want to *ask* whether there is a known RCE, there isn't anything
we know about.

If you involve scripts and plugins, anything goes, of course, and we do
not intend to fix that - OpenVPN on Linux is software for grownups,=20
which contains spikey bits.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--lePsx49HRZzKlisl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJnNKxhAAoJEB2Cnv7KVigSL7QL/1cOhDHYdHW4bg3bIpsSRZa1
sPC+YN9PhhBXAH6FEekmCLZQnIDMClZf8rK/fCrJFS5L4xBuJ3s/Y9Im+sSo5uza
XSC3xKdrmxz3b2ApGECtbfvR5sssjpWHGjfagLh4dciQSxqi2QZKQKkiGdZ1mP1p
65cg9KqyWJumyyfQx27q49tcTYPlvUAbRLZjv24h/U6kjMzQ5F06u2Nz6uJaiY9l
95zbWM+g6XTAvGCFNkgPJgkIpA0nujN1ZpTku2YoTUSLX/qQXiK+/6hFPHY+jWlA
HZ9Y8mIBzSIkmv9ufYUWHARHO4RO5FAyyaly8m/g1Zn+DnSQdGupzGrSLO/CKFj8
fnzQjzN+G+/ABGQa0a79M7TlIHlBb9+2rnErfnbs8jOy1BrqTGcamGxeKZ54gHri
uRuijao6q6FXkGi9mzCW7wrbnItDMtyyvBhrbwkOm7pK8HUhbmbzDLqvfEMrrRXg
sRf+sHv/A+2CwxrZtFbhEWJTRGsaUhM2pab4ffYBSg==
=GgNe
-----END PGP SIGNATURE-----

--lePsx49HRZzKlisl--

