From: David Sommerseth <davids@...1347...>
Date: Fri, 17 Feb 2012 12:13:11 +0100
Message-Id: <1329477191-634-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Makefile.am referenced a now non-existing
	config-win32.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This file was moved to win/config.h.in and is the template used
by the Python build tools in win/.  This happened in
commit 4b312378e9e7084a0699ca6d4b895bdadb7540db

For all other autotools based environments, ./configure will take
care of creating the proper config.h

Signed-off-by: David Sommerseth <davids@...1347...>
---
 Makefile.am |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index ab86cc1..2029389 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -85,7 +85,6 @@ openvpn_SOURCES = \
 	clinat.c clinat.h \
 	common.h \
 	compat.h compat.c \
-	config-win32.h \
 	crypto.c crypto.h crypto_backend.h \
 	crypto_openssl.c crypto_openssl.h \
 	crypto_polarssl.c crypto_polarssl.h \
-- 
1.7.4.4


