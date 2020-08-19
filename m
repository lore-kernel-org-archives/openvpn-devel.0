From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 19 Aug 2020 10:07:46 +0300
Message-Id: <20200819070746.197-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] tun.c: enable using wintun driver under
 SYSTEM
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Commit 6d19775a468 has removed SYSTEM elevation hack,
but introduced regression - inability to use wintun without interactive service.

Proceed with ring buffers registration even if iservice is unavailable and display
relevant error message.

Trac #1318

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/tun.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 30454454..62557364 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6158,12 +6158,32 @@ wintun_register_ring_buffer(struct tuntap *tt, const char *device_guid)
     }
     else
     {
-        msg(M_FATAL, "ERROR:  Wintun requires SYSTEM privileges and therefore "
-                     "should be used with interactive service. If you want to "
-                     "use openvpn from command line, you need to do SYSTEM "
-                     "elevation yourself (for example with psexec).");
-    }
+        if (!register_ring_buffers(tt->hand,
+                                   tt->wintun_send_ring,
+                                   tt->wintun_receive_ring,
+                                   tt->rw_handle.read,
+                                   tt->rw_handle.write))
+        {
+            switch (GetLastError())
+            {
+                case ERROR_ACCESS_DENIED:
+                    msg(M_FATAL, "ERROR:  Wintun requires SYSTEM privileges and therefore "
+                                 "should be used with interactive service. If you want to "
+                                 "use openvpn from command line, you need to do SYSTEM "
+                                 "elevation yourself (for example with psexec).");
+                    break;
+
+                case ERROR_ALREADY_INITIALIZED:
+                    msg(M_NONFATAL, "Adapter %s is already in use", device_guid);
+                    break;
 
+                default:
+                    msg(M_NONFATAL | M_ERRNO, "Failed to register ring buffers");
+            }
+            ret = false;
+        }
+
+    }
     return ret;
 }
 
-- 
2.17.1


