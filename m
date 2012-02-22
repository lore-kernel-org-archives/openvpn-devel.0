From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 22 Feb 2012 11:27:26 +0100
Message-ID: <8821332.jJMvSfGUe1@...1526...>
In-Reply-To: <CAOazyz3CAK6Huf7qzAv_Uv+bn5QFFd_cC7A8S_s42HZQGNLC4g@...278...>
References: <CAOazyz3CAK6Huf7qzAv_Uv+bn5QFFd_cC7A8S_s42HZQGNLC4g@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [build] Windows build test
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

On Wednesday 22 February 2012 00:12:25 Alon Bar-Lev wrote:
> BEST METHOD - Compile on Linux
>=20
> This is a generic method, it can cross compile OpenVPN using any
> toolchain to any environment.
> For Windows, make sure you have mingw-w64 toolchain.
> We are using nsis so we can also package files at Linux.
>=20
> $ cd generic
> $ IMAGEROOT=3D`pwd`/image-win32 CHOST=3Di686-w64-mingw32
> CBUILD=3Dx86_64-pc-linux-gnu ./build
> $ IMAGEROOT=3D`pwd`/image-win64 CHOST=3Dx86_64-w64-mingw32
> CBUILD=3Dx86_64-pc-linux-gnu ./build

I was cross compiling for Windows previously doing something very standard=
=20
like `./configure --host=3Di686-w64-mingw32 ...` followed by `make`. What t=
he=20
rationale behind moving away from this way?

Heiko
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


