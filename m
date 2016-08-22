References: <7a23f8c5-a8c8-219b-0b19-5100fcd0db3a@...515...>
	<aa7a724d-d7c1-b8e6-5ff7-3b624141ee39@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <cc588a8c-28e8-52d0-f27c-59bb077156a2@...2080...>
Date: Mon, 22 Aug 2016 18:40:33 +0200
MIME-Version: 1.0
In-Reply-To: <aa7a724d-d7c1-b8e6-5ff7-3b624141ee39@...515...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting on 15th August 2016
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/08/16 15:58, Samuli Sepp=E4nen wrote:
>=20
> Discussed the OpenVPN 2.3.12 release. It is lacking the not yet=20
> published "small block cipher warning" patch. There might also be a
> bug related to auth-user-pass, which dazo will investigate (and
> fix) before the release. Remaining 2.3.x tickets will be
> postponed.

I have dug into this, and the latest git release/2.3 commit works as
expected.  The issue I had locally from a very experimental local git
branch where I had overwritten /usr/sbin/openvpn a very long time ago
and had forgotten about it.  If any fixes are needed, it will be for
the git master and _not_ release/2.3.

- --=20
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAle7KwEACgkQDC186MBRfrpLpgCgqyRdjVL89V3C/usJx3FrikgM
UwcAoIwL07zYFxNvzx2/8DwHonrmv0rq
=3DeG6G
-----END PGP SIGNATURE-----

