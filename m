Message-ID: <4F4B4993.9060309@...1114...>
Date: Mon, 27 Feb 2012 10:14:59 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
	<1329787361-26096-11-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-11-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 10/35] build: plugins: properly use
 CFLAGS and LDFLAGS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 21/02/12 02:22, Alon Bar-Lev wrote:
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- 
> plugins/auth-pam/Makefile  |    9 +++++---- plugins/defer/build
> |    6 +++--- plugins/down-root/Makefile |    6 +++--- 
> plugins/examples/build     |    6 +++--- 4 files changed, 14
> insertions(+), 13 deletions(-)
> 
> diff --git a/plugins/auth-pam/Makefile b/plugins/auth-pam/Makefile 
> index e69fe3f..17d6c80 100755 --- a/plugins/auth-pam/Makefile +++
> b/plugins/auth-pam/Makefile @@ -15,16 +15,17 @@ endif # This directory
> is where we will look for openvpn-plugin.h INCLUDE=-I../..
> 
> -CC_FLAGS=-O2 -Wall -DDLOPEN_PAM=$(DLOPEN_PAM) +CFLAGS=-O2 -Wall +DEFS
> = -DDLOPEN_PAM=$(DLOPEN_PAM)
> 
> openvpn-auth-pam.so : auth-pam.o pamdl.o -	gcc ${CC_FLAGS} -fPIC
> -shared -Wl,-soname,openvpn-auth-pam.so -o openvpn-auth-pam.so
> auth-pam.o pamdl.o -lc $(LIBPAM) +	gcc $(CFLAGS) -fPIC -shared
> $(LDFLAGS) -Wl,-soname,openvpn-auth-pam.so -o openvpn-auth-pam.so
> auth-pam.o pamdl.o -lc $(LIBPAM)
> 
> auth-pam.o : auth-pam.c pamdl.h -	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE}
> auth-pam.c +	gcc $(CFLAGS) $(DEFS) -fPIC -c $(INCLUDE) auth-pam.c
> 
> pamdl.o : pamdl.c pamdl.h -	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE}
> pamdl.c +	gcc $(CFLAGS) $(DEFS) -fPIC -c $(INCLUDE) pamdl.c
> 
> clean : rm -f *.o *.so diff --git a/plugins/defer/build
> b/plugins/defer/build index 5907afa..cb650f3 100755 ---
> a/plugins/defer/build +++ b/plugins/defer/build @@ -8,7 +8,7 @@ # This
> directory is where we will look for openvpn-plugin.h 
> INCLUDE="-I../.."
> 
> -CC_FLAGS="-O2 -Wall -g" +CFLAGS="${CFLAGS:--O2 -Wall -g}"
> 
> -gcc $CC_FLAGS -fPIC -c $INCLUDE $1.c && \ -gcc $CC_FLAGS -fPIC
> -shared -Wl,-soname,$1.so -o $1.so $1.o -lc +gcc $CFLAGS -fPIC -c
> $INCLUDE $1.c && \ +gcc $CFLAGS -fPIC -shared $LDFLAGS
> -Wl,-soname,$1.so -o $1.so $1.o -lc diff --git
> a/plugins/down-root/Makefile b/plugins/down-root/Makefile index
> 5ce4ffb..f8a183c 100755 --- a/plugins/down-root/Makefile +++
> b/plugins/down-root/Makefile @@ -5,13 +5,13 @@ # This directory is
> where we will look for openvpn-plugin.h INCLUDE=-I../..
> 
> -CC_FLAGS=-O2 -Wall +CFLAGS=-O2 -Wall
> 
> down-root.so : down-root.o -	gcc ${CC_FLAGS} -fPIC -shared
> -Wl,-soname,openvpn-down-root.so -o openvpn-down-root.so down-root.o
> -lc +	gcc $(CFLAGS) -fPIC -shared $(LDFLAGS)
> -Wl,-soname,openvpn-down-root.so -o openvpn-down-root.so down-root.o
> -lc
> 
> down-root.o : down-root.c -	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE}
> down-root.c +	gcc $(CFLAGS) -fPIC -c $(INCLUDE) down-root.c
> 
> clean : rm -f *.o *.so diff --git a/plugins/examples/build
> b/plugins/examples/build index 5907afa..93e1936 100755 ---
> a/plugins/examples/build +++ b/plugins/examples/build @@ -8,7 +8,7 @@ 
> # This directory is where we will look for openvpn-plugin.h 
> INCLUDE="-I../.."
> 
> -CC_FLAGS="-O2 -Wall -g" +CFLAGS="${CFLAGS:--O2 -Wall -g}"
> 
> -gcc $CC_FLAGS -fPIC -c $INCLUDE $1.c && \ -gcc $CC_FLAGS -fPIC
> -shared -Wl,-soname,$1.so -o $1.so $1.o -lc +gcc $CFLAGS -fPIC -c
> $INCLUDE $1.c && \ +gcc $CFLAGS -fPIC -shared ${LDFLAS}
> -Wl,-soname,$1.so -o $1.so $1.o -lc


ACK.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9LSZMACgkQDC186MBRfrrtNgCgkEkksNlbExJPBynVkEXn5QNA
9RQAoIX4+5mbNoeKXlVKjE1qBlRrNLrv
=yG8v
-----END PGP SIGNATURE-----

