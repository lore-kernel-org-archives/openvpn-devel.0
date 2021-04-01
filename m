Date: Thu, 1 Apr 2021 08:26:22 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210401062622.GG976@...1296...>
References: <E1lRfR7-0007jN-Go@...2479...>
 <34084543aaf50252f6b2749cb0206d9e.squirrel@...2260...>
 <218595a3-086a-ae93-d4dc-bb1866c86290@...1227...>
 <6842604fe080c80b5c6d75255f695223.squirrel@...2556...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="HaRZebM69g7mLrqy"
Content-Disposition: inline
In-Reply-To: <6842604fe080c80b5c6d75255f695223.squirrel@...2556...>
Subject: Re: [Openvpn-devel] [PATCH 0/1] reliable: retransmit if 3 follow-up
 ACKs are received
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--HaRZebM69g7mLrqy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 01, 2021 at 08:20:48AM +0200, Simon Matter wrote:
> > Yes. But it only affects the control channel. For data channel we never
> > do retransmits.
>=20
> OK, but it still could help in case of things like VoIP UDP over OpenVPN
> UDP with lots of small packets going over the link with low package loss?

No, because VoIP-over-OpenVPN would be "data channel".

It would help with "control channel handshake takes very long due to packet
loss".

There's a different patchset floating around (I think it's a PR, actually)
that promises to add data-channel redundancy and being able to recover some
amount of packet loss without retransmit.  Which I find very interesting,=20
but this has not been followed up due to "it's complex and nobody has time"
reasons.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--HaRZebM69g7mLrqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgZWeNAAoJEB2Cnv7KVigSihUL/R/il3kgSwW9KH0bqaXbWmDV
WKaC3zRtKIWHu8OGs83jtXEhmD7QFvCyF3iyucTeCojF440uzU/T901Q2Hiu+yuH
NFUTy8WuX+PnDUzv8OzVIVVOjIYfPYqfYJGGC3hc0AC5LK9rtUOEuqCTf74t8+Ms
xAEyIgMAFNMB+F16Ptuh7WplMSCtfi2l/tlVUcedetrXyQJOVSATN8nl36YU2GHZ
LDRgLfxpo5xWekMbExxlZK6SYIjDCS9jIZEtSEhNfRQXqYcxSP/sST4olDZBy/32
SsOZejNOyfl5dVtHcA38SF1iYUfqfyek7IoJiNq0fN0EKOr497vVON0Qh3rGhIMx
s1Nxqn8/+icX0WL4JjMDo8A6JN1yPfRXphpeFWHuF+MEiHHQONN3RArGjOQBWMKv
hvBr/beqEVjnBlCTeVI99ZJlWJCmSbvFPgKfTJqg9/9wEqjnj6HnHKUCCYRaDgn8
hVTGtV2z7KimKcSLtghY5R0LgrK6Ml+Xsmo3lvIfEQ==
=6VxY
-----END PGP SIGNATURE-----

--HaRZebM69g7mLrqy--

