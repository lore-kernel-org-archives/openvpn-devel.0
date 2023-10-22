Date: Sun, 22 Oct 2023 14:43:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZTUY4bJ1Vu6wJoVK@...1296...>
References: <20231022105756.21080-1-gert@...1296...>
 <202310221103.39MB3HXE060510@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="MyWCib37g1kRCDph"
Content-Disposition: inline
In-Reply-To: <202310221103.39MB3HXE060510@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add undefined and abort on
 error to clang sanitize builds
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

--MyWCib37g1kRCDph
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Oct 22, 2023 at 01:03:17PM +0200, Gert Doering wrote:
> Your patch has been applied to the master branch.
>=20
> commit 44d5cd038cb5b62dafc4aa784cfa2ccb7d670df7 (master)

... and github actions is a bit unappy about the result... seems we
are missing a cleanup patch...

2023-10-22 11:44:03 UDPv6 link remote: [AF_INET6]::1:16000
    #0 0x10a27354b in get_default_gateway route.c:3675
    #1 0x10a2d5503 in warn_on_use_of_common_subnets tun.c:656
    #2 0x10a19ed6e in do_option_warnings init.c:3640
    #3 0x10a19ca44 in init_instance init.c:4514
    #4 0x10a19c605 in init_instance_handle_signals init.c:4411
    #5 0x10a1fd1ab in tunnel_point_to_point openvpn.c:65
    #6 0x10a1fcd57 in openvpn_main openvpn.c:312
    #7 0x10a1fc888 in main openvpn.c:393
    #8 0x7fff20477f3c in start+0x0 (libdyld.dylib:x86_64+0x15f3c)

... and I know which one that is - blame is on me, will take care of it.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--MyWCib37g1kRCDph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJlNRjhAAoJEB2Cnv7KVigSPMML/1SWWEsvDBeP5b8St+pqqJMz
kkmQ8OErtRMGhz4tEqu6wM8kpzFI33eGs8IrcF+KqP9WDERWlh+BLExaVVMxldzf
O8Ox6bbPIQIZhBV36IoIAQS48/VSZmQWVcdDr0hUCW8+ESEScCMScrAu0ZkInjfO
qsqFBWgxJU38fYNi2ox2FRA5WhZVNMiCDFRUq+4dG9CZcFh4Zt1jfN/XeB9vwBiy
1qkoEN+Cd802DGR7eu0rODzqr18ZpSCW9ci+PW3263UfW4X9Xr6juOqcAIzsOrzj
zXtT730WMBmFnQWPGfqiqsxwWV61aJDyk7tr7n9KIeFCvsU8Y/5jik2Pj/oh+Sna
g7Fi13YsglHIdXFWl0waFxW2hsI8A4slpfdkIjhnx9M0I5Ee8EBLSQdKLIwdg3Sr
s7tnoXC5Hj/Rh6kkBh5b8BJgwac2BmHePFsoAEBuMdlY6nKmhIRcIKSPNr2MhjmW
RTCkscIQqsKcSC+IlY4jGdoLtsNsr7lj/S3/SwtpDg==
=Uzxd
-----END PGP SIGNATURE-----

--MyWCib37g1kRCDph--

