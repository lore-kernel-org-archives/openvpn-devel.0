Date: Thu, 26 Nov 2020 09:56:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20201126085648.GM976@...1296...>
References: <CAAUX2SWGzsjeCxjQ1C+zh8+qKXL3mUv5AJqEd6rM=A8f-Q1dBA@...278...>
 <a2152b6e-1429-6637-aef8-7eaf527316e3@...2181...>
 <CAAUX2SWEOk5TC1J9jBoiS6=chMbY_6DTMvPV1J07d3L26k9b0A@...278...>
 <228b401e-e700-447c-4c30-29d28cb22585@...2181...>
 <CAAUX2SX-90sKC-+MBQ9ycimK0YvHZC0rMjVKMKH_oFSDW=x5Tw@...278...>
 <8a1dc0cf-61d4-2ded-1c51-ccb755ba7ef9@...2181...>
 <CAAUX2SUqFRWcP+aTXUaW2+5zK6AGcAO51-rbcikexKXVPsc84g@...278...>
 <f34acee4-d928-509e-5bb3-9900c1578d5b@...2181...>
 <CAAUX2SXreiLnX5z0X9-oiKPJXT75=VjkdKsEb_taPHBGsP-39Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="AF0g1u6ji1KkUIJW"
Content-Disposition: inline
In-Reply-To: <CAAUX2SXreiLnX5z0X9-oiKPJXT75=VjkdKsEb_taPHBGsP-39Q@...278...>
Subject: Re: [Openvpn-devel] [ovpn-dco] Is cbc-hmac supported?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tony He <huangya90@...277...>
Cc: Antonio Quartulli <a@...2181...>, lev@...515..., openvpn-devel@lists.sourceforge.net

--AF0g1u6ji1KkUIJW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Nov 26, 2020 at 04:53:14PM +0800, Tony He wrote:
> Understood.  We have dicussed this in the OpenWRT forum. Maybe some kind
> OpenWRT guys will implement  aead hmac-sha256-cbc-aes
> for ovpn-dco module in the future.

Why?  If you do AES in the first place, all numbers I have seen so far
say "AES-GCM modes are faster / use less CPU =3D battery".  And, less
overhead on the wire.

And on non-intel devices, CHACHA-POLY, because there is ARM acceleration.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--AF0g1u6ji1KkUIJW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfv23PAAoJEB2Cnv7KVigSFskL+gMAWdq3+u9sylVL6V1QuPDP
8CyLczNkdZKq8MQbJbXRm+5wpr0jcXMV/kNp8ntTF8UStet8q5eAT7UQL9VQkxQ0
Ra5cy3mJRIijxqHUu/AB36nTQ4pzqwCJt8AlHqfGZfXxQw+pfsNXIYxTpzexPNuB
5ZM4jvZjtD+YOUjSpFdcuLZT89XEjWgpnAC45YgWXr4DdZKzwhHHcgx5XozWP8aS
KL2mLUPpwIuzknW8JNbCnG54y+H7X9qcUiAN3cStX+Vo+DD0p+9x2u0kSZwjtkPf
SE2YNOY5iIrStdgX7h7yewb+xig4ziYvfQlcL1sxQbboxHwh9qyWy97DGa9bGj6T
PkeeRtP0KbuJ1HDwsTzk8F8E4Q/UNQ4pg3bOykTjOVMLKjLH1p/Kq2tzRGrYzy1o
ikYFT4Tv9wu7FPvQpnQiy50AuwiGlWwdbuNumJgq9FgfQaZDSTr4CZOA6ken44ie
N/nCsU5L4BWvTzB2XsTJM3LdXO93q8pBJfDfRJGAVA==
=9Lxr
-----END PGP SIGNATURE-----

--AF0g1u6ji1KkUIJW--

