Date: Mon, 10 Dec 2018 19:22:18 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20181210182218.GC962@...1296...>
References: <1520262951-1807-1-git-send-email-arne@...1227...>
 <4c8dbc1b-71c9-6187-5ecf-f1dbfb957561@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kJe+Z/feWlbC5FTR"
Content-Disposition: inline
In-Reply-To: <4c8dbc1b-71c9-6187-5ecf-f1dbfb957561@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Rework OpenVPN auth-token support
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

--kJe+Z/feWlbC5FTR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 08, 2018 at 04:02:22PM +0100, Arne Schwabe wrote:
> The discussion has gone on a bit about this patch. I would like to step
> back and give an overview to make this mess better understandable as we
> have multiple problem mixed together.

Since this summary is from March, and we've so far only fixed one aspect,
but not these...

> Problem (1) and (2) are unproblematic as far as the discussion goes as
> there is no doubt that we should "just" implement them in 2.x.

"just implement"... :-) -> I have opened a trac ticket as a reminder,
https://community.openvpn.net/openvpn/ticket/1147#ticket

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--kJe+Z/feWlbC5FTR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcDq7ZAAoJEB2Cnv7KVigSY2wMAIlj1y7FzpM5z5xGKlLurXWb
oepUtlBWx7hIAsj5HSQ1dRF72hBHsM2GCzZVGP2hIEg09cxLnWofXLMpURF3QgoN
DW3hsTjM/CcecgztDFfJXRDY6OJdTRuHQbjX0KAbclxgqt13B9JCXdB4zS5iIINf
8AgipxvJk32AiZ79/W47XbogaL8L2Wm7ilVwaHGq8mk0rQ6vqjDaTlWZkAEIQ7MD
Jc/wLbPl2WlpXhzzXUgZGzMSSmZDCt+NYi9+IzLU6rLiYNvTBe2oHn5KWC/U8hrk
JeSFeb+ZaKpcoE0KBHJ3FLlDA1jSoMZ3s1Ust4kHKsHA9Hs0cfOPuoAfaFzFGYub
vR9BWklVgFZBVawVZVOyuFwwL/OCTCCCCcINsJDAmQfjB3Cmm4Kq17MubY/kKrtF
HgdQhzbNETM6YZ1KLrv2CEWH7qWx5l8VgdOPWojscDDXvFcr2gUhcpPw73ADh0Qo
SvUlA2JfU906JcU1+uvkl7nvf3JitNkhA1cxJNf1CQ==
=B5xf
-----END PGP SIGNATURE-----

--kJe+Z/feWlbC5FTR--

