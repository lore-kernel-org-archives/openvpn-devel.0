Message-ID: <4D89E4F3.1050408@...515...>
Date: Wed, 23 Mar 2011 14:17:55 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <1300880316-5779-1-git-send-email-samuli@...515...>
	<1300882472-11494-1-git-send-email-samuli@...515...>
In-Reply-To: <1300882472-11494-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Fixes to Makefile.am
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Removed reference to config-win32.h, which has been removed. Added
> management-notes.txt to dist_doc_DATA.
>
> Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
> ---
>  Makefile.am |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index 1c9468c..f311837 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -60,8 +60,8 @@ SUBDIRS =3D \
>  TESTS =3D t_client.sh t_lpback.sh t_cltsrv.sh
>  sbin_PROGRAMS =3D openvpn
>=20=20
> -dist_noinst_HEADERS =3D \
> -	config-win32.h
> +dist_doc_DATA =3D \
> +	management/management-notes.txt
>=20=20
>  dist_noinst_SCRIPTS =3D \
>  	$(TESTS) \
>=20=20=20
Tested building and installing on Ubuntu 9.10. The
"management-notes.txt" ends up in /usr/local/share/doc as it's supposed to.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


