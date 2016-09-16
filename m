From: Steffan Karger <steffan@...1856...>
Date: Fri, 16 Sep 2016 21:53:55 +0200
Message-Id: <1474055635-7427-1-git-send-email-steffan@...1856...>
In-Reply-To: <75084ad5-c8fc-2a87-7828-8270ed6ba88a@...2080...>
References: <75084ad5-c8fc-2a87-7828-8270ed6ba88a@...2080...>
Subject: [Openvpn-devel] [PATCH] cleanup cert_hash_remember scoping
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

Add scopes for the conditional code, remove local scope that's only needed
for c89 support (which we dropped).

This patch should be applied after the SHA256 fingerprint support patch.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_verify.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 15a5de8..d0c22b8 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -197,14 +197,17 @@ cert_hash_remember (struct tls_session *session, const int error_depth,
   if (error_depth >= 0 && error_depth < MAX_CERT_DEPTH)
     {
       if (!session->cert_hash_set)
-	ALLOC_OBJ_CLEAR (session->cert_hash_set, struct cert_hash_set);
+	{
+	  ALLOC_OBJ_CLEAR (session->cert_hash_set, struct cert_hash_set);
+	}
       if (!session->cert_hash_set->ch[error_depth])
-	ALLOC_OBJ (session->cert_hash_set->ch[error_depth], struct cert_hash);
-      {
-	struct cert_hash *ch = session->cert_hash_set->ch[error_depth];
-	ASSERT (sizeof (ch->sha256_hash) == BLEN (cert_hash));
-	memcpy (ch->sha256_hash, BPTR (cert_hash), sizeof (ch->sha256_hash));
-      }
+	{
+	  ALLOC_OBJ (session->cert_hash_set->ch[error_depth], struct cert_hash);
+	}
+
+      struct cert_hash *ch = session->cert_hash_set->ch[error_depth];
+      ASSERT (sizeof (ch->sha256_hash) == BLEN (cert_hash));
+      memcpy (ch->sha256_hash, BPTR (cert_hash), sizeof (ch->sha256_hash));
     }
 }
 
-- 
2.7.4


