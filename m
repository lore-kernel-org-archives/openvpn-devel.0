From: Arne Schwabe <arne@...1227...>
Date: Fri, 10 May 2019 14:11:10 +0200
Message-Id: <20190510121114.30468-4-arne@...1227...>
In-Reply-To: <20190510121114.30468-1-arne@...1227...>
References: <20190510121114.30468-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3 3/7] Add pem_read_key_file variant that
 allows a random key
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
---
 src/openvpn/crypto.c | 22 ++++++++++++++++++++++
 src/openvpn/crypto.h | 15 +++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index eb56421b..0e17c351 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1892,6 +1892,28 @@ cleanup:
     return;
 }
 
+bool
+load_pem_file_or_ephemeral_key(struct buffer *key, const char *pem_name,
+                               const char *key_file, const char *key_inline)
+{
+    if (key_file == NULL)
+    {
+        msg(M_INFO, "Using random %s.", pem_name);
+        uint8_t rand[BCAP(key)];
+        if (!rand_bytes(rand, BCAP(key)))
+        {
+            msg(M_WARN, "ERROR: could not generate random key");
+            return false;
+        }
+        buf_write(key, rand, BCAP(key));
+        return true;
+    }
+    else
+    {
+        return read_pem_key_file(key, pem_name, key_file, key_inline);
+    }
+}
+
 bool
 read_pem_key_file(struct buffer *key, const char *pem_name,
                   const char *key_file, const char *key_inline)
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index c5947483..4ae02571 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -430,6 +430,21 @@ unsigned int crypto_max_overhead(void);
 void
 write_pem_key_file(const char *filename, const char *pem_name);
 
+/**
+ * Read key material from a PEM encoded files into the key structure or if
+ * the filename is not passed generate a ephemeral key
+ *
+ * @param key           the key structure that will hold the key material
+ * @param pem_name      the name used in the pem encoding start/end lines
+ * @param key_file      name of the file to read or NULL if an ephermal key
+ *                      should be generated
+ * @param key_inline    a string holding the data in case of an inline key
+ * @return              true if reading into key was successful or generated
+ */
+bool
+load_pem_file_or_ephemeral_key(struct buffer *key, const char *pem_name,
+                               const char *key_file, const char *key_inline);
+
 /**
  * Read key material from a PEM encoded files into the key structure
  * @param key           the key structure that will hold the key material
-- 
2.21.0


