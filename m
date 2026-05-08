From: Gert Doering <gert@...1296...>
Date: Fri,  8 May 2026 17:34:53 +0200
Message-ID: <20260508153458.13848-1-gert@...1296...>
In-Reply-To: <gerrit.1778239616000.I0aeb4583707a80592ec2577fbb060f7fbcb73e48@...2715...>
References: <gerrit.1778239616000.I0aeb4583707a80592ec2577fbb060f7fbcb73e48@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] tun: Remove one useless if check
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

The condition was already checked in an outer if check.

Identified by cppcheck.

Change-Id: I0aeb4583707a80592ec2577fbb060f7fbcb73e48
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1677
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1677
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f46802f..e7193d8 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5772,13 +5772,10 @@
                 continue;
             }
 
-            if (tt->backend_driver == DRIVER_DCO)
+            const char *last_sep = strrchr(dev_if->device_interface, '\\');
+            if (!last_sep || strcmp(last_sep + 1, DCO_WIN_REFERENCE_STRING) != 0)
             {
-                char *last_sep = strrchr(dev_if->device_interface, '\\');
-                if (!last_sep || strcmp(last_sep + 1, DCO_WIN_REFERENCE_STRING) != 0)
-                {
-                    continue;
-                }
+                continue;
             }
 
             path = dev_if->device_interface;

