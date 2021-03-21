Date: Sun, 21 Mar 2021 18:11:05 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210321171105.GZ976@...1296...>
References: <20210321144627.1621-3-simon@...2293...>
 <202103211705.12LH5Jab075585@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+HVON39KQB+h9JME"
Content-Disposition: inline
In-Reply-To: <202103211705.12LH5Jab075585@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: interactive.c: Resolve MSVC
 C4996 warning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman via Openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+HVON39KQB+h9JME
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 21, 2021 at 06:05:19PM +0100, Gert Doering wrote:
> commit 709c3810a1d67e2c4049e852529a0a0d1338c797
> Author: Simon Rozman via Openvpn-devel

Yeah.  Right.

So, apologies for not catching this in time and fixing the Author: line,
but this is exactly why I brought up the DMARC issue with Max Fillinger
yesterday.

And it royally messes up patchwork as well, because patchwork only cares
about mail addresses internally, and shows the name "last seen with that
address" - so the Patch from Steffan / Max is now listed as

"Simon Rozman via Openvpn-devel"

as well... https://patchwork.openvpn.net/patch/1628/

*sigh*

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+HVON39KQB+h9JME
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgV34pAAoJEB2Cnv7KVigS3/wL/2/VpKcXSDOJZi6x9hwv2yHN
nu9VrSrMT8s9NlwJn8qXH9t3V21aqdHezeseuCIlrjXWdKOnwK4KYDVnVGPyrhX6
SjZK+UV2Yf8EY6ThbvlamMFMv1vBHi3qfDLCczTAWxmSmhLvF5Gbi6ccRQNZfsZ5
QJaSM4VKrqWDMXTu3a725/lc2KMZfW3IBNp6laXjGbZrXQ+YGvavMjyZUobWmm5Y
XxMCfTGaWaI3w1SvshdvV4khCNL0SfY7/hredYG25mCXtOM3UrJuzuuT0It3r2Z+
zdgVmOSbckhJ2brL77KoU1jcaGdj41w78UZ97Gx54scjWa5wtOguJbjYz/1V1p6q
NwfxOBM2QATWW6JGJDLlN+yrWslyf/582d1RBI/vpp68aquRfY3p5aWXg3mZQ0V6
urhE2CZYSdITmOjxvX0orKh0OR+qJPWZCPu2nv8tIiPwln/H7shV5ZdT7icYhU6z
jKdOUFsvKsrQ4hMGyyJqqgy+ssQ4YdiI3YY54Lo4cg==
=G25w
-----END PGP SIGNATURE-----

--+HVON39KQB+h9JME--

