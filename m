From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 28 Mar 2012 13:13:47 +0200
Message-ID: <2923473.VmpqgqZo5Q@...1526...>
In-Reply-To: <1330546942-18250-1-git-send-email-alon.barlev@...277...>
References: <1330546942-18250-1-git-send-email-alon.barlev@...277...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [openvpn-gui 0/8] build rewrite
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
Cc: Alon Bar-Lev <alon.barlev@...277...>, "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Hi Alon.

Thanks for the contributions. I just pushed the changes, some of them=20
modified. See below for comments.

> Alon Bar-Lev (8):
>   cleanup: resolve unused parameter warnings

Changed this to use gcc attributes like in other places.

>   cleanup: dos2unix res/openvpn-gui-res-fi.rc
>   cleanup: dos2unix res/openvpn-gui-res-jp.rc
>   cleanup: dos2unix OpenVPN GUI ReadMe.txt

Merged into one commit that also converts all source files to \n line endin=
gs.

>   build: rework build

Removed use of libtool and the implicit automake rule for .rc files. Instea=
d=20
add a manual rule for the resource object to Makefile.am.

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


