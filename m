From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0-test26 released
Message-ID: <20040501105816.GC14147@...33...>
References: <twig.1083217597.4062@...41...>
Mime-Version: 1.0
In-Reply-To: <twig.1083217597.4062@...41...>
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
Date: Sat May  1 03:59:02 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Thu, 29 Apr 2004, James Yonan wrote:

> Ooops... let's try that again with the correct subject line.
> 
> A new release of the 2.0 beta is available.

This prompted me to pull from CVS, I figured I need this patch on Linux
when compiling with GCC 3.4 with strict error checking enabled:

Index: syshead.h
===================================================================
RCS file: /cvsroot/openvpn/openvpn/syshead.h,v
retrieving revision 1.25.2.6
diff -u -r1.25.2.6 syshead.h
--- syshead.h	29 Apr 2004 06:19:46 -0000	1.25.2.6
+++ syshead.h	1 May 2004 10:09:05 -0000
@@ -26,6 +26,8 @@
 #ifndef SYSHEAD_H
 #define SYSHEAD_H
 
+#define _BSD_SOURCE
+
 #ifdef HAVE_SYS_TYPES_H
 #include <sys/types.h>
 #endif



