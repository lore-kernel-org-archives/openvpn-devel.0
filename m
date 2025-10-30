From: Gert Doering <gert@...1296...>
Date: Thu, 30 Oct 2025 20:39:34 +0100
Message-ID: <20251030193940.1295-1-gert@...1296...>
In-Reply-To: <gerrit.1761744141000.I94d2bdd234a1c416b78924d044bf7e57f1bed8c4@...2715...>
References: <gerrit.1761744141000.I94d2bdd234a1c416b78924d044bf7e57f1bed8c4@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] fix key_state_gen_auth_control_files
 probably checking file creation
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

When the auth_failed_reason_file was added, it was forgotten to also add it
to the conditions that determine if the file creation was successful.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)
Change-Id: I94d2bdd234a1c416b78924d044bf7e57f1bed8c4
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1327
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1327
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 04ef27e..446c4a7 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -992,7 +992,7 @@
     const char *apf = platform_create_temp_file(opt->tmp_dir, "apf", &gc);
     const char *afr = platform_create_temp_file(opt->tmp_dir, "afr", &gc);
 
-    if (acf && apf)
+    if (acf && apf && afr)
     {
         ads->auth_control_file = string_alloc(acf, NULL);
         ads->auth_pending_file = string_alloc(apf, NULL);
@@ -1004,7 +1004,7 @@
     }
 
     gc_free(&gc);
-    return (acf && apf);
+    return (acf && apf && afr);
 }
 
 /**

