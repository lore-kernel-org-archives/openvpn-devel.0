MIME-Version: 1.0
In-Reply-To: <4F588353.8060307@...515...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-34-git-send-email-alon.barlev@...277...>
	<4F588353.8060307@...515...>
Date: Thu, 8 Mar 2012 21:43:40 +0200
Message-ID: <CAOazyz1wHvU=f9XuyTC1dkzBDw0xMt=Kg_EH43r3t4Vp_humcg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Although I work with flameeyes closely in some of these issues...

I disagree with his opinion here as generic approach.

He is write as in most cases people just adds libraries as they go in
the configure process...
So you check for dl, then rt, then resolv, then selinux etc...
building your LIBS.
The result is one long LIBS which is common to all executables.

I take another approach and detect dependencies as atoms.

Yes... if one day dl will be merged into libc we fail in this case,
but then we can fix <something>.

For now this is working perfectly.

Alon.

2012/3/8 Samuli Sepp=C3=A4nen <samuli@...515...>:
> Did some digging regarding AC_SEARCH_LIBS and AC_CHECK_LIB. Somebody
> with more autotools knowledge might want to read this one:
>
> <http://www.flameeyes.eu/autotools-mythbuster/autoconf/finding.html>
>
> So, the question is: why AC_CHECK_LIB rather than AC_SEARCH_LIBS in this
> particular case? Apparently both have their uses.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
>> ---
>> =C2=A0configure.ac =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 27 =
+++++++++++++++++----------
>> =C2=A0src/openvpn/Makefile.am | =C2=A0 =C2=A01 +
>> =C2=A02 files changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index a0dc462..c540f82 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -442,16 +442,6 @@ if test "${WIN32}" !=3D "yes"; then
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [[${SOCKET_INCLUDES}]]
>> =C2=A0 =C2=A0 =C2=A0 )
>>
>> - =C2=A0 =C2=A0 AC_CHECK_DECLS(
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [SO_MARK],
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [[${SOCKET_INCLUDES}]]
>> - =C2=A0 =C2=A0 )
>> -
>> - =C2=A0 =C2=A0 AC_SEARCH_LIBS([socket], [socket])
>> - =C2=A0 =C2=A0 AC_SEARCH_LIBS([inet_ntoa], [nsl])
>> - =C2=A0 =C2=A0 AC_SEARCH_LIBS([gethostbyname], [resolv nsl])
>> =C2=A0 =C2=A0 =C2=A0 AC_FUNC_FORK
>> =C2=A0fi
>>
>> @@ -613,6 +603,23 @@ AC_CHECK_LIB(
>> =C2=A0)
>> =C2=A0AC_SUBST([DL_LIBS])
>>
>> +AC_CHECK_LIB(
>> + =C2=A0 =C2=A0 [nsl],
>> + =C2=A0 =C2=A0 [inet_ntoa],
>> + =C2=A0 =C2=A0 [SOCKETS_LIBS=3D"${SOCKETS_LIBS} -lnsl"]
>> +)
>> +AC_CHECK_LIB(
>> + =C2=A0 =C2=A0 [socket],
>> + =C2=A0 =C2=A0 [socket],
>> + =C2=A0 =C2=A0 [SOCKETS_LIBS=3D"${SOCKETS_LIBS} -lsocket"]
>> +)
>> +AC_CHECK_LIB(
>> + =C2=A0 =C2=A0 [resolv],
>> + =C2=A0 =C2=A0 [gethostbyname],
>> + =C2=A0 =C2=A0 [SOCKETS_LIBS=3D"${SOCKETS_LIBS} -lresolv"]
>> +)
>> +AC_SUBST([SOCKETS_LIBS])
>> +
>> =C2=A0case "${with_mem_check}" in
>> =C2=A0 =C2=A0 =C2=A0 valgrind)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_CHECK_HEADER(
>> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
>> index c7626c8..86abd09 100644
>> --- a/src/openvpn/Makefile.am
>> +++ b/src/openvpn/Makefile.am
>> @@ -96,6 +96,7 @@ openvpn_SOURCES =3D \
>> =C2=A0 =C2=A0 =C2=A0 win32.h win32.c \
>> =C2=A0 =C2=A0 =C2=A0 cryptoapi.h cryptoapi.c
>> =C2=A0openvpn_LDADD =3D \
>> + =C2=A0 =C2=A0 $(SOCKETS_LIBS) \
>> =C2=A0 =C2=A0 =C2=A0 $(OPTIONAL_DL_LIBS)
>> =C2=A0if WIN32
>> =C2=A0openvpn_SOURCES +=3D openvpn_win32_resources.rc
>

