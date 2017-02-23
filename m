From: Gert Doering <gert@...1296...>
Date: Thu, 23 Feb 2017 09:49:54 +0100
Message-Id: <20170223084954.58464-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Add openssl_compat.h to openvpn_SOURCES
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

Commit b936ddfb63 introduced a new header file but forgot to include
it in the list of openvpn_SOURCES, so it did not get bundled in the
generated tarballs.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 3f978553..fcc22d68 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -81,6 +81,7 @@ openvpn_SOURCES = \
 	multi.c multi.h \
 	ntlm.c ntlm.h \
 	occ.c occ.h occ-inline.h \
+	openssl_compat.h \
 	pkcs11.c pkcs11.h pkcs11_backend.h \
 	pkcs11_openssl.c \
 	pkcs11_mbedtls.c \
-- 
2.11.0


