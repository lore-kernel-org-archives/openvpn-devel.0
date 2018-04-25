Date: Wed, 25 Apr 2018 08:33:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180425063323.GR69387@...1296...>
References: <CAKuzo_jtPA4=NMeER1YwjRwGkq3NG39aqxHN3NCPGY+3KkAHpg@...278...>
 <20180414072617.25075-1-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ElxHlaEMx4miJhVV"
Content-Disposition: inline
In-Reply-To: <20180414072617.25075-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix potential double-free() in
 Interactive Service (CVE-2018-9336)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--ElxHlaEMx4miJhVV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Apr 14, 2018 at 09:26:17AM +0200, Gert Doering wrote:
> Malformed input data on the service pipe towards the OpenVPN interactive
> service (normally used by the OpenVPN GUI to request openvpn instances
> from the service) can result in a double free() in the error handling cod=
e.
[..]

Due to the sensitive nature of the patch, it was held under embargo rules
- that is "only sent to the security@ list, privately ACKed, commits not
announced to the public list right away".

I do have an ACK for this from Selva, and have my usually "it went it
with commit ID..." mail, but for whatever reason I cannot re-send my own
mail to the -devel list, and I think SPF is stopping me from bouncing
Selva's mail...  which is a bit of an annoyance.

So I just forward the e-mails below, PGP sign all this (and the commits
are PGP-signed as well), and leave verification of "is the commit the
same as in the repo?  is it what Selva ACKed?" to the interested reader.


-------------------------------------------------
From: Selva Nair <selva.nair@...277...>
Date: Sat, 14 Apr 2018 12:44:57 -0400
Message-ID: <CAKuzo_h-GusttjiFUeV2tivFAKHFdqTnDseg9KiVru5ftWszyg@...278...>
Subject: Re: [PATCH v2] Fix potential double-free() in Interactive Service =
(CVE-2018-9336)
To: Gert Doering <gert@...1296...>
Cc: security@...515..., jbaines@...2391...

On Sat, Apr 14, 2018 at 3:26 AM, Gert Doering <gert@...1296...> wrote:

> Malformed input data on the service pipe towards the OpenVPN interactive
> service (normally used by the OpenVPN GUI to request openvpn instances
> from the service) can result in a double free() in the error handling cod=
e.
>
> This usually only leads to a process crash (DoS by an unprivileged local
> account) but since it could possibly lead to memory corruption if
> happening while multiple other threads are active at the same time,
> CVE-2018-9336 has been assigned to acknowledge this risk.
>
> Fix by ensuring that sud->directory is set to NULL in GetStartUpData()
> for all error cases (thus not being free()ed in FreeStartupData()).
>
> Rewrite control flow to use explicit error label for error exit.
>
> Discovered and reported by Jacob Baines <jbaines@...2391...>.
>
> CVE: 2018-9336
>
> Signed-off-by: Gert Doering <gert@...1296...>
>
> --
> v2: reword commit message, no code changes


Just for completeness: all good so ACK again.

Selva

-------------------------------------------------
Date: Thu, 19 Apr 2018 17:24:49 +0200 (CEST)
Message-Id: <201804191524.w3JFOnGd007014@...2054...>
From: Gert Doering <gert@...1296...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Subject: [PATCH applied] Re: Fix potential double-free() in Interactive Ser=
vice (CVE-2018-9336)

Your patch has been applied to the master and release/2.4 branch.

commit 1394192b210cb3c6624a7419bcf3ff966742e79b (master)
commit da242af8d3750a231bfd687d0a92cf2004dae988 (release/2.4)
Author: Gert Doering
Date:   Sat Apr 14 09:26:17 2018 +0200

     Fix potential double-free() in Interactive Service (CVE-2018-9336)

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20180414072617.25075-1-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=3Dmid&q=3D20180414072617.25=
075-1-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ElxHlaEMx4miJhVV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJa4CEzAAoJEB2Cnv7KVigS6dkMAKjPpmG6Iowkq7K9nixyH2VL
EGzL9TsfjmVx8rX4rkymTnudhbM5XU4IX3+3YZf2Fvm4bI8H3ZNzFs/7ZXjnsTJc
U5vqnrlzhsccGv50QjCTw6ONazmAKvozIWCyK+GEtBzAtysVhLmOQUTjQ6AwkiKJ
0EQTf+R3A7nUIux83+eGhHCU92M1Ak1QIWKqGQM0OGHjpjWioQiJcTIADaOR5c3B
nf0igl7YDTCTJDrcRmXbP9u/gQLmyRnCpF7uNGw9erFbcG0Ds1ivYMuPAjmFOaZs
eY2IHDUFoFr8jYCSy1mcG28rEEEV8u3X3vSv2uoDRZF+axsxjZ3agyUFxJ47xnN7
YfGcQ9gH7XEZTHmZjz1iFuzvx78E+RiTjG06kEA1+cckYeFJ8vLvkSwPRBywcJK1
fT9/nkwqT7NlQ34a7EX+m9FSfwP/alN4/2aBEPgoTEQlYpRIxZOYDvTkvyiZunkO
iTB3U3mpR7al+QNOe9LarhL9Wb3ncqL3kVzl+4Fzig==
=H2WI
-----END PGP SIGNATURE-----

--ElxHlaEMx4miJhVV--

