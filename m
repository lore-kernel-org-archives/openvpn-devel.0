From: Steffan Karger <steffan@...1856...>
Date: Sat, 28 Nov 2015 11:03:49 +0100
Message-Id: <1448705029-9062-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Support duplicate x509 field values in
	environment
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

As reported in trac #387, an x509 DN can contain duplicate fields.
Previously, we would overwrite any previous field value with a new one if
we would process a second same-name field.  Now, instead, append _$N,
starting at N=1 to the name for each consequent field to export all fields
to the enviroment.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 Changes.rst                       |  7 +++++++
 src/openvpn/misc.c                | 32 ++++++++++++++++++++++++++++++++
 src/openvpn/misc.h                |  7 +++++++
 src/openvpn/ssl_verify_openssl.c  |  2 +-
 src/openvpn/ssl_verify_polarssl.c |  2 +-
 5 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 41629bd..a791ca3 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -36,6 +36,13 @@ LZ4 Compression
 
 User-visible Changes
 --------------------
+- For certificate DNs with duplicate fields, e.g. "OU=one,OU=two", both fields
+  are now exported to the environment, where each second and later occurrence
+  of a field get _$N appended to it's field name, starting at N=1.  For the
+  example above, that would result in e.g. X509_0_OU=one, X509_0_OU_1=two.
+  Note that this breaks setups that rely on the fact that OpenVPN would
+  previously (incorrectly) only export the last occurence of a field.
+
 - proto udp and proto tcp specify to use IPv4 and IPv6. The new
   options proto udp4 and tcp4 specify to use IPv4 only.
 
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 0f04d09..1c5b455 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -607,6 +607,16 @@ env_set_add (struct env_set *es, const char *str)
   env_set_add_nolock (es, str);
 }
 
+const char*
+env_set_get (struct env_set *es, const char *name)
+{
+  struct env_item *item = es->list;
+  while (item && !env_string_equal(item->string, name)) {
+      item = item->next;
+  }
+  return item ? item->string : NULL;
+}
+
 void
 env_set_print (int msglevel, const struct env_set *es)
 {
@@ -741,6 +751,28 @@ setenv_str_safe (struct env_set *es, const char *name, const char *value)
     msg (M_WARN, "setenv_str_safe: name overflow");
 }
 
+void setenv_str_incr(struct env_set *es, const char *name, const char *value)
+{
+  unsigned int counter = 1;
+  const size_t tmpname_len = strlen(name) + 5;
+  char *tmpname = gc_malloc(tmpname_len, true, NULL); /* 3 digits counter max */
+  memcpy(tmpname, name, strlen(name));
+  while (NULL != env_set_get(es, tmpname) && counter < 1000)
+    {
+      ASSERT (openvpn_snprintf (tmpname, tmpname_len, "%s_%u", name, counter));
+      counter++;
+    }
+  if (counter < 1000)
+    {
+      setenv_str (es, tmpname, value);
+    }
+  else
+    {
+      msg (D_TLS_DEBUG_MED, "Too many same-name env variables, ignoring: %s", name);
+    }
+  free (tmpname);
+}
+
 void
 setenv_del (struct env_set *es, const char *name)
 {
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index ec2e417..d8b2c18 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -133,6 +133,12 @@ void setenv_str (struct env_set *es, const char *name, const char *value);
 void setenv_str_safe (struct env_set *es, const char *name, const char *value);
 void setenv_del (struct env_set *es, const char *name);
 
+/**
+ * Store the supplied name value pair in the env_set.  If the variable with the
+ * supplied name  already exists, append _N to the name, starting at N=1.
+ */
+void setenv_str_incr(struct env_set *es, const char *name, const char *value);
+
 void setenv_int_i (struct env_set *es, const char *name, const int value, const int i);
 void setenv_str_i (struct env_set *es, const char *name, const char *value, const int i);
 
@@ -142,6 +148,7 @@ struct env_set *env_set_create (struct gc_arena *gc);
 void env_set_destroy (struct env_set *es);
 bool env_set_del (struct env_set *es, const char *str);
 void env_set_add (struct env_set *es, const char *str);
+const char* env_set_get (struct env_set *es, const char *name);
 
 void env_set_print (int msglevel, const struct env_set *es);
 
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index bf53522..d014f9d 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -448,7 +448,7 @@ x509_setenv (struct env_set *es, int cert_depth, openvpn_x509_cert_t *peer_cert)
 	  objbuf);
       string_mod (name_expand, CC_PRINT, CC_CRLF, '_');
       string_mod ((char*)buf, CC_PRINT, CC_CRLF, '_');
-      setenv_str (es, name_expand, (char*)buf);
+      setenv_str_incr (es, name_expand, (char*)buf);
       free (name_expand);
       OPENSSL_free (buf);
     }
diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index 62818ad..a2e6a8e 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -245,7 +245,7 @@ x509_setenv (struct env_set *es, int cert_depth, openvpn_x509_cert_t *cert)
 	/* Check both strings, set environment variable */
 	string_mod (name_expand, CC_PRINT, CC_CRLF, '_');
 	string_mod ((char*)s, CC_PRINT, CC_CRLF, '_');
-	setenv_str (es, name_expand, (char*)s);
+	setenv_str_incr (es, name_expand, (char*)s);
 
 	name = name->next;
     }
-- 
2.5.0


