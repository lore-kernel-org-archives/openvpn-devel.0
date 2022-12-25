Date: Sun, 25 Dec 2022 10:51:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y6gdIyG0i7AIykIg@...1296...>
References: <20221224194253.3202231-1-arne@...1227...>
 <20221224194253.3202231-10-arne@...1227...>
 <Y6eHtDvs+r+A8BSs@...1296...>
 <257522ae-92d0-9b32-1e98-0941a348147b@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CKmWwO2oMDDnzqul"
Content-Disposition: inline
In-Reply-To: <257522ae-92d0-9b32-1e98-0941a348147b@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 9/9] Ignore
 OVPN_DEL_PEER_REASON_USERSPACE to avoid race conditions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--CKmWwO2oMDDnzqul
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 25, 2022 at 01:23:06AM +0100, Arne Schwabe wrote:
> >> +        if (mi->context.c2.tls_multi)
> >> +        {
> >> +            buf_printf(&out, " peer-id=3D%d", mi->context.c2.tls_mult=
i->peer_id);
> >> +        }
> Yeah. This accidentially slipped into the patch set. I am sorry for=20
> including it. It was however really helpful for doing the debugging.

Thinking more about it, I wonder if we can have it conditionalized on
"DCO active" and "verb >=3D6" (D_DCO_DEBUG).  This would make it useful
for, well, DCO debugging, but not get in the way otherwise.

Do we have enough information available at this place?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--CKmWwO2oMDDnzqul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjqB0jAAoJEB2Cnv7KVigSTBcL/iE4NhqOGKTUeGEG1HWYqMP3
1iPPF1f7Jxu6XXVbD/niPbI1W/isgrPlYxMCwug1znS4xSclm7QJzuJ1vNZY8H3m
L11QOgekRZkll6fWlk9rsM+8ltz56HU4aJfZL9eVgg2KIjw9TuHHd+UekI+1SN2V
QZuo6CjnNxX4JEQ6/ZbI3yeuVFV0qUz6hGtCApWSKXJorIrGbE7nfQlZ2eiDwkrY
ywiZRS8wAawzrRMugFIpwVl1+E3DpVAizt19tILWcHNAaJq2lU1foo1oKSO/s49I
VWM/5olkOB2+bFcPrM/EJH8mgOuZmGiFmykq5pUuQI7HLmZRBg2pCmhXc0kSez7K
wyxSSMptubOFGoWVkD3NL3eaDE8pel3wNTf4GYLmc5Q6fEQmPaP8Fza0ZQv+rN8x
dzsnQv/wb5oQv57SmJUHpUaN/qNJtO+m916vi4/b24PuaLkhzF+gD6zqZapj+ZPf
hBjV5YbN8SC/X7Y4FswilyxlTAnhuXWRMDYbxmi18g==
=aXPU
-----END PGP SIGNATURE-----

--CKmWwO2oMDDnzqul--

