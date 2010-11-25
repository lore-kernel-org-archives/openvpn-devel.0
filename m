Message-ID: <4CEEC19D.1040903@...1114...>
Date: Thu, 25 Nov 2010 21:05:49 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4CEEC09A.9080804@...515...>
In-Reply-To: <4CEEC09A.9080804@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Fixed an issue causing a build failure
 with MS Visual Studio 2008
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 25/11/10 21:01, Samuli Sepp=E4nen wrote:
|
|> From 36baafa15e414ab37823160801eaa340171563aa Mon Sep 17 00:00:00 2001
| From: =3D?utf-8?q?Samuli=3D20Sepp=3DC3=3DA4nen?=3D<samuli@...515...>
| Date: Thu, 25 Nov 2010 21:48:34 +0200
| Subject: [PATCH] Fixed an issue causing a build failure with MS Visual
Studio 2008.
|
| The new SOCKS auth code in socks.c contained a call to sprintf instead of
| openvpn_sprintf. This caused build to fail if MS Visual Studio 2008 C com=
piler
| was used. This change fixes that issue.
|
| Signed-off-by: Samuli Sepp=E4nen<samuli@...515...>
| ---
|   socks.c |    2 +-
|   1 files changed, 1 insertions(+), 1 deletions(-)
|

Acked-by: David Sommerseth <dazo@...384...>

kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkzuwZ0ACgkQDC186MBRfro98wCgpJKW88UxgCR/LkosCIcfvPI7
nVgAn3mNJEf/se1FmK0+UqEU1DxdBQhy
=3DRlX7
-----END PGP SIGNATURE-----

