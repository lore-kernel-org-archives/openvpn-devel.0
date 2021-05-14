Date: Fri, 14 May 2021 14:22:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210514122213.GR976@...1296...>
References: <20210512131511.1309914-1-arne@...1227...>
 <20210512131511.1309914-6-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ap9EtoBjvcvnAtTB"
Content-Disposition: inline
In-Reply-To: <20210512131511.1309914-6-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 5/9] Add ifdef guards to unit test
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

--ap9EtoBjvcvnAtTB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, May 12, 2021 at 03:15:07PM +0200, Arne Schwabe wrote:
> the unit tests do not compile under windows since they are missing
> the correct ifdef guards

While I totally agree with "WE MUST HAVE MORE #IFDEF!!" (in best
OpenVPN tradition), I do not think that this is the right place or
time.

> diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/open=
vpn/test_argv.c
> index 3dc470a52..6ab9be53c 100644
> --- a/tests/unit_tests/openvpn/test_argv.c
> +++ b/tests/unit_tests/openvpn/test_argv.c
> @@ -2,7 +2,9 @@
>  #include "syshead.h"
>=20=20
>  #include <stdio.h>
> +#ifdef HAVE_UNISTD_H
>  #include <unistd.h>
> +#endif

As far as I can see, all these test modules include "syshead.h", which
already has the unistd.h (with guard!).

So maybe a better version of this patch would be to remove <unistd.h>
and all other includes that are already pulled in by "syshead.h"?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ap9EtoBjvcvnAtTB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgnmt1AAoJEB2Cnv7KVigSfgML/iKPEc6qPLPb4Fp7jDNedBLf
+XapZzbImPlGOlQ3R1KjgAr5oBGmmV56vf5tRpcRhkGDjVSCzVx0w9DR91UKmL8s
Btm465Lfo/WFIEjb8Di7YfJ7QkINnVLfrwwT71NXVYUddMvmHC5HpL7/bwwGDyKe
IjKJdD3GFViAdWUpfP37nN1NfMmDTui0DHXHEr7sSHGNXw1aFIQZPU+SrxFV+uqn
9dzmRU3KthRYxckByZJLyP005+ft6F6t1fiiaEAIbvGSeZDyrnoAzAeH67gDadhU
tTLH3kDpPmVYsHIdCW6hkd2Jr4HF/JwZom2m0Z0WYxx9eE1eYuczLVXwqBG2MX6u
TUVzSJs3uuMW9SKDXjB8GTV/aeX1I8CSP50Yn159Pe/1+dBvZYfh2LItqDqDCVbA
izy5s96Y5A4VraJuQHLvCHAATDkNCO2wIc3PuywiiAQoNqSsysnV3uK1WgYUgLuG
N8Dr6DJh7ldhTmEz8Wd1AaP6CP0E+sX6cRhz24eafQ==
=EzoU
-----END PGP SIGNATURE-----

--ap9EtoBjvcvnAtTB--

