Date: Sun, 3 Nov 2019 19:24:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191103182443.GC40538@...1296...>
References: <20191103053148.18059-1-tom.ty89@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="JVTRtevMO87SusWP"
Content-Disposition: inline
In-Reply-To: <20191103053148.18059-1-tom.ty89@...277...>
Subject: Re: [Openvpn-devel] [PATCH] tun/iproute2: support 31-bit ipv4
 prefix (RFC 3021)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tom Yan <tom.ty89@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--JVTRtevMO87SusWP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 03, 2019 at 01:31:48PM +0800, Tom Yan wrote:
>  src/openvpn/tun.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

I tend to NAK this, on a number of reasons - we support arbitrary
point-to-point links "since ever" if you do "topology p2p" (can be
out of the same /31, or just arbitrary addresses on both ends), so
I do not see why doing this in "topology subnet" would be beneficial.

OTOH, *if* you do it, it needs to be consistently, not just "linux/iproute"
(on linux, "sitnl" is the new gold standard), and the commit message should
explain a bit more about the "why do it this way" and "how do other=20
platforms deal with it" (windows, *BSD, MacOS, etc.)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--JVTRtevMO87SusWP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdvxtrAAoJEB2Cnv7KVigSI9AL/R+iXdnXBXT4l+quVtQPGcHB
1B8rYoeKoOXCwvk79XWLsv9r0sZPH2o7z5bdKfaFHTN1EAT0X/DpF/aOQedDF4f5
S6EDQC4Z3xEbKrhGpOkAa6JSBPWbK1QYXykp6+oKuxyT4L0EUH/W92m+XazqQQsV
8F5V5kgbMhQ2olMXQhs8Z1BHohKwN046uGKZiVSvdH7byC4LlmsGQYVW8Vi/d2uX
Brl6J0E6HTJdpfm5iqbH1kULmPYNptqVsqeFS5uHHGF7YCdFaLZ2okPPFJNR5FYC
EoYNSug5Mc4Y300tRyeTCVzOU6SyKBrBRm4KrgLBns+keiS9XhO0Kv5a2+ejFPzG
k8lcZke7GN7vHJEBmchd2NxmUW6RuTI9Wb6E04XPu34Pjf6MxSuVG6+8Fbm816nu
8utqMWyfQAnN61e2bPs5KXkQNc6yPWqDrBEKwg1HnO/pbe2hvu/7rrrPwCn/FZpm
FRI0s4SaBLA6cZNUQnWyTSj3oL1i0at7d6tji7gIqg==
=gb0E
-----END PGP SIGNATURE-----

--JVTRtevMO87SusWP--

