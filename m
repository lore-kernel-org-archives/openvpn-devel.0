References: <1464883738-904-1-git-send-email-openvpn@...2080...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <d61c2761-0ec4-6b46-5e7c-c63b842ef6a4@...515...>
Date: Fri, 3 Jun 2016 09:46:25 +0300
MIME-Version: 1.0
In-Reply-To: <1464883738-904-1-git-send-email-openvpn@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Another fix related to unit test
 framework
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <dazo@...2145...>

This patch seems to do what it promises, so a feature-ACK from me.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

> From: David Sommerseth <dazo@...2145...>
>
> Continuing to fix breakage caused by commit 40cb4cfc5d011102.
>
> It seems it was a conflict in vendor/Makefile.am's distdir target,
> confusing autotools so it wouldn't actually parse that directory
> properly.  The result was that 'make distcheck' would fail and
> tarballs created would just ship with an empty vendor/ directory.
>
> Also remove the 'foreign' AUTOMAKE_OPTIONS flag, as we don't use
> that many places at all.  Things work well without this flag.
>
> Signed-off-by: David Sommerseth <dazo@...2145...>
> ---
>  vendor/Makefile.am | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/vendor/Makefile.am b/vendor/Makefile.am
> index 84656a1..6c925b0 100644
> --- a/vendor/Makefile.am
> +++ b/vendor/Makefile.am
> @@ -1,5 +1,3 @@
> -AUTOMAKE_OPTIONS =3D foreign
> -
>  cmockasrc     =3D @VENDOR_SRC_ROOT@/cmocka  # needs an absolute path bc.=
 of the cmake invocation
>  cmockabuild   =3D @VENDOR_BUILD_ROOT@/cmocka
>  cmockainstall =3D @VENDOR_DIST_ROOT@
> @@ -10,12 +8,9 @@ MAINTAINERCLEANFILES =3D \
>  	$(cmockainstall) \
>  	@VENDOR_BUILD_ROOT@
>
> -distdir:
> -	mkdir -p $(cmockainstall)
> -
> -libcmocka: distdir
> -	mkdir -p $(cmockabuild)
> +libcmocka:
>  if CMOCKA_INITIALIZED
> +	mkdir -p $(cmockabuild) $(cmockainstall)
>  	(cd $(cmockabuild) && cmake -DCMAKE_INSTALL_PREFIX=3D$(cmockainstall) $=
(cmockasrc) && make && make install)
>  endif
>
>



