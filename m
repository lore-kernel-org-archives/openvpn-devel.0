From: Gert Doering <gert@...1296...>
Date: Wed,  8 Oct 2025 19:01:57 +0200
Message-ID: <20251008170202.10333-1-gert@...1296...>
In-Reply-To: <gerrit.1759942426000.Id08524661aa5bcc5cd42f27a1aacc636e2b2b004@...2715...>
References: <gerrit.1759942426000.Id08524661aa5bcc5cd42f27a1aacc636e2b2b004@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] options_util: Fix conversion warning in
 atoi_constrained
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

From: Frank Lichtenheld <frank@...2641...>

The whole purpose of the function is to make sure
that cast is safe.

Change-Id: Id08524661aa5bcc5cd42f27a1aacc636e2b2b004
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1261
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1261
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index 8a1c083..eba7d39 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -162,11 +162,6 @@
     return (int)i;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
 atoi_constrained(const char *str, int *value, const char *name, int min, int max, msglvl_t msglevel)
 {
@@ -194,14 +189,10 @@
         return false;
     }
 
-    *value = i;
+    *value = (int)i;
     return true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static const char *updatable_options[] = { "block-ipv6", "block-outside-dns",
                                            "dhcp-option", "dns",
                                            "ifconfig", "ifconfig-ipv6",

