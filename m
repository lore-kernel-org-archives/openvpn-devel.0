From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 8 Dec 2011 12:06:37 +0100
Message-ID: <7880280.vOpaqr0gUp@...1526...>
In-Reply-To: <1323280731-26083-1-git-send-email-heiko.hund@...1489...>
References: <1323280731-26083-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] handle Windows unicode paths
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On Wednesday 07 December 2011 17:58:51 Heiko Hund wrote:
> This patch makes openvpn read the command line in UCS-2 and convert
> it to UTF-8 internally. Windows stores names in the filesystem in UCS-2.
> When using a paths openvpn converts it from UTF-8 to UCS-2 and uses the
> wide character Windows API function.

One thing I left out on purpose for now was handling --capath with a Unicod=
e=20
path. To have that work, openvpn would need to define a custom  LOOKUP_METH=
OD=20
that is Unicode-safe. The one that is currently used is at [1]. The problem=
=20
here is the _stat call that needs to be _wstat. Please let me know if that'=
s=20
something that should be done or not and I'll provide a patch.

Heiko

[1] http://cvs.openssl.org/fileview?f=3Dopenssl/crypto/x509/by_dir.c&v=3D1.=
32
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro a Sophos Company | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germ=
any
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
Amalienbadstra=DFe 41 Bau 52 | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen


