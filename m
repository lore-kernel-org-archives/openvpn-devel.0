References: <b7d9be2a-b8e1-e565-198f-a5177e11d0c2@...1435...>
	<CAA1AbxK+mE0mz01UwrJ=o_6HBkBBe+FUXNnmqsfMe7vQLzCTsQ@...278...>
From: ValdikSS <iam@...2070...>
Message-ID: <f14b332f-3512-95ac-f521-ebd6a2a7d439@...2070...>
Date: Sun, 6 Nov 2016 11:42:01 +0300
MIME-Version: 1.0
In-Reply-To: <CAA1AbxK+mE0mz01UwrJ=o_6HBkBBe+FUXNnmqsfMe7vQLzCTsQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hWC1eMPBSLDNoH33MfpJ6qk2O6jtqR9nR"
Subject: Re: [Openvpn-devel] Feature proposal: tls-crypt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hWC1eMPBSLDNoH33MfpJ6qk2O6jtqR9nR
Content-Type: multipart/mixed; boundary="5tc1cSrGlOSrOl9o21UWPxsj3pQ8A2crR";
	protected-headers="v1"
From: ValdikSS <iam@...2070...>
To: Steffan Karger <steffan@...1856...>,
	Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <f14b332f-3512-95ac-f521-ebd6a2a7d439@...2070...>
Subject: Re: Feature proposal: tls-crypt
References: <b7d9be2a-b8e1-e565-198f-a5177e11d0c2@...1435...>
	<CAA1AbxK+mE0mz01UwrJ=o_6HBkBBe+FUXNnmqsfMe7vQLzCTsQ@...278...>
In-Reply-To: <CAA1AbxK+mE0mz01UwrJ=o_6HBkBBe+FUXNnmqsfMe7vQLzCTsQ@...278...>

--5tc1cSrGlOSrOl9o21UWPxsj3pQ8A2crR
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Experimental branch doesn't work in TCP mode. Client gets the following err=
or right after sending P_CONTROL_HARD_RESET_CLIENT_V2:

Assertion failed at socket.c:2992 (buf_write_prepend (buf, &len, sizeof (le=
n)))


On 09/18/2016 03:25 PM, Steffan Karger wrote:
> Hi,
>
> On 27 July 2016 at 16:42, Steffan Karger <steffan.karger@...1435...> wrot=
e:
> I just pushed an experimental branch with --tls-crypt support:
> https://github.com/syzzer/openvpn/tree/tls-crypt-preview
>
> Any comments and test results or very much welcome.
>
> This code has not yet been reviewed, or tested by anyone else but me,
> so do not use in production yet.
>
> -Steffan
>
> -------------------------------------------------------------------------=
-----



--5tc1cSrGlOSrOl9o21UWPxsj3pQ8A2crR--

--hWC1eMPBSLDNoH33MfpJ6qk2O6jtqR9nR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss, https://keybase.io/verify

iQIxBAEBCAAbBQJYHuzZFBxpYW1AdmFsZGlrc3Mub3JnLnJ1AAoJEFzXIC7viPdy
FtwQAKyzvvSB9bcBAtdfDG6f7kL/UXMh/YpKMcjU2Y+IPyfrZ2H5v8T13nnsJyoU
tmFYl4IE9r9F4ywmt+J2aDypcMNNlB24VaVWWJ6xuvc2NbmuuwxJ7bci3XNH/GxB
jjtWpmdxOf0IDePqAoHD+viNtzUqaZ19u9wvMZQLRJN525JJYS/ARZH1dpqiYbMY
NMlxCn7aSNjvWv414H7ixJzHxav/9GKKZs9pngZZ+Qr96KOwHXZGWMnKZ7tb6+3w
oXlu/3l55aIWLyyfFjAJ1aOrDhWyoBJnn14wipmQEXjZsMTmAiDt2iWewxPQJHVx
KznxPiWcv/iKtTs+wyo9nZyL/xsnpu7wT+EQtFwq2T+NbJntPQoGnIEDa5MqiM8Y
kD+fTcD/jAYDdUs1IlVE2jiN+LEONk50fin/EAelaQMHSSnB4OSp+KtvVwuO435o
sPk2BljmBhESXXo5TJHtVpXdFopBndVHFdUeW35TKdoSxmGMpy3KcJRW1VQZaAnn
mCLDyGDghRRQWe8PlHHbZLLS4a4LOSCl/qzLuA3GIFpyX2GgqGcg1QaMPMFyO7u4
yTPOIa97JVTf8Z+HnC5e7R5OzRXOtWcuG1BwLtzpC/1sqH0czxELgzR4roU4wt6Z
GAE7iQvNfDG6B1LE0Yo7JAqVe1SltAbCLqIKCQ/oHDQUoFXO
=pXwr
-----END PGP SIGNATURE-----

--hWC1eMPBSLDNoH33MfpJ6qk2O6jtqR9nR--

