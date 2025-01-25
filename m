From: Gert Doering <gert@...1296...>
Date: Sat, 25 Jan 2025 11:08:38 +0100
Message-ID: <20250125100838.20796-1-gert@...1296...>
In-Reply-To: <gerrit.1736865848000.Iaaf80c688ddff79ac9472d7237003713637c140b@...2715...>
References: <gerrit.1736865848000.Iaaf80c688ddff79ac9472d7237003713637c140b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] tls_crypt_v2_write_client_key_file: Fix
 missing-field-initializers compiler warning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Frank Lichtenheld <frank@...2641...>

GCC wants us to be more explicit here.

Change-Id: Iaaf80c688ddff79ac9472d7237003713637c140b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/867
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 24df930..4c421aa 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -691,7 +691,7 @@
     struct buffer client_key_pem = { 0 };
     struct buffer dst = alloc_buf_gc(TLS_CRYPT_V2_CLIENT_KEY_LEN
                                      + TLS_CRYPT_V2_MAX_WKC_LEN, &gc);
-    struct key2 client_key = { 2 };
+    struct key2 client_key = { .n = 2 };
 
     if (!rand_bytes((void *)client_key.keys, sizeof(client_key.keys)))
     {

