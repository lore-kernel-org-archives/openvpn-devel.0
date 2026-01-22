From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 22 Jan 2026 13:58:28 +0100
Message-ID: <20260122125829.108470-1-frank@...2641...>
In-Reply-To: <gerrit.1766154731000.I380e842b7429060d13bc0264e55fa5c06ab427df@...2715...>
References: <gerrit.1766154731000.I380e842b7429060d13bc0264e55fa5c06ab427df@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] ssl_ncp: Avoid conversion warning in
 replace_default_in_ncp_ciphers_option
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
Cc: Arne Schwabe <arne-openvpn@...1227...>

Change-Id: I380e842b7429060d13bc0264e55fa5c06ab427df
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1452
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1452
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index d4519b0..06262fe 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -534,11 +534,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  * Replaces the string DEFAULT with the string \c replace.
  *
@@ -549,12 +544,13 @@
 replace_default_in_ncp_ciphers_option(struct options *o, const char *replace)
 {
     const char *search = "DEFAULT";
-    const int ncp_ciphers_len = strlen(o->ncp_ciphers) + strlen(replace) - strlen(search) + 1;
+    const size_t ncp_ciphers_len = strlen(o->ncp_ciphers) + strlen(replace) - strlen(search) + 1;
 
     uint8_t *ncp_ciphers = gc_malloc(ncp_ciphers_len, true, &o->gc);
 
     struct buffer ncp_ciphers_buf;
-    buf_set_write(&ncp_ciphers_buf, ncp_ciphers, ncp_ciphers_len);
+    ASSERT(ncp_ciphers_len <= INT_MAX);
+    buf_set_write(&ncp_ciphers_buf, ncp_ciphers, (int)ncp_ciphers_len);
 
     const char *def = strstr(o->ncp_ciphers, search);
 
@@ -571,10 +567,6 @@
     o->ncp_ciphers = (char *)ncp_ciphers;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  * Checks for availibility of Chacha20-Poly1305 and sets
  * the ncp_cipher to either AES-256-GCM:AES-128-GCM or

