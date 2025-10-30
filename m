From: Gert Doering <gert@...1296...>
Date: Thu, 30 Oct 2025 20:29:57 +0100
Message-ID: <20251030193003.348-1-gert@...1296...>
In-Reply-To: <gerrit.1761737448000.I70e221ff5d9752fec17bad18fd41dcf188ae8fbc@...2715...>
References: <gerrit.1761737448000.I70e221ff5d9752fec17bad18fd41dcf188ae8fbc@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Ensure that get_sigtype always return
 non-NULL
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

From: Arne Schwabe <arne@...1227...>

There is a theoretical possibility that OpenSSL returns an NID that
OBJ_nid2sn cannot resolve and thus the function return NULL.

This is however extremely unlikely. But we still cover this case now
to make linters/code checker happy and avoid similar false positives
in the future.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)
Change-Id: I70e221ff5d9752fec17bad18fd41dcf188ae8fbc
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1325
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1325
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index d997141..a4a6863 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2408,7 +2408,17 @@
             return "(error getting name)";
 
         default:
-            return OBJ_nid2sn(nid);
+        {
+            const char *type = OBJ_nid2sn(nid);
+            if (!type)
+            {
+                /* This is unlikely to ever happen as OpenSSL is unlikely to
+                 * return an NID it cannot resolve itself but we silence
+                 * linter/code checkers here */
+                type = "(error getting name, OBJ_nid2sn failed)";
+            }
+            return type;
+        }
     }
 }
 #endif /* ifndef LIBRESSL_VERSION_NUMBER */

