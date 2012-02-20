From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 20 Feb 2012 15:22:27 +0100
Message-ID: <1949591.2ys3ZyyMoG@...1526...>
In-Reply-To: <CAOazyz3-M4_tqhW0wdBjMsCM5HDBYNGVj4h-1BHTurAqfocvsA@...278...>
References: <1329594252-5257-1-git-send-email-heiko.hund@...1489...>
	<4F421C32.1040403@...1114...>
	<CAOazyz3-M4_tqhW0wdBjMsCM5HDBYNGVj4h-1BHTurAqfocvsA@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] define access mode flag X_OK as 0 on
	Windows
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

On Monday 20 February 2012 13:44:54 Alon Bar-Lev wrote:
> This X_OK is standard define.

That's true for unixoid systems, but none of the [FWRX]_OK #defines exist i=
n=20
the MS C runtime headers.

> It exists in mingw as 1.

Yeah, but only for legacy glue code reasons. From io.h:

----8<-------------
/*  Old versions of MSVCRT access() just ignored X_OK, while the version
    shipped with Vista, returns an error code.  This will restore the
    old behaviour  */
static inline int __mingw_access (const char *__fname, int __mode) {
  return  _access (__fname, __mode & ~X_OK);
}

#define access(__f,__m)  __mingw_access (__f, __m)
----8<-------------

> OpenVPN should not check execute if unsupported by OS, not changing
> standard constants.
> Where exactly is the problem?

Defining them makes code more readable, but without X_OK being 0 on Windows=
=20
openvpn crashes. See my commit message again and read the MSDN page about=20
_access at http://msdn.microsoft.com/en-us/library/1w06ktdy%28v=3Dvs.100%29=
.aspx
Hence the change for the MSVC buildsystem only. Mingw handles the situation=
=20
internally already.

Hope that made it clear.

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


