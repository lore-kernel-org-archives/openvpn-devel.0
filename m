From: Gert Doering <gert@...1296...>
Date: Tue, 14 Apr 2026 07:58:24 +0200
Message-ID: <20260414055830.17032-1-gert@...1296...>
In-Reply-To: <gerrit.1775698562000.I6e7947ab81cf229f0d27714dd563a07ace6bd38a@...2715...>
References: <gerrit.1775698562000.I6e7947ab81cf229f0d27714dd563a07ace6bd38a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] verify_x509_name: Improve the error
 message on failure
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

From: Selva Nair <selva.nair@...277...>

Print the actual string that was used for the match instead of the
whole subject.

Github: closes OpenVPN/openvpn#992

Change-Id: I6e7947ab81cf229f0d27714dd563a07ace6bd38a
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1624
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1624
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index d44f25f..21b516d 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -369,21 +369,32 @@
     /* verify X509 name or username against --verify-x509-[user]name */
     if (opt->verify_x509_type != VERIFY_X509_NONE)
     {
-        if ((opt->verify_x509_type == VERIFY_X509_SUBJECT_DN
-             && strcmp(opt->verify_x509_name, subject) == 0)
-            || (opt->verify_x509_type == VERIFY_X509_SUBJECT_RDN
-                && strcmp(opt->verify_x509_name, common_name) == 0)
-            || (opt->verify_x509_type == VERIFY_X509_SUBJECT_RDN_PREFIX
-                && strncmp(opt->verify_x509_name, common_name, strlen(opt->verify_x509_name)) == 0))
+        const char *err_fmt = "VERIFY X509NAME ERROR: %s, must be %s";
+        const char *match_str = common_name;
+        bool verified = false;
+        switch (opt->verify_x509_type)
         {
-            msg(D_HANDSHAKE, "VERIFY X509NAME OK: %s", subject);
+            case VERIFY_X509_SUBJECT_DN:
+                match_str = subject;
+                verified = !strcmp(opt->verify_x509_name, match_str);
+                break;
+            case VERIFY_X509_SUBJECT_RDN:
+                verified = !strcmp(opt->verify_x509_name, match_str);
+                break;
+            case VERIFY_X509_SUBJECT_RDN_PREFIX:
+                err_fmt = "VERIFY X509NAME ERROR: %s, must start with %s";
+                verified = !strncmp(opt->verify_x509_name, match_str, strlen(opt->verify_x509_name));
+                break;
+            default:
+                ASSERT(0); /* should not happen */
+                break;
         }
-        else
+        if (!verified)
         {
-            msg(D_HANDSHAKE, "VERIFY X509NAME ERROR: %s, must be %s", subject,
-                opt->verify_x509_name);
-            return FAILURE; /* Reject connection */
+            msg(D_HANDSHAKE, err_fmt, match_str, opt->verify_x509_name);
+            return FAILURE;
         }
+        msg(D_HANDSHAKE, "VERIFY X509NAME OK: %s", subject);
     }
 
     return SUCCESS;

