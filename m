Date: Fri, 13 Apr 2018 22:10:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180413201012.GT69387@...1296...>
References: <CAJ-EccN7eQsSaFn4MH4qRTKx+zZ-1YcGAe0XU8813p7k=W2i4g@...278...>
 <20180413185809.GS69387@...1296...>
 <CAJ-EccPw2JAMAvYuhbD5kqfuVzBj5B7SDYXhXAMHMbAA0X=HgA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fpf5Rj6mIjSgR+2y"
Content-Disposition: inline
In-Reply-To: <CAJ-EccPw2JAMAvYuhbD5kqfuVzBj5B7SDYXhXAMHMbAA0X=HgA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Specify platform and version on command
 line.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Micah Morton <mortonm@...1913...>
Cc: Gert Doering <gert@...1296...>, jkbullard@...277..., openvpn-devel@lists.sourceforge.net

--fpf5Rj6mIjSgR+2y
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 13, 2018 at 12:34:15PM -0700, Micah Morton wrote:
> @gert:
>=20
> From the help message: "--setenv name value : Set a custom environmental
> variable to pass to script."
>=20
> --setenv appears to set string values for scripts only, not for the main
> openvpn process (which is reading them in the push_peer_info() function).
> Starting a test openvpn server with `--setenv foo bar` and then running
> `strings` on /proc/PID/environ doesn't show "foo=3Dbar". This suggests th=
at
> getenv() calls in the main openvpn process that try to read these vars may
> return NULL.

This stuff isn't pushed into openvpn's own environment, because it does
not need to.  It goes into session->opt->es, which basically is a linked
list of "NAME=3DVALUE" strings (and ssl.c / push_peer_info() walks that).

When external programs are called, opt->es is put into *their* environment.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--fpf5Rj6mIjSgR+2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJa0Q6jAAoJEB2Cnv7KVigSZMML/2R1zHoVZ0pg7RqcuysB8a7S
qJzdC7URefgDuWM6xlamYs9IRM3DhPOTChoCGQlb6V3Ewf6jgFp6bVGQGU5w4Vlq
9EgCiR/m3eXfCagV/csnLb4be8+GBWgjp23Uj3xRDrlUoU4USyAWx8V4h0UIF7ql
Yfe6eknS/6xZoHxSi2OyofySP993yL1VZM8ekGtfB9TPO6aSB6qgXmMQ3bb6nlWm
uBFA0Czxw6IzYfKoXqsMskHq8yr9lhTU6Fi7sHsVt3QaN8hBj4E9XZt4JvOYZ1Lr
NP5WgQNKGd2t4i9PLqjgywwsl1t3AH2cYLCxqE3P5qNZkfYnAJpxL5qujp8krIav
G4vdK19Cnn1W19LFtQ0iPcAa+spkwiSrdPcRzY3lpnXAnsL2pJn9VDxrRA+8S+00
69c1xect7WqUOx9rtnontrwBNMXSDiv/Rjomk3Db5myspjX5q0zKqui6SVIM/J8e
VdC0k+h9GR+tVsYSifY8eMJCMN2h8Uz0up61kwaOxg==
=VCqp
-----END PGP SIGNATURE-----

--fpf5Rj6mIjSgR+2y--

