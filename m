Message-ID: <08ca01c43dd1$8d06d170$0200000a@...139...>
From: "Gisle Vanem" <gvanem@...139...>
MIME-Version: 1.0
Subject: [Openvpn-devel] MingW patch
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
Date: Wed May 19 11:47:01 2004
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

The latest MingW runtime and headers defines 'ssize_t'.
So this patch is needed:

--- openvpn-2.0_beta2/config-win32.h.in Thu May 13 23:56:23 2004
+++ config-win32.h.in   Wed May 19 16:54:07 2004
@@ -42,8 +42,12 @@
 #define random rand
 #define srandom srand

-typedef unsigned int in_addr_t;
+typedef unsigned long in_addr_t;
+
+#ifndef _SSIZE_T_
+#define _SSIZE_T_
 typedef unsigned int ssize_t;
+#endif

 /* Append a label to program startup title */
 //#define DEBUG_LABEL "DEBUG1"

------

And an IPv4-address should not be an 'int'; does OpenVPN work on
Win64 btw?

--gv



