From: Arne Schwabe <arne@...1227...>
Date: Sun, 16 Nov 2014 11:36:39 +0100
Message-Id: <1416134199-3143-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Remove possibility of using --secret with
	non OpenVPN Static key files
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

In older version OpenVPN would hash a --secret file if it does not conform to the expected format
---
 src/openvpn/crypto.c | 65 ++++------------------------------------------------
 1 file changed, 4 insertions(+), 61 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index ef2bde1..eaef964 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -770,22 +770,13 @@ get_tls_handshake_key (const struct key_type *key_type,
 	  }
 	else
 	  {
-	    int hash_size;
-
 	    CLEAR (key2);
 
-	    /* failed, now try to get hash from a freeform file */
-	    hash_size = read_passphrase_hash (passphrase_file,
-					      kt.digest,
-					      key2.keys[0].hmac,
-					      MAX_HMAC_KEY_LENGTH);
-	    ASSERT (hash_size == kt.hmac_length);
-
-	    /* suceeded */
-	    key2.n = 1;
+	    /* failed, now bail out */
 
-	    msg (M_INFO,
-		 "Control Channel Authentication: using '%s' as a free-form passphrase file",
+	    msg (M_ERR,
+		 "Control Channel Authentication: File '%s' does not have OpenVPN Static Key format. "
+		 "Using free-form passphrase file is not supported anymore",
 		 passphrase_file);
 	  }
       }
@@ -1012,54 +1003,6 @@ read_key_file (struct key2 *key2, const char *file, const unsigned int flags)
   gc_free (&gc);
 }
 
-int
-read_passphrase_hash (const char *passphrase_file,
-		      const md_kt_t *digest,
-		      uint8_t *output,
-		      int len)
-{
-  md_ctx_t md;
-
-  ASSERT (len >= md_kt_size(digest));
-  memset (output, 0, len);
-
-  md_ctx_init(&md, digest);
-
-  /* read passphrase file */
-  {
-    const int min_passphrase_size = 8;
-    uint8_t buf[64];
-    int total_size = 0;
-    int fd = platform_open (passphrase_file, O_RDONLY, 0);
-
-    if (fd == -1)
-      msg (M_ERR, "Cannot open passphrase file: '%s'", passphrase_file);
-
-    for (;;)
-      {
-	int size = read (fd, buf, sizeof (buf));
-	if (size == 0)
-	  break;
-	if (size == -1)
-	  msg (M_ERR, "Read error on passphrase file: '%s'",
-	       passphrase_file);
-	md_ctx_update(&md, buf, size);
-	total_size += size;
-      }
-    close (fd);
-
-    warn_if_group_others_accessible (passphrase_file);
-
-    if (total_size < min_passphrase_size)
-      msg (M_FATAL,
-	   "Passphrase file '%s' is too small (must have at least %d characters)",
-	   passphrase_file, min_passphrase_size);
-  }
-  md_ctx_final(&md, output);
-  md_ctx_cleanup(&md);
-  return md_kt_size(digest);
-}
-
 /*
  * Write key to file, return number of random bits
  * written.
-- 
1.9.3 (Apple Git-50)


