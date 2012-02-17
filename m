From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 17 Feb 2012 10:39:15 +0100
Message-ID: <1784273.hoPHCvA0K1@...1526...>
In-Reply-To: <CAOazyz0W43Hop+8d4gzB9cAsA-CH55185rgd6evDR0uJ=tf7SQ@...278...>
References: <1329413441-22538-1-git-send-email-heiko.hund@...1489...>
	<1329413441-22538-3-git-send-email-heiko.hund@...1489...>
	<CAOazyz0W43Hop+8d4gzB9cAsA-CH55185rgd6evDR0uJ=tf7SQ@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 2/4] do not use mode_t on Windows
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Alon,

On Thursday 16 February 2012 18:34:34 Alon Bar-Lev wrote:
> Anyway, this is not the correct solution.
> Correct solution is to have config-msvc.h and have:
> ---
> #define mode_t int

I don't think that a MSVC specific header will do good. mode_t shouldn't=20
actually be used in mingw either, even if they define it. I stumbled over s=
uch=20
glue code a couple of times and the only reason I can come up with why they=
=20
have it is backwards compatibility with old code. So it's rather a general=
=20
WIN32 thing. And I absolutely agree that putting all the WIN32 stuff into=20
win32.[ch] would make the code prettier. I just don't feel enough itch to=20
approach this scratching myself.

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


