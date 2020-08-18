Date: Tue, 18 Aug 2020 21:45:15 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200818194515.GD75094@...1296...>
References: <CAAWBBYPw=TZg1wftWZL5ABKVWkp7=6hpdaumLN2D24Cgr-E4pQ@...278...>
 <20200818062335.GV75094@...1296...>
 <20200818063212.GW75094@...1296...>
 <CAKuzo_jEGvTnkbsgJVm5beW5SapWoy_xLk_LA+-N59oa6SbbkA@...278...>
 <81A6F618-2F74-417F-A476-BF290CCFF143@...277...>
 <20200818181820.GZ75094@...1296...>
 <2F7C4631-7E3C-47FB-BC8E-E4271F38AD9F@...277...>
 <20200818192104.GB75094@...1296...>
 <CAKuzo_h2hLeQodHsJ7uzetq_XeGPJiu3i-o2tXuL29HbJcG6bA@...278...>
 <20200818194248.GC75094@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xEruU51OOzV9VdJQ"
Content-Disposition: inline
In-Reply-To: <20200818194248.GC75094@...1296...>
Subject: Re: [Openvpn-devel] 2.5-beta-1 Wintun requires SYSTEM privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xEruU51OOzV9VdJQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 18, 2020 at 09:42:48PM +0200, Gert Doering wrote:
> Indeed, you are right.  Somewhere on the track we lost the ability
> to do wintun "from OpenVPN" if we *have* SYSTEM.

commit 6d19775a468, I acked it, and I should have looked closer at
all the line that got removed...

Anyway.  That's what it is right now: only iservice.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--xEruU51OOzV9VdJQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfPC/KAAoJEB2Cnv7KVigSG50L/3AZErmpKJK+FbFsSwCoBidv
FgGBmqyoHM+dqYmTxZuT27jjzEWjKc+l2kj9bC3XXrhtCUW8VfAAZGqv2z1kWnJs
d3tMzYx0yLA54cEJC0dafdwvFHCoRSs/DU5j1YvdZBgS1BBwjLI+to5vP52ekvsH
VdnM0eU2+AUC7rwUdXX5xK7PpdT1/hSqs5aSMUVGc8qsusdtQVoMNuKMOJtxoXXW
r3Pmtzz7Zkc/+X5PJCYCu4HDWRRfY4TmAqTcO/c1vknwoq2aCDqZBp6NV3avyy4x
R3GvQZqTvaAznsTCpj+Oj0a33CmOCxhvd5pkkw6d+IaQghi/OHsTzWa4j9YwkkRg
YEd8TBBt+UORm15bMIBibKY2IcIvoCEzQQhLNx9afI//aJo7F1oeJYpamtg0HPgr
PzLu2XV0hQARImsJi+4E8KGP3v+iyLQHPfSrEmhUqxlvn8xd5qiMaDd7j9usbbCE
lXir7uYXCGwwI3hjd1Zji4PGkLQEa/3zF7RJUH7L4g==
=rBe2
-----END PGP SIGNATURE-----

--xEruU51OOzV9VdJQ--

