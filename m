Date: Tue, 8 Jan 2013 09:39:12 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20130108093912.7ae7c6f8@...1799...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/Kl53sUyX8RlzBUNjL6dS7ah"
Subject: [Openvpn-devel] fix build with automake 1.13(.1)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--MP_/Kl53sUyX8RlzBUNjL6dS7ah
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everybody,

AM_CONFIG_HEADER has been deprecated for some time, finally it is removed on
automake 1.13. The attached patch replaces it with AC_CONFIG_HEADERS and
fixes build process with latest automake. Please apply.
-- 
main(a){char*c=/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Chris           get my mail address:    */=0;b=c[a++];)
putchar(b-1/(/*               gcc -o sig sig.c && ./sig    */b/42*2-3)*42);}

--MP_/Kl53sUyX8RlzBUNjL6dS7ah
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=openvpn_automake.patch

diff --git a/configure.ac b/configure.ac
index 2f780b7..ddd322c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -32,7 +32,7 @@ m4_include(compat.m4)
 AC_DEFINE([OPENVPN_VERSION_RESOURCE], [PRODUCT_VERSION_RESOURCE], [Version in windows resource format])
 
 AC_CONFIG_AUX_DIR([.])
-AM_CONFIG_HEADER([config.h])
+AC_CONFIG_HEADERS([config.h])
 AC_CONFIG_SRCDIR([src/openvpn/syshead.h])
 AC_CONFIG_MACRO_DIR([m4])
 AM_INIT_AUTOMAKE

--MP_/Kl53sUyX8RlzBUNjL6dS7ah--

