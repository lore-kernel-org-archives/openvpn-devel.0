Message-ID: <4433CAD4.50807@...601...>
From: Johnny Lam <jlam@...601...>
Reply-To: openvpn-devel@lists.sourceforge.net
MIME-Version: 1.0
References: <200604051130.00196.uberlord@...594...>
In-Reply-To: <200604051130.00196.uberlord@...594...>
Subject: [Openvpn-devel] Re: [PATCH] Enable compliation under Darwin
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Apr  5 06:48:20 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Roy Marples <uberlord@...594...>
Cc: openvpn-devel@lists.sourceforge.net

Roy Marples wrote:
> --- openvpn-2.0.4/plugin/down-root/Makefile.orig	2005-11-02 20:25:40.000000000 +0100
> +++ openvpn-2.0.4/plugin/down-root/Makefile	2005-11-02 20:31:53.000000000 +0100
> @@ -7,11 +7,22 @@
>  
>  CC_FLAGS=-O2 -Wall
>  
> +ifeq ($(USERLAND),Darwin)
> +	LIBNAME=dylib
> +else
> +	LIBNAME=so
> +endif
> +
> +lib : down-root.$(LIBNAME)
> +
>  down-root.so : down-root.o
>  	gcc ${CC_FLAGS} -fPIC -shared -Wl,-soname,openvpn-down-root.so -o openvpn-down-root.so down-root.o -lc
>  
> +down-root.dylib : down-root.o
> +	gcc ${CC_FLAGS} -dynamiclib -install_name openvpn-down-root.dylib -o openvpn-down-root.dylib down-root.o -lc
> +
>  down-root.o : down-root.c
>  	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE} down-root.c
>  
>  clean :
> -	rm -f *.o *.so
> +	rm -f *.o *.so *.dylib

According to the Fink porting documents[1], this is not the right way to 
link loadable modules on Mac OS X.  The module should properly end with 
".so", and the compiler flags should include "-bundle" and not 
"-dynamiclib", which should only be used when linking a shared library.

[1] http://fink.sf.net/doc/porting/shared.php?phpLang=en#lib-and-mod

	Cheers,

	-- Johnny Lam <jlam@...601...>

