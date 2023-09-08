Date: Fri, 8 Sep 2023 18:10:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZPtHfn913IPBdNwK@...1296...>
References: <20230903142947.20906-1-orbea@...2744...>
 <c0ecc754-7dda-313f-8cd2-047ebd1ae8cd@...2181...>
 <20230903091721.4a810beb@...2745...> <20230903095545.0f6d9d03@...2745...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FHi6aw3EItc02yxB"
Content-Disposition: inline
In-Reply-To: <20230903095545.0f6d9d03@...2745...>
Subject: Re: [Openvpn-devel] [PATCH] configure: disable engines if
 OPENSSL_NO_ENGINE is defined
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: orbea <orbea@...2744...>
Cc: openvpn-devel@lists.sourceforge.net

--FHi6aw3EItc02yxB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

so the v2 patch itself is good, but...

On Sun, Sep 03, 2023 at 09:55:45AM -0700, orbea wrote:
> From d6700ec0f5af2522bb4eb136d3760f5b1445c9d1 Mon Sep 17 00:00:00 2001
> From: orbea <orbea@...2744...>

... it would be really preferred to have a real author name here, and
a "Signed-off-by:" line (git commit -s), and...

> Date: Sat, 2 Sep 2023 23:06:22 -0700
> Subject: [PATCH] configure: disable engines if OPENSSL_NO_ENGINE is defin=
ed
>=20
> Starting with LibreSSL 3.8.1 the engines have been removed which causes
> the OpenVPN build to fail. This can be solved during configure by
> checking if OPENSSL_NO_ENGINE is defined in opensslconf.h.
> ---
[..]
> +	    /*	     BoringSSL and LibreSSL >=3D 3.8.1 removed engine support */
> +	    #ifdef OPENSSL_NO_ENGINE
> +	    #error Engine support disabled by default in openssl/opensslconf.h
>  	    #endif

... I think the "by default" needs to go from this #error - it's disabled,
period.  "disabled by default" is the OpenSSL 3.0 thing...

(The code change itself looks reasonable, and passes our GHA build
farm with various OSes and mbedTLS / OpenSSL 1.1 / OpenSSL 3.0)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--FHi6aw3EItc02yxB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJk+0d+AAoJEB2Cnv7KVigS7n0L+wWZ/WpPgmED7CIyk8j8cqZa
+dOiNk0daPw4GHhsqgqVDLzZCNLxAA2c2SBz4ah4LfuAznRtmqCx1JxH69PULYL+
qQPbvLg6o2vhqcMnq2xYmMqr2wgc6F+6/2Kvpor70uaDeMaC46AMvR8rPWZaMxG2
LGK0bHVGV+hMMDGHmX+vR4vb5KWlYvLG87g9q6sJisLSxNQeOoMqTD34Q93H2yBz
zfESjY4e0/kOj55RIcSXon88YDdglUF2L/qpyDvD03dKc53k61oDBSnw57rrKNEZ
uS353qL7pY/PTvhU1qW+JfnZiP17zFvXW+DyD9IIvGy0euByV0WLLLES3SWWHQiP
g9BEVOiJXI9VEA4FzoofNrCGJM9d+aOLYrX8cyJE47ofSTnE2kTXgk/QvQGYkWHg
WcTyjVsRdy5TLf9agMnXwO3nKmC7flf/7iinwjUQnR7wwlGtrznp/PyA01j8Mc++
ExbLYkqeH/ZiG5jMZzHPTmRd8w+Q73EedEeNJiB94Q==
=HyJ/
-----END PGP SIGNATURE-----

--FHi6aw3EItc02yxB--

