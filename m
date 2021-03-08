Date: Mon, 8 Mar 2021 12:19:14 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210308111914.GX976@...1296...>
References: <20210305141352.21847-1-arne@...1227...>
 <202103081053.128Ar9Y6018297@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bjP4uHnwaEE1v9tM"
Content-Disposition: inline
In-Reply-To: <202103081053.128Ar9Y6018297@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Prefer TLS libraries TLS
 PRF function, fix OpenVPN in FIPS mode
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

--bjP4uHnwaEE1v9tM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 08, 2021 at 11:53:09AM +0100, Gert Doering wrote:
> After some discussion on IRC today, it turns out that I was holding
> my test rig wrong.  As in: breakage occurs in the combination of
> "mbed TLS 2.25.0, TLS, TCP and --dev tap", but it does not actually=20
> matter whether this patch is applied or not - 2.5.1 breaks as well.=20=20

Arne found the trigger.

It is neither related to TCP nor to "--dev tap", but it needs a server
side with "OpenSSL 1.1.1" *and* a client side with "mbedTLS 2.25" to
trigger this - both ends need to negotiate curve25591, and then mbedTLS
will crash in the debug print function.

  https://github.com/ARMmbed/mbedtls/issues/4208

My current test rigs do not test this combination, except for this
particular test case (tcp+tap towards --inetd server), so we were chasing
red herrings for a while...

I need to think long and hard now how to add meaningful tests with
the new test matrix=20

   openssl 1.0.2u <-> openssl 1.1.1
   mbedTLS "oldish" <-> mbedTLS "very new

to the test sets, without making the already-long server side test=20
(40 minutes) go totally out of bounds...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--bjP4uHnwaEE1v9tM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgRggxAAoJEB2Cnv7KVigSbj0L/2L+R+rU1lPnoWIFZz+nWNMF
VY4ZE9DW56J9LgXKBX9qf0mz7YnMLXHx1B0HeD6he5bfCCqWaSyaLkq/71ZkjVU7
lhwsL8XYWfge1irhIFKm+STfjLiDBxdXqXO2w6rDEnkR5ATRC3JYZD1PQP5Dc41e
p/vdHWPvga6Ua7KpxbIMRD/sm9tkGoDuHbzzEkyI76Pzyvlz7WUBju58H3G7kWBG
YD2h3Io6T5y5yIRKpPVJ05fG+0heEW+WMtF8Mcsa+0nmoZFX8uQFraHVcI2D0ER6
XMr0f4P62ouLht0/uVUu0Qj7b/6GpBGc0fWt6G6qg5qh/LeeBjpwv6hHQVpPs8T2
XxlO7h5xsX+WiByTKHdZYuw8cs353VoMt1PWLjSbqCzeoY2332hvRZYuOWpbNhj+
iVkiY9UqspXxsMiO/LzBiqAJUp9nWVrAyk33u4L1PaktZcKgpS11WfSCnv+ZS9Gq
gccvElAS7MT+7hgKh6hZjv5deRZ9oZAacLsBZlAU+A==
=zda3
-----END PGP SIGNATURE-----

--bjP4uHnwaEE1v9tM--

