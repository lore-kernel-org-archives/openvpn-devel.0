Message-ID: <20040216222356.GA2713@...85...>
Mime-Version: 1.0
From: Christof Meerwald <cmeerw@...83...>
Subject: [Openvpn-devel] Compiling with MinGW 3.1.0-1
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
Date: Mon Feb 16 14:33:27 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

I had to apply the following patch to make OpenVPN 1.6-beta6 compile with
MinGW 3.1.0-1:

diff -ur openvpn-1.6_beta6.orig/config-win32.h openvpn-1.6_beta6/config-win32.h
--- openvpn-1.6_beta6.orig/config-win32.h	Thu Feb 05 21:08:37 2004
+++ openvpn-1.6_beta6/config-win32.h	Mon Feb 16 20:47:37 2004
@@ -36,6 +36,8 @@
 
 #include <windows.h>
 #include <winsock2.h>
+#include <unistd.h>
+#include <fcntl.h>
 
 #define sleep(x) Sleep((x)*1000)
 
@@ -43,7 +45,7 @@
 #define srandom srand
 
 typedef unsigned int in_addr_t;
-typedef unsigned int ssize_t;
+/* typedef unsigned int ssize_t; */
 
 /* Should we print debug info from driver? */
 /* #define TAP_WIN32_DEBUG */


bye, Christof

-- 
http://cmeerw.org                                 JID: cmeerw@...84...
mailto cmeerw at web.de

