Subject: Re: [Openvpn-devel] OpenVPN 2.0-test26 released
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1083468383.41361@...41...>
In-Reply-To: <20040501105816.GC14147@...33...>
References: <twig.1083217597.4062@...41...>, <twig.1083217597.4062@...41...>
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
Date: Sat May  1 20:27:00 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>, openvpn-devel@lists.sourceforge.net

Matthias,

You didn't bracket it with #ifdef TARGET_LINUX -- does that mean it's
appropriate on all platforms?

What about this (from the glibc manual): "If your program defines _BSD_SOURCE,
you must give the option `-lbsd-compat' to the compiler or linker when linking
the program, to tell it to find functions in this special compatibility
library before looking for them in the normal C library."

James

Matthias Andree <ma+ovpnd@...31...> said:

> On Thu, 29 Apr 2004, James Yonan wrote:
> 
> > Ooops... let's try that again with the correct subject line.
> > 
> > A new release of the 2.0 beta is available.
> 
> This prompted me to pull from CVS, I figured I need this patch on Linux
> when compiling with GCC 3.4 with strict error checking enabled:
> 
> Index: syshead.h
> ===================================================================
> RCS file: /cvsroot/openvpn/openvpn/syshead.h,v
> retrieving revision 1.25.2.6
> diff -u -r1.25.2.6 syshead.h
> --- syshead.h	29 Apr 2004 06:19:46 -0000	1.25.2.6
> +++ syshead.h	1 May 2004 10:09:05 -0000
> @@ -26,6 +26,8 @@
>  #ifndef SYSHEAD_H
>  #define SYSHEAD_H
>  
> +#define _BSD_SOURCE
> +
>  #ifdef HAVE_SYS_TYPES_H
>  #include <sys/types.h>
>  #endif
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 



-- 




