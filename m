Date: Wed, 18 Apr 2018 08:58:16 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180418065816.GY69387@...1296...>
References: <c113c9a5-198e-775b-c183-f319c35bdb28@...515...>
 <3ed13a6a-07fd-3f0c-100c-148099bc8971@...277...>
 <CAKuzo_haG86HMg8+Wet0=m6O9tzU_c92TQSBgJy7NncPv+3=GQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5RbnzrCS6nIk/pwS"
Content-Disposition: inline
In-Reply-To: <CAKuzo_haG86HMg8+Wet0=m6O9tzU_c92TQSBgJy7NncPv+3=GQ@...278...>
Subject: Re: [Openvpn-devel] New tap-windows6 driver (9.21.3) available for
 testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5RbnzrCS6nIk/pwS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 17, 2018 at 09:45:24PM -0400, Selva Nair wrote:
> (ii) The driver version shows up as 9.0.0.21 -- this is apparently taken
> from the inf file. Why is it not 9.21.3? The file version is 9.21.3 9/21 =
as
> expected.

I have no idea how the various values in version.m4 should work.  There
are many numbers...

What I have (after bumping all "21" to "22", and ".2/.3" to ".1") is:

define([PRODUCT_NAME], [TAP-Windows])
define([PRODUCT_PUBLISHER], [OpenVPN Technologies, Inc.])
define([PRODUCT_VERSION], [9.22.1])
define([PRODUCT_VERSION_RESOURCE], [9,0,0,22])
define([PRODUCT_TAP_WIN_COMPONENT_ID], [tap0901])
define([PRODUCT_TAP_WIN_MAJOR], [9])
define([PRODUCT_TAP_WIN_MINOR], [22])
define([PRODUCT_TAP_WIN_REVISION], [1])
define([PRODUCT_TAP_WIN_BUILD], [601])

So, no idea what PRODUCT_VERSION_RESOURCE does and why it is not "9,22,1,0"
(or the like).

It would certainly make things easier if that would output the same
number in all places.


> (iii) On Win7, the interface gets metric 20 --- implying a speed < 200 Mb=
ps
> as per the Windows automatic metric assignment table. Isn't this supposed
> to get detected as a 1Gbps adapter now? The link speed patch is in master
> and this one is one point ahead of it (9.21.3), so expected to see it her=
e.

The test driver is based on master before the link speed patch, with an
independent version bump.  Sorry for that confusion.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--5RbnzrCS6nIk/pwS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJa1uyHAAoJEB2Cnv7KVigSzr8L/jIqTU5PFpn6RLAc8jLWnlqh
nkXaIHAZPXzOtibDdvtdqTlz9kzD1xbfYFVMz7LLWGTjXKwyMmAWhHDiFav7gE7v
LiS8vtaHNC0IV2oj8k3Eyoo8xDPJ33MNOC98ZRkFbIbRhPOsPwTKXXTvj6pO9/Ts
7Q+Q+5SrWAS9cowS9O/CgWlvf54eFLtHH+MFIMKngiTuUWQAlOfMACpqRGLYxxqZ
jPhweVv40gQokdevPjxKtEiNL0RaMfjuWc3dhKToT/HOd03f8TJEF/HsrkqdyAP5
UNpqMv81pBhPIQpqY77TK5z5SvkW0W15X+qHvQbAIUSkhy9wLqQSwVHvB5wML1VJ
6X/NEMcROxdKXRQOD3aVV50am5ElfVZ4QH88yva8yGY5/4BnIYojip1y0/6S7iwk
NVOuAQpTCfFLeIYCU3RAUILZv6ES2r/VhIfDAEqb705pNWE4bvJgvH8aUa49WEoM
KKq/2kmo5Mjd4EkLAFmoQ0sScFVOklTHM+iq/FPyzQ==
=PfXK
-----END PGP SIGNATURE-----

--5RbnzrCS6nIk/pwS--

