From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 27 Feb 2012 17:04:03 +0100
Message-ID: <6021266.D0OP5FaSJF@...1526...>
In-Reply-To: <CAOazyz1xxbxSzHRvS1+3my_86iOQh0Jsvk-G_0+kMLERr0UXog@...278...>
References: <CAOazyz2Rr6JgnmojZ3Naht6eybdq1KnooEAbARSS=3ZM-iLVJg@...278...>
	<4F4B402F.70507@...515...>
	<CAOazyz1xxbxSzHRvS1+3my_86iOQh0Jsvk-G_0+kMLERr0UXog@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] openvpn windows gui
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Hi Alon

On Monday 27 February 2012 14:01:25 Alon Bar-Lev wrote:
> I am going to re-write your build system :)

Take it easy! =3D)

> It uses autoconf but not automake and looks some rewrite is needed.

I did not see the the need for automake in the past. However, now that dist=
=20
produces a .tar.gz and there's the res/ subdir and the Makefile is quite ug=
ly,=20
plus not all the dependency tracking is in place working, a little automake=
=20
will be beneficial, so go ahead. Please make sure the snapshot target stays=
=20
intact and that configure still supports the --with-cyrpto-* arguments for=
=20
libcrypto (guess you'll go pkg-config here as well).

> We should probably write an installer.

I'm not sure if it's the best idea to make each and every GUI project out=20
there write it's own installer, when it's mostly a single executable that=20
needs to be replaced to package it with upstream openvpn. The pragmatic way=
 to=20
do it would be to leave the GUI stuff in openvpn itself, but I guess you gu=
ys=20
like the idea of bundling installers with other installers, right?

Heiko=20
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


