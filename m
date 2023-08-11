Date: Fri, 11 Aug 2023 17:12:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZNZP1EQIjFmgTqX1@...1296...>
References: <20230728124005.177414-1-frank@...2641...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TLdz+JAecZGW9fj9"
Content-Disposition: inline
In-Reply-To: <20230728124005.177414-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] GHA: new workflow to submit scan to
 Coverity Scan service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--TLdz+JAecZGW9fj9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

generally good, but...

On Fri, Jul 28, 2023 at 02:40:05PM +0200, Frank Lichtenheld wrote:
> index 00000000..0620f638
> --- /dev/null
> +++ b/.github/workflows/coverity-scan.yml
> @@ -0,0 +1,45 @@
> +name: coverity-scan
> +on:
> +  schedule:
> +    - cron: '0 20 * * *' # Daily at 20:00 UTC
> +  workflow_dispatch:

... not sure this is the best way to approach the run limit, as
we can have many days with no commits at all, so we'd waste credits.

Maybe cache the last commit ID and only run coverity if this has
changed?  Or run it "on commit", but cache the current day, and only
run it again on the next commit that's not on the same day?

(My typical workflow is "you folks queue up patches, and then I find
half a day of free time, and go merge&push as many as I can make sense of")

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--TLdz+JAecZGW9fj9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJk1k/UAAoJEB2Cnv7KVigSq3oL/i2EdyBSWwsN0XlCPKNwYktL
Kg7HmhiVLn7OoHKqDVSrDgeHS+qigqPY3ki7GZaqGriHyKi1bu6Xl2eHMFu/c7sM
BL+tMfQzeLU8XtdPqiDQwpxLLumDnoPjIfKrud5I+xKJla6NiWXMFBZIkxGzTGwS
qBpoN8kz0PhtHebgVqDEyTR3WbvRXkDevbU0Ps0HnnbVb0w8Qc7zUHcqFQ4igvpJ
x1ZcONjH39yYoAXD1dmjW4gZQ2oyEHh8cumbSJMBP8p0AcSoP2OfCR/zIKirESIp
NzEdyb8LRZvAsqjq3FyFaKFS+ZSATCac/xAXZzLyznFdQn2BMmpLl8YmY8xjymTC
dNfMaiebkS9qwxXeEh1N+TbdbhyaTtaSjiRWNeVlYNYHSA22clJ8YiP03l2wgfy5
hWcWtlsS2k2hHvFid5obu1jG/3vrL6xmfUF1+6Pa2C/ilLiqXxbVlkJq8XaI5FxE
kS5TMmYV/Kc8HFY/CIfBPG1d3cL9b3TYz8gVo6fbsQ==
=dYvA
-----END PGP SIGNATURE-----

--TLdz+JAecZGW9fj9--

