From: David Sommerseth <davids@...1347...>
Date: Fri, 17 Feb 2012 12:30:33 +0100
Message-Id: <1329478233-20295-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Makefile.am was missing ssl_common.h
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

In commit 9a160b796e1a40f9635231e5533ce40d46dba25f ssl_common.h
was introduced, but never listed as a source file in Makefile.am

Signed-off-by: David Sommerseth <davids@...1347...>
---
 Makefile.am |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 2029389..26b80f3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -146,6 +146,7 @@ openvpn_SOURCES = \
 	ssl.c ssl.h  ssl_backend.h \
 	ssl_openssl.c ssl_openssl.h \
 	ssl_polarssl.c ssl_polarssl.h \
+	ssl_common.h \
 	ssl_verify.c ssl_verify.h ssl_verify_backend.h \
 	ssl_verify_openssl.c ssl_verify_openssl.h \
 	ssl_verify_polarssl.c ssl_verify_polarssl.h \
-- 
1.7.4.4


