Date: Thu, 21 Jul 2022 20:10:16 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YtmWiHwRXkt/m7Si@...1296...>
References: <20220712214642.13533-1-a@...2181...>
 <20220719141639.14636-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LUif9vVMXxkRAPxN"
Content-Disposition: inline
In-Reply-To: <20220719141639.14636-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v10 05/25] dco: let open_tun_generic
 handle the DCO case
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--LUif9vVMXxkRAPxN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 19, 2022 at 04:16:39PM +0200, Antonio Quartulli wrote:
> open_tun_generic already contains the logic required to find a device
> name when not specified b the user. For this reason the DCO case can
> easily leverage on function and avoid code duplication.
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>

*sigh*

First of all, my apologies for letting you jump through all these hoops -
I'm NOT doing this to annoy you or drag my feet, but really to keep the
code readable and maintainable.

That said, I've spent two days now pondering the latest version of this
patch, and I can not ACK it - it's ugly beyond openvpn standards.

My main gripe is that we have this open_tun_generic() function which
is used for "all but linux (and Windows)".  So you add a call to it
now for the DCO call (this is okay-ish) but then it's not actually
*using* the code paths in open_tun_generic(), but adding new and
linux-exclusive code paths #ifdef TARGET_LINUX.

So, on Linux with DCO, very little of that function is actually used
(half of it is #ifdef TARGET_LINUX, and the non-#ifdef parts are=20
"else" branches for "not DCO" - but "for not DCO", we do not call this
in the first place) - all that remains is a for() loop to iterate
device names, and a string_alloc() call...


That said, I've cooked up a v11 of 05, which introduces a much
leaner open_tun_dco_generic() function - to be shared by Linux
and FreeBSD - which does "only DCO things", leaving open_tun_generic()
alone.  I've tested this with the usual test cases

 --dev tap    (works, because options.c will already disable DCO)
 --dev tun    (iterates to "tun7" on my DCO test system)
 --mktun --dev tun471 ; use --dev tun471  (works, falls back to tun)
 --dev tun472 (works as DCO device))


Right now this is sitting on top of my clone of your "dco" tree -=20
I'll see that I can apply this to the right parts in the middle and
send a 05 v11 out later, then we can haggle on the least ugly way
forward.

gert

PS1: I'm fairly sure *I* did the existing #ifdef TARGET_NETBSD in=20
     open_tun_generic() and I should not have done that.  Bad precedence.

PS2: 05 v10 works, and does not break anything, But It Is Too Ugly.

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--LUif9vVMXxkRAPxN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi2ZaIAAoJEB2Cnv7KVigS2yUL/1nyGi3Z+xUxyb3CIV1VMVsj
hjtinU4eBgo1YnJO/gtqONFdX79UOMpUHRZ9YsKh57pLiQI0UFoPm7FznI6sqbxz
NkiJ/2OFhVJkkAQNsTvSZR8uRRJ2IRTn5RjppBd41xau6l9eQOgX8Mm/9/+YGKwY
PDuaNQaizSYUjHCoISRzOIeYOtNh5lVx3sziwK5EjZiLG9gQYM8cmb12f07/ySw3
IPobp/F3/R4NdDLd5Bp4rRScmHat1wbCylP4TR6kbUwP2dOQUzUK5Mt/G/hIrRpQ
2+hF14QnRaO2IOGO8wwN2JbZqNTwsCSbItNNN233Rhvj2HvwH79W3CLiuYwELxC5
sESM99n1ecCxw8DhzGvTztJQ958mPsHxxqXW0qLGzGCtmkvVl6gABFPJ85FPXaiu
JG2loYGSDNO2aEFM6/dG6+5tieVyUUMFbDOjBYl/CcosNVMkDB76QTztqCvDKcwx
RMCcr/C/SBMOGYuYH6GZHFKX51/AgMvpXOtCkc2/Mg==
=fupR
-----END PGP SIGNATURE-----

--LUif9vVMXxkRAPxN--

