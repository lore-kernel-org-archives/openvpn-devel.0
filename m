References: <1482079255-15159-1-git-send-email-steffan@...1856...>
	<aaf4595a-1a8c-67f0-690c-9f6743066b0d@...2080...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <6469df40-4b8c-3665-c944-fb873bb2d525@...1856...>
Date: Sun, 22 Jan 2017 11:51:41 +0100
MIME-Version: 1.0
In-Reply-To: <aaf4595a-1a8c-67f0-690c-9f6743066b0d@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Mh3EaDhVOQiVR8xXf7FkJhUgbIVvCFqg1"
Subject: Re: [Openvpn-devel] [PATCH] Use SHA256 for the internal digest,
 instead of MD5
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mh3EaDhVOQiVR8xXf7FkJhUgbIVvCFqg1
Content-Type: multipart/mixed; boundary="JeSp0danhLjO1sPiNtmEDoAP1UPfpwod8";
	protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <6469df40-4b8c-3665-c944-fb873bb2d525@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Use SHA256 for the internal digest,
	instead of MD5
References: <1482079255-15159-1-git-send-email-steffan@...1856...>
	<aaf4595a-1a8c-67f0-690c-9f6743066b0d@...2080...>
In-Reply-To: <aaf4595a-1a8c-67f0-690c-9f6743066b0d@...2080...>

--JeSp0danhLjO1sPiNtmEDoAP1UPfpwod8
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 20-01-17 23:01, David Sommerseth wrote:
> This actually tries to revert commit ec4dff3bbdcc9fedf7844 ... which is
> quite surprising.
>=20
> [...snip...]
>=20
> And this too is also a revert of the same commit as above.
>=20
> Had it been just a simple rebase, I'd be willing to tackle that
> on-the-fly.  But as it tries to do some really unexpected reverts, there
> might be a few other issues I'm not able to spot instantly.

Ouch, that's one ugly rebase error.  I'll double-check the patch, and
resend a properly rebased one.

-Steffan


--JeSp0danhLjO1sPiNtmEDoAP1UPfpwod8--

--Mh3EaDhVOQiVR8xXf7FkJhUgbIVvCFqg1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYhI7DAAoJEJgCyj0AftKIm0kIALSE8gD1MpZMWadByMvP5Do8
LS0x11wd4Ydzdc51nU+YhC9TNtes07WP4UW2K0uTD/V4n8YycxH3cx52zwwvzLt2
50xN1sPT3c6R9RvBCzLPoE4CoT8KSc7PVKb2XRCMUTef08VqdJpdh6fW+8lPdIj/
d1fN0/ZhTcBa9h/roj0cA+WwEImAdWxj+If8+Iips9vFN9Lh5N/ZXeowuA1C6SP/
DKxzsf8+u2f8V26iO14A3WVpsW4aRZJ6UvrGHRhe1zqqJ+leXa9/bwbm1VDX4T6/
RESaFgXtzdhHtcbbr8HZCHKoFqq2QmO5obZQP+s9OkAzYhOHJVnyQW9sHVh7HtM=
=C4pF
-----END PGP SIGNATURE-----

--Mh3EaDhVOQiVR8xXf7FkJhUgbIVvCFqg1--

