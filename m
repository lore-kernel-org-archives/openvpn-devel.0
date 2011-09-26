From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 26 Sep 2011 14:37:45 +0200
References: <4e6f25dc2a58c3.42657146@...1498...> <4E801FAE.5010700@...515...>
	<4E806C6A.9090907@...515...>
In-Reply-To: <4E806C6A.9090907@...515...>
MIME-Version: 1.0
Message-Id: <201109261437.45686.heiko.hund@...1489...>
Subject: Re: [Openvpn-devel]
 =?iso-8859-1?q?Snapshot=09openvpn-2=2Ex-20110909-?=
 =?iso-8859-1?q?master-install=2Eexe_fails?=
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Samuli =?iso-8859-1?q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Monday 26 September 2011 14:13:30 Samuli Sepp=E4nen wrote:
> Ok, did as suggested for socket.c and win32.h and got the following
> build failure using MSVC:
>=20
> <http://pastebin.com/xZ8J2yrq>

---8<------------------------------------------------------------------
c:\users\samuli\openvpn-build\openvpn\win32.h(282) :=20
error C2373: 'inet_ntop' : redefinition; different type modifiers
---8<------------------------------------------------------------------

This is hopefully just because MSVC still believes it's building for Vista =
or=20
later. Does the message disappear if you include syshead.h in win32.h? In=20
there WINVER is already defined to signal building for XP. If that doesn't=
=20
help, you should also check in <Ws2tcpip.h> if the declaration of inet_ntop=
 is=20
#ifdef'd taking WINVER into account.

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

