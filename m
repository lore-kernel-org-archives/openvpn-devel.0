Message-ID: <4F588353.8060307@...515...>
Date: Thu, 08 Mar 2012 12:00:51 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-34-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-34-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 33/52] build: properly detect and use
 socket libs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Did some digging regarding AC_SEARCH_LIBS and AC_CHECK_LIB. Somebody
with more autotools knowledge might want to read this one:

<http://www.flameeyes.eu/autotools-mythbuster/autoconf/finding.html>

So, the question is: why AC_CHECK_LIB rather than AC_SEARCH_LIBS in this
particular case? Apparently both have their uses.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac            |   27 +++++++++++++++++----------
>  src/openvpn/Makefile.am |    1 +
>  2 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index a0dc462..c540f82 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -442,16 +442,6 @@ if test "${WIN32}" !=3D "yes"; then
>  		[[${SOCKET_INCLUDES}]]
>  	)
>=20=20
> -	AC_CHECK_DECLS(
> -		[SO_MARK],
> -		,
> -		,
> -		[[${SOCKET_INCLUDES}]]
> -	)
> -
> -	AC_SEARCH_LIBS([socket], [socket])
> -	AC_SEARCH_LIBS([inet_ntoa], [nsl])
> -	AC_SEARCH_LIBS([gethostbyname], [resolv nsl])
>  	AC_FUNC_FORK
>  fi
>=20=20
> @@ -613,6 +603,23 @@ AC_CHECK_LIB(
>  )
>  AC_SUBST([DL_LIBS])
>=20=20
> +AC_CHECK_LIB(
> +	[nsl],
> +	[inet_ntoa],
> +	[SOCKETS_LIBS=3D"${SOCKETS_LIBS} -lnsl"]
> +)
> +AC_CHECK_LIB(
> +	[socket],
> +	[socket],
> +	[SOCKETS_LIBS=3D"${SOCKETS_LIBS} -lsocket"]
> +)
> +AC_CHECK_LIB(
> +	[resolv],
> +	[gethostbyname],
> +	[SOCKETS_LIBS=3D"${SOCKETS_LIBS} -lresolv"]
> +)
> +AC_SUBST([SOCKETS_LIBS])
> +
>  case "${with_mem_check}" in
>  	valgrind)
>  		AC_CHECK_HEADER(
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index c7626c8..86abd09 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -96,6 +96,7 @@ openvpn_SOURCES =3D \
>  	win32.h win32.c \
>  	cryptoapi.h cryptoapi.c
>  openvpn_LDADD =3D \
> +	$(SOCKETS_LIBS) \
>  	$(OPTIONAL_DL_LIBS)
>  if WIN32
>  openvpn_SOURCES +=3D openvpn_win32_resources.rc


