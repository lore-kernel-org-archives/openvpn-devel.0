From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 26 Mar 2024 11:38:53 +0100
Message-Id: <20240326103853.494572-1-frank@...2641...>
In-Reply-To: <gerrit.1711123201000.Ia73d53002f4ba2658af18c17cce1b68f79de5781@...2715...>
References: <gerrit.1711123201000.Ia73d53002f4ba2658af18c17cce1b68f79de5781@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Add bracket in fingerprint message and
 do not warn about missing verification
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
Cc: Arne Schwabe <arne@...1227...>, Arne Schwabe <arne-openvpn@...1227...>

From: Arne Schwabe <arne@...1227...>

Change-Id: Ia73d53002f4ba2658af18c17cce1b68f79de5781
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/546
This mail reflects revision 1 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

Note: Missing whitespace added for submission.

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f2ce926..a398920 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3594,7 +3594,8 @@
         && !o->tls_verify
         && o->verify_x509_type == VERIFY_X509_NONE
         && !(o->ns_cert_type & NS_CERT_CHECK_SERVER)
-        && !o->remote_cert_eku)
+        && !o->remote_cert_eku
+        && !(o->verify_hash_depth == 0 && o->verify_hash))
     {
         msg(M_WARN, "WARNING: No server certificate verification method has been enabled.  See http://openvpn.net/howto.html#mitm for more info.");
     }
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index c7d7799..930769b 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -718,8 +718,8 @@
             const char *hex_fp = format_hex_ex(BPTR(&cert_fp), BLEN(&cert_fp),
                                                0, 1, ":", &gc);
             msg(D_TLS_ERRORS, "TLS Error: --tls-verify/--peer-fingerprint"
-                "certificate hash verification failed. (got "
-                "fingerprint: %s", hex_fp);
+                "certificate hash verification failed. (got certificate "
+                "fingerprint: %s)", hex_fp);
             goto cleanup;
         }
     }

