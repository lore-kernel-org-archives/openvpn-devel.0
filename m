From: Ilya Shipitsin <chipitsine@...277...>
Date: Thu, 18 May 2023 23:21:39 +0200
Message-Id: <20230518212139.1261-1-chipitsine@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] src/openvpn/dco_freebsd.c: handle malloc
 failure
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

malloc was not checked against NULL, I was able
to get core dump in case of failure

Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
---
v2:
 - style correction

 src/openvpn/dco_freebsd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 1111abeb..af7776bb 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -594,6 +594,10 @@ dco_available(int msglevel)
     }
 
     buf = malloc(ifcr.ifcr_total * IFNAMSIZ);
+    if (!buf)
+    {
+        goto out;
+    }
 
     ifcr.ifcr_count = ifcr.ifcr_total;
     ifcr.ifcr_buffer = buf;
-- 
2.35.3.windows.1


