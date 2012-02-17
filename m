From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 17 Feb 2012 10:51:10 +0100
Message-ID: <5374780.EoPQ9uqcdy@...1526...>
In-Reply-To: <CAOazyz3q3iCDAaxaQbmWYmTx=wHDv5TDxzJhmXMmC82VOEcA3w@...278...>
References: <1329413441-22538-1-git-send-email-heiko.hund@...1489...>
	<1329413441-22538-5-git-send-email-heiko.hund@...1489...>
	<CAOazyz3q3iCDAaxaQbmWYmTx=wHDv5TDxzJhmXMmC82VOEcA3w@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 4/4] make MSVC link against shell32 as
	well
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

On Thursday 16 February 2012 18:37:21 Alon Bar-Lev wrote:
> On Thu, Feb 16, 2012 at 7:30 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> > Windows API CommandLineToArgvW(), introduced in Windows unicode path
> > commit 71bbbd76c62630c88441237d72fe5b61f0b45b2a, is defined therein.
>=20
> Usually this should be avoided and get command-line from wmain().

the general idea is to make Unicode things happen without changing the open=
vpn=20
code too much in a very Windows specific way. Converting UCS-2 to UTF-8=20
directly where input and output is happening and passing it through the res=
t=20
of openvpn as char* does that. I don't see any benefit in converting openvp=
n=20
into a native unicode binary.

Regards
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


