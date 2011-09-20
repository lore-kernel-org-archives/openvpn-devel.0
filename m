From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 20 Sep 2011 13:17:59 +0200
References: <4e6f25dc2a58c3.42657146@...1498...> <4e7850551f9909.15751189@...1498...>
	<201109201228.30353.heiko.hund@...1489...>
In-Reply-To: <201109201228.30353.heiko.hund@...1489...>
MIME-Version: 1.0
Message-Id: <201109201318.00120.heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] Snapshot
	openvpn-2.x-20110909-master-install.exe fails
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
To: openvpn-devel@lists.sourceforge.net

On Tuesday 20 September 2011 12:28:30 Heiko Hund wrote:
> or maybe it's just that _MSC_VER was not defined

Misread the code, it's an #ifndef. Could someone test if replacing the

	#ifndef _MSC_VER

lines in socket.c and win32.h with

	#if WINVER < 0x0600

leads to a problem when building with MSVC.=20

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

