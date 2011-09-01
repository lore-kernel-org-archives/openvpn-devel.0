From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 1 Sep 2011 22:27:49 +0200
References: <1312714757-10317-3-git-send-email-beber@...1472...>
	<1312715302-10808-1-git-send-email-beber@...1472...>
In-Reply-To: <1312715302-10808-1-git-send-email-beber@...1472...>
MIME-Version: 1.0
Message-Id: <201109012227.49712.heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] Win32: Add OpenVPN RC file to add
	fill "Details" exe properties tabs
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

On Sunday 07 August 2011 13:08:22 Bertrand Jacquin wrote:
> +1 VERSIONINFO

Could use VS_VERSION_INFO instead of 1

> +  FILEVERSION    _VERSION_
> +  PRODUCTVERSION _VERSION_

See my other mail about the version.

> +    BLOCK "040904b0"  /* en_US, Unicode */

Openvpn itself is not compiled as Unicode binary, so 04090000 for ASCII wou=
ld=20
be more precise.

> +      VALUE "CompanyName",      PACKAGE_NAME "\0"
> +      VALUE "FileDescription",  PACKAGE_NAME "\0"
> +      VALUE "FileVersion",      PACKAGE_VERSION "\0"
> +      VALUE "InternalName",     PACKAGE_TARNAME "\0"
> +      VALUE "OriginalFilename", PACKAGE_TARNAME ".exe\0"
> +      VALUE "ProductName",      PACKAGE_NAME "\0"
> +      VALUE "ProductVersion",   PACKAGE_VERSION "\0"
> +      VALUE "LegalCopyright",   "(C) 2002-2010 " PACKAGE_NAME "
> Technologies, Inc.\0"

The \0's are not needed here.

> +    VALUE "Translation", 0x409, 0x4b0

Same, no Unicode.

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



