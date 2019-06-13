From: Arne Schwabe <arne@...1227...>
Date: Thu, 13 Jun 2019 15:48:30 +0200
Message-Id: <20190613134834.5709-2-arne@...1227...>
In-Reply-To: <20190613134834.5709-1-arne@...1227...>
References: <20190613134834.5709-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v4 3/7] Add generate_ephemeral_key that
 allows a random ephermal key
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
Cc: Arne Schwabe <arne@...515...>

From: Arne Schwabe <arne@...515...>

This is useful for features that can use enither a persistent
or an ephemeral key.

Patch V2: Move the functionality of generating a random key into a
          separate function that acts as wrapper for pem_read_key_file
Patch V4: Move wrapper functionality to caller and leave only generate
          epehermal key functionality in the new function
---
 src/openvpn/crypto.c | 14 ++++++++++++++
 src/openvpn/crypto.h | 12 +++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 9a150fa2..69877d1d 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1892,6 +1892,20 @@ cleanup:
     return;
 }
 
+bool
+generate_ephemeral_key(struct buffer *key, const char *key_name)
+{
+    msg(M_INFO, "Using random %s.", key_name);
+    uint8_t rand[BCAP(key)];
+    if (!rand_bytes(rand, BCAP(key)))
+    {
+        msg(M_WARN, "ERROR: could not generate random key");
+        return false;
+    }
+    buf_write(key, rand, BCAP(key));
+    return true;
+}
+
 bool
 read_pem_key_file(struct buffer *key, const char *pem_name,
                   const char *key_file, const char *key_inline)
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index c5947483..72244997 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -428,7 +428,17 @@ unsigned int crypto_max_overhead(void);
  * @param pem_name          The name to use in the PEM header/footer.
  */
 void
-write_pem_key_file(const char *filename, const char *pem_name);
+write_pem_key_file(const char *filename, const char *key_name);
+
+/**
+ * Generate ephermal key material  into the key structure or if
+ *
+ * @param key           the key structure that will hold the key material
+ * @param pem_name      the name used for logging
+ * @return              true if key generation was successful
+ */
+bool
+generate_ephemeral_key(struct buffer *key, const char *pem_name);
 
 /**
  * Read key material from a PEM encoded files into the key structure
-- 
2.22.0


