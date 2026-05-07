From: Gert Doering <gert@...1296...>
Date: Thu,  7 May 2026 09:54:56 +0200
Message-ID: <20260507075502.25473-1-gert@...1296...>
In-Reply-To: <gerrit.1778018195000.Ia7ad24181bd97dccbb77865c10e829778f72a506@...2715...>
References: <gerrit.1778018195000.Ia7ad24181bd97dccbb77865c10e829778f72a506@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] sample: Fix cppcheck error
 invalidPrintfArgType_sint
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

Change-Id: Ia7ad24181bd97dccbb77865c10e829778f72a506
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1662
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1662
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
index deae590..d2d44c7 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -91,7 +91,7 @@
     }
 
     /* Print some version information about the OpenVPN process using this plug-in */
-    printf("log_v3: OpenVPN %s  (Major: %i, Minor: %i, Patch: %s)\n", args->ovpn_version,
+    printf("log_v3: OpenVPN %s  (Major: %u, Minor: %u, Patch: %s)\n", args->ovpn_version,
            args->ovpn_version_major, args->ovpn_version_minor, args->ovpn_version_patch);
 
     /*  Which callbacks to intercept.  */
diff --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plugins/simple/base64.c
index ab6aed8..3b11543 100644
--- a/sample/sample-plugins/simple/base64.c
+++ b/sample/sample-plugins/simple/base64.c
@@ -122,7 +122,7 @@
     ovpn_base64_decode = args->callbacks->plugin_base64_decode;
 
     /* Print some version information about the OpenVPN process using this plug-in */
-    ovpn_log(PLOG_NOTE, PLUGIN_NAME, "OpenVPN %s  (Major: %i, Minor: %i, Patch: %s)\n",
+    ovpn_log(PLOG_NOTE, PLUGIN_NAME, "OpenVPN %s  (Major: %u, Minor: %u, Patch: %s)\n",
              args->ovpn_version, args->ovpn_version_major, args->ovpn_version_minor,
              args->ovpn_version_patch);
 

