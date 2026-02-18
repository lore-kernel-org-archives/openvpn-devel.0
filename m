From: Gert Doering <gert@...1296...>
Date: Wed, 18 Feb 2026 22:47:06 +0100
Message-ID: <20260218214712.27119-1-gert@...1296...>
In-Reply-To: <gerrit.1771414879000.I632368451923116e0a169ddb5b6e86a8f8486afc@...2715...>
References: <gerrit.1771414879000.I632368451923116e0a169ddb5b6e86a8f8486afc@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] auth-pam: fix discards 'const' qualifier
 from pointer target type
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

strstr now returns const char*.

Change-Id: I632368451923116e0a169ddb5b6e86a8f8486afc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1543
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1543
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
index d7b544a..a4d2d0b 100644
--- a/src/plugins/auth-pam/utils.c
+++ b/src/plugins/auth-pam/utils.c
@@ -66,12 +66,11 @@
     /* state: all parameters are valid */
 
     const char *searching = tosearch;
-    char *scratch;
 
     char temp[templen + 1];
     temp[0] = 0;
 
-    scratch = strstr(searching, searchfor);
+    const char *scratch = strstr(searching, searchfor);
     if (!scratch)
     {
         return strdup(tosearch);

