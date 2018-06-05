Date: Tue, 5 Jun 2018 20:53:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180605185352.GR57262@...1296...>
References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...>
 <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
 <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EE8jvUPYYQjJtG7J"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EE8jvUPYYQjJtG7J
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 05, 2018 at 01:30:35PM -0400, Selva Nair wrote:
> How to work around that depends on what the tap driver expects in the
> v4 address. Ideally, we should patch the driver to work without a V4
> address...

Samuli's build/test rig seems to be close to finished, so now is the
time to break the tap driver for good ;-)

I'll look into that.  Had my fingers in that code quite a lot recently
anyway...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--EE8jvUPYYQjJtG7J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbFtw/AAoJEB2Cnv7KVigSWOkMAJCxLYp2SxX1BYAO6YffcO9/
S3gJpaAns1HCFw3BDaX/fLd3J3HVFmFi/UfgRUnlPDe/mSPLIyCWZUFmifguHJDF
uIKLuOytPpt/IApHWWQruWSySgs9LrY5Xob6HAdwbX7P5fX2T61CumIn+oY2Vrvc
zajD5leDvB9TP0kMV6YEyVaZpV4LYaIXjwuJt8uPOkeWCL5hAlotFzhKcR62Yr49
S6GcCeaQZqD2EoFXGiH2GttZG6fdq0FE9jtXwLSD7lkDhm3KRd075z7c88qiKFlx
ZqDW5MY+1ykVnUQxdufs7UD0BHz3BnHQJEeX9AdnlMgMdVYz0oxCFRXtqjc60JtA
uQbehSJac+TKu+MlasNWoHQxUQGfc8OMXJegZACg3++hBKPRtKHFDUVgFpAQBjO8
vV8NpNOlFqd/WHwg3ouEgN3nk7OMY7rGIoufwDGJhzrJyRq7VKlwpzcpsCqLkRJo
W2dNoGuKJt97qrs7umCiDgvUQXZl2FjNCf5dMbuSIg==
=CWDI
-----END PGP SIGNATURE-----

--EE8jvUPYYQjJtG7J--

