From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 1 Sep 2011 22:15:02 +0200
References: <1312714757-10317-1-git-send-email-beber@...1472...>
	<1312714757-10317-4-git-send-email-beber@...1472...>
In-Reply-To: <1312714757-10317-4-git-send-email-beber@...1472...>
MIME-Version: 1.0
Message-Id: <201109012215.03152.heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH 3/4] Win32: Fill "Details" properties
	for openvpn.exe
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

On Sunday 07 August 2011 12:59:16 Bertrand Jacquin wrote:
> @@ -161,6 +168,11 @@ dist_noinst_DATA +=3D openvpn.8
>  nodist_html_DATA =3D openvpn.8.html
>  openvpn.8.html: $(srcdir)/openvpn.8
>  	$(MAN2HTML) < $(srcdir)/openvpn.8 > openvpn.8.html
> +
> +comma =3D ,
> +
> +%.o: %.rc
> +	$(WINDRES) -D _VERSION_=3D$(subst .,$(comma),$(VERSION)),0 -i $< -o $@
>  else
>  dist_man_MANS =3D openvpn.8
>  endif

This will at least break compilation on master where=20

	#define VERSION "2.x-master"

_VERSION_ needs needs to be stricly numerical. Maybe we could define a=20
WINDOWS_VERSION a,b,c,0 in version.m4 for this. Or even have separate major=
,=20
minor and patch version definitions in there that could be used to build th=
e=20
versions in the .rc file itself.

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



