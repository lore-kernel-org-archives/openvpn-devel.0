MIME-Version: 1.0
In-Reply-To: <1300880316-5779-1-git-send-email-samuli@...515...>
References: <1300880316-5779-1-git-send-email-samuli@...515...>
Date: Wed, 23 Mar 2011 13:56:54 +0200
Message-ID: <AANLkTin8YnsrbdBua5n79YGQwhnt4mODxW9C0mKY17_L@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

I think management/management-notes.txt should be in dist_doc_DATA so
it actually get installed.


2011/3/23 Samuli Sepp=C3=A4nen <samuli@...515...>
>
> Removed reference to config-win32.h, which has been removed. Added
> management-notes.txt to dist rules.
>
> Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
> ---
> =C2=A0Makefile.am | =C2=A0 =C2=A06 ++----
> =C2=A01 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index 1c9468c..194e5b9 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -60,9 +60,6 @@ SUBDIRS =3D \
> =C2=A0TESTS =3D t_client.sh t_lpback.sh t_cltsrv.sh
> =C2=A0sbin_PROGRAMS =3D openvpn
>
> -dist_noinst_HEADERS =3D \
> - =C2=A0 =C2=A0 =C2=A0 config-win32.h
> -
> =C2=A0dist_noinst_SCRIPTS =3D \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(TESTS) \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0doclean \
> @@ -75,7 +72,8 @@ dist_noinst_DATA =3D \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0COPYRIGHT.GPL \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0PORTS \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0INSTALL-win32.txt \
> - =C2=A0 =C2=A0 =C2=A0 service-win32/msvc.mak
> + =C2=A0 =C2=A0 =C2=A0 service-win32/msvc.mak \
> + =C2=A0 =C2=A0 =C2=A0 management/management-notes.txt
>
> =C2=A0openvpn_SOURCES =3D \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 base64.c base64.h \
> --
> 1.6.3.3
>
>
> -------------------------------------------------------------------------=
-----
> Enable your software for Intel(R) Active Management Technology to meet the
> growing manageability and security demands of your customers. Businesses
> are taking advantage of Intel(R) vPro (TM) technology - will your software
> be a part of the solution? Download the Intel(R) Manageability Checker
> today! http://p.sf.net/sfu/intel-dev2devmar
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

