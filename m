From: Steffan Karger <steffan@...1856...>
Date: Sun, 17 Apr 2016 11:56:20 +0200
Message-Id: <1460886980-12925-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] fixup: change init_key_type() param name in
	declaration too
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

Commit 66407e11 changed the name of the cfb_ofb_allowed parameter of the
init_key_type() implementation to 'tls_mode', but forgot to do the same in
the function declaration.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index d3e08c1..63d7040 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -297,7 +297,7 @@ int read_key (struct key *key, const struct key_type *kt, struct buffer *buf);
 
 void init_key_type (struct key_type *kt, const char *ciphername,
     bool ciphername_defined, const char *authname, bool authname_defined,
-    int keysize, bool cfb_ofb_allowed, bool warn);
+    int keysize, bool tls_mode, bool warn);
 
 /*
  * Key context functions
-- 
2.5.0


