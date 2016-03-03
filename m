From: James Yonan <james@...515...>
Date: Thu,  3 Mar 2016 01:19:01 -0700
Message-Id: <1456993146-63968-5-git-send-email-james@...515...>
In-Reply-To: <1456993146-63968-1-git-send-email-james@...515...>
References: <1456993146-63968-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH 05/10] Extended x509-track for OpenSSL to
	report SHA1 fingerprint.
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
Cc: James Yonan <james@...515...>

For example:

  x509-track "+SHA1"

will extract the SHA1 fingerprints for all certs in the
peer chain.

This patch is ported from OpenVPN 2.1.

Signed-off-by: James Yonan <james@...515...>
---
 src/openvpn/ssl_verify_openssl.c | 114 +++++++++++++++++++++++++--------------
 1 file changed, 74 insertions(+), 40 deletions(-)

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index d014f9d..cde884b 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -305,6 +305,27 @@ err:
 
 #ifdef ENABLE_X509_TRACK
 
+/*
+ * x509-track implementation -- save X509 fields to environment,
+ * using the naming convention:
+ *
+ *  X509_{cert_depth}_{name}={value}
+ *
+ * This function differs from x509_setenv below in the following ways:
+ *
+ * (1) Only explicitly named attributes in xt are saved, per usage
+ *     of "x509-track" program options.
+ * (2) Only the level 0 cert info is saved unless the XT_FULL_CHAIN
+ *     flag is set in xt->flags (corresponds with prepending a '+'
+ *     to the name when specified by "x509-track" program option).
+ * (3) This function supports both X509 subject name fields as
+ *     well as X509 V3 extensions.
+ * (4) This function can return the SHA1 fingerprint of a cert, e.g.
+ *       x509-track "+SHA1"
+ *     will return the SHA1 fingerprint for each certificate in the
+ *     peer chain.
+ */
+
 void
 x509_track_add (const struct x509_track **ll_head, const char *name, int msglevel, struct gc_arena *gc)
 {
@@ -346,58 +367,71 @@ do_setenv_x509 (struct env_set *es, const char *name, char *value, int depth)
 void
 x509_setenv_track (const struct x509_track *xt, struct env_set *es, const int depth, X509 *x509)
 {
+  struct gc_arena gc = gc_new();
   X509_NAME *x509_name = X509_get_subject_name (x509);
   const char nullc = '\0';
-  int i;
 
   while (xt)
     {
       if (depth == 0 || (xt->flags & XT_FULL_CHAIN))
 	{
-	  i = X509_NAME_get_index_by_NID(x509_name, xt->nid, -1);
-	  if (i >= 0)
+	  switch (xt->nid)
 	    {
-	      X509_NAME_ENTRY *ent = X509_NAME_get_entry(x509_name, i);
-	      if (ent)
-		{
-		  ASN1_STRING *val = X509_NAME_ENTRY_get_data (ent);
-		  unsigned char *buf;
-		  buf = (unsigned char *)1; /* bug in OpenSSL 0.9.6b ASN1_STRING_to_UTF8 requires this workaround */
-		  if (ASN1_STRING_to_UTF8 (&buf, val) > 0)
-		    {
-		      do_setenv_x509(es, xt->name, (char *)buf, depth);
-		      OPENSSL_free (buf);
-		    }
-		}
-	    }
-	  else
-	    {
-	      i = X509_get_ext_by_NID(x509, xt->nid, -1);
-	      if (i >= 0)
-		{
-		  X509_EXTENSION *ext = X509_get_ext(x509, i);
-		  if (ext)
-		    {
-		      BIO *bio = BIO_new(BIO_s_mem());
-		      if (bio)
-			{
-			  if (X509V3_EXT_print(bio, ext, 0, 0))
-			    {
-			      if (BIO_write(bio, &nullc, 1) == 1)
-				{
-				  char *str;
-				  BIO_get_mem_data(bio, &str);
-				  do_setenv_x509(es, xt->name, str, depth);
-				}
-			    }
-			  BIO_free(bio);
-			}
-		    }
-		}
+	    case NID_sha1:
+	      {
+		char *sha1_fingerprint = format_hex_ex(x509->sha1_hash, SHA_DIGEST_LENGTH, 0, 1 | FHE_CAPS, ":", &gc);
+		do_setenv_x509(es, xt->name, sha1_fingerprint, depth);
+	      }
+	      break;
+	    default:
+	      {
+		int i = X509_NAME_get_index_by_NID(x509_name, xt->nid, -1);
+		if (i >= 0)
+		  {
+		    X509_NAME_ENTRY *ent = X509_NAME_get_entry(x509_name, i);
+		    if (ent)
+		      {
+			ASN1_STRING *val = X509_NAME_ENTRY_get_data (ent);
+			unsigned char *buf;
+			buf = (unsigned char *)1; /* bug in OpenSSL 0.9.6b ASN1_STRING_to_UTF8 requires this workaround */
+			if (ASN1_STRING_to_UTF8 (&buf, val) > 0)
+			  {
+			    do_setenv_x509(es, xt->name, (char *)buf, depth);
+			    OPENSSL_free (buf);
+			  }
+		      }
+		  }
+		else
+		  {
+		    i = X509_get_ext_by_NID(x509, xt->nid, -1);
+		    if (i >= 0)
+		      {
+			X509_EXTENSION *ext = X509_get_ext(x509, i);
+			if (ext)
+			  {
+			    BIO *bio = BIO_new(BIO_s_mem());
+			    if (bio)
+			      {
+				if (X509V3_EXT_print(bio, ext, 0, 0))
+				  {
+				    if (BIO_write(bio, &nullc, 1) == 1)
+				      {
+					char *str;
+					BIO_get_mem_data(bio, &str);
+					do_setenv_x509(es, xt->name, str, depth);
+				      }
+				  }
+				BIO_free(bio);
+			      }
+			  }
+		      }
+		  }
+	      }
 	    }
 	}
       xt = xt->next;
     }
+  gc_free(&gc);
 }
 #endif
 
-- 
1.9.1


