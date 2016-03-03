From: James Yonan <james@...515...>
Date: Thu,  3 Mar 2016 01:19:03 -0700
Message-Id: <1456993146-63968-7-git-send-email-james@...515...>
In-Reply-To: <1456993146-63968-1-git-send-email-james@...515...>
References: <1456993146-63968-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH 07/10] Implemented x509-track for PolarSSL.
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

Signed-off-by: James Yonan <james@...515...>
---
 src/openvpn/ssl_verify_polarssl.c | 166 ++++++++++++++++++++++++++++++++++++++
 src/openvpn/syshead.h             |   2 +-
 2 files changed, 167 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index 9d0d086..ab693d2 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -198,6 +198,172 @@ x509_get_subject(x509_crt *cert, struct gc_arena *gc)
   return subject;
 }
 
+#ifdef ENABLE_X509_TRACK
+
+/* these match NID's in OpenSSL crypto/objects/objects.h */
+#define NID_undef			0
+#define NID_sha1                        64
+#define NID_commonName                  13
+#define NID_countryName                 14
+#define NID_localityName                15
+#define NID_stateOrProvinceName         16
+#define NID_organizationName		17
+#define NID_organizationalUnitName      18
+#define NID_pkcs9_emailAddress          48
+
+struct nid_entry {
+  const char *name;
+  int nid;
+};
+
+static const struct nid_entry nid_list[] = {
+  { "SHA1",         NID_sha1 },
+  { "CN",           NID_commonName },
+  { "C",            NID_countryName },
+  { "L",            NID_localityName },
+  { "ST",           NID_stateOrProvinceName },
+  { "O",            NID_organizationName },
+  { "OU",           NID_organizationalUnitName },
+  { "emailAddress", NID_pkcs9_emailAddress },
+  { NULL, 0 }
+};
+
+static int
+name_to_nid(const char *name)
+{
+  const struct nid_entry *e = nid_list;
+  while (e->name)
+    {
+      if (!strcmp(name, e->name))
+	return e->nid;
+      ++e;
+    }
+  return NID_undef;
+}
+
+static void
+do_setenv_x509 (struct env_set *es, const char *name, char *value, int depth)
+{
+  char *name_expand;
+  size_t name_expand_size;
+
+  string_mod (value, CC_ANY, CC_CRLF, '?');
+  msg (D_X509_ATTR, "X509 ATTRIBUTE name='%s' value='%s' depth=%d", name, value, depth);
+  name_expand_size = 64 + strlen (name);
+  name_expand = (char *) malloc (name_expand_size);
+  check_malloc_return (name_expand);
+  openvpn_snprintf (name_expand, name_expand_size, "X509_%d_%s", depth, name);
+  setenv_str (es, name_expand, value);
+  free (name_expand);
+}
+
+static void
+do_setenv_nid_value(struct env_set *es, const struct x509_track *xt, const x509_name *xn,
+		    int depth, struct gc_arena *gc)
+{
+  size_t i;
+  char *val;
+
+  for (i = 0; i < xn->val.len; ++i)
+    if (xn->val.p[i] == '\0') /* error if embedded null in value */
+      return;
+  val = gc_malloc(xn->val.len+1, false, gc);
+  memcpy(val, xn->val.p, xn->val.len);
+  val[xn->val.len] = '\0';
+  do_setenv_x509(es, xt->name, val, depth);
+}
+
+static void
+do_setenv_nid(struct env_set *es, const struct x509_track *xt, const x509_crt *cert,
+	      int depth, struct gc_arena *gc)
+{
+  const x509_name *xn;
+  for (xn = &cert->subject; xn != NULL; xn = xn->next)
+    {
+      switch (xt->nid)
+	{
+	case NID_commonName:
+	  if (OID_CMP(OID_AT_CN, &xn->oid))
+	    do_setenv_nid_value(es, xt, xn, depth, gc);
+	  break;
+	case NID_countryName:
+	  if (OID_CMP(OID_AT_COUNTRY, &xn->oid))
+	    do_setenv_nid_value(es, xt, xn, depth, gc);
+	  break;
+	case NID_localityName:
+	  if (OID_CMP(OID_AT_LOCALITY, &xn->oid))
+	    do_setenv_nid_value(es, xt, xn, depth, gc);
+	  break;
+	case NID_stateOrProvinceName:
+	  if (OID_CMP(OID_AT_STATE, &xn->oid))
+	    do_setenv_nid_value(es, xt, xn, depth, gc);
+	  break;
+	case NID_organizationName:
+	  if (OID_CMP(OID_AT_ORGANIZATION, &xn->oid))
+	    do_setenv_nid_value(es, xt, xn, depth, gc);
+	  break;
+	case NID_organizationalUnitName:
+	  if (OID_CMP(OID_AT_ORG_UNIT, &xn->oid))
+	    do_setenv_nid_value(es, xt, xn, depth, gc);
+	  break;
+	case NID_pkcs9_emailAddress:
+	  if (OID_CMP(OID_PKCS9_EMAIL, &xn->oid))
+	    do_setenv_nid_value(es, xt, xn, depth, gc);
+	  break;
+	}
+    }
+}
+
+void
+x509_track_add (const struct x509_track **ll_head, const char *name, int msglevel, struct gc_arena *gc)
+{
+  struct x509_track *xt;
+  ALLOC_OBJ_CLEAR_GC (xt, struct x509_track, gc);
+  if (*name == '+')
+    {
+      xt->flags |= XT_FULL_CHAIN;
+      ++name;
+    }
+  xt->name = name;
+  xt->nid = name_to_nid(name);
+  if (xt->nid != NID_undef)
+    {
+      xt->next = *ll_head;
+      *ll_head = xt;
+    }
+  else
+    msg(msglevel, "x509_track: no such attribute '%s'", name);
+}
+
+void
+x509_setenv_track (const struct x509_track *xt, struct env_set *es, const int depth, x509_crt *cert)
+{
+  struct gc_arena gc = gc_new();
+  while (xt)
+    {
+      if (depth == 0 || (xt->flags & XT_FULL_CHAIN))
+	{
+	  switch (xt->nid)
+	    {
+	    case NID_sha1:
+	      {
+		unsigned char *sha1_hash = x509_get_sha1_hash(cert, &gc);
+		char *sha1_fingerprint = format_hex_ex(sha1_hash, SHA_DIGEST_LENGTH, 0, 1 | FHE_CAPS, ":", &gc);
+		do_setenv_x509(es, xt->name, sha1_fingerprint, depth);
+	      }
+	      break;
+	    default:
+	      do_setenv_nid(es, xt, cert, depth, &gc);
+	      break;
+	    }
+	}
+      xt = xt->next;
+    }
+  gc_free(&gc);
+}
+
+#endif
+
 /*
  * Save X509 fields to environment, using the naming convention:
  *
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 7e77b6c..25aa69b 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -634,7 +634,7 @@ socket_defined (const socket_descriptor_t sd)
 /*
  * Enable x509-track feature?
  */
-#if defined(ENABLE_CRYPTO) && defined (ENABLE_CRYPTO_OPENSSL)
+#if defined(ENABLE_CRYPTO) && (defined(ENABLE_CRYPTO_OPENSSL) || defined(ENABLE_CRYPTO_POLARSSL))
 #define ENABLE_X509_TRACK
 #endif
 
-- 
1.9.1


