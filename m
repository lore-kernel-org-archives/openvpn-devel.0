From: Gert Doering <gert@...1296...>
Date: Mon,  3 Nov 2025 15:59:56 +0100
Message-ID: <20251103150002.23187-1-gert@...1296...>
In-Reply-To: <gerrit.1762180786000.I356faeebfade1eed9b40d6700b13621c357ec5ac@...2715...>
References: <gerrit.1762180786000.I356faeebfade1eed9b40d6700b13621c357ec5ac@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] openvpnserv: Disallow stdin as config
 unless user is authorized
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

Reported by: <stephan@...2953...>

Change-Id: I356faeebfade1eed9b40d6700b13621c357ec5ac
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1343
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1343
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 2187fb5..ddaa381 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -68,6 +68,11 @@
     const WCHAR *config_file = NULL;
     WCHAR config_dir[MAX_PATH];
 
+    /* fname = stdin is special: do not treat it as a relative path */
+    if (wcscmp(fname, L"stdin") == 0)
+    {
+        return FALSE;
+    }
     /* convert fname to full path */
     if (PathIsRelativeW(fname))
     {

