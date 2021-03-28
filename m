From: Arne Schwabe <arne@...1227...>
Date: Sun, 28 Mar 2021 16:36:33 +0200
Message-Id: <20210328143633.10300-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix #elif TARGET_LINUX missing defined()
 call
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

I found this when playing with building OpenVPN with cmake.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/tun.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 9d995dd46..902665cc6 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -130,7 +130,7 @@ struct tuntap_options {
     int dns6_len;
 };
 
-#elif TARGET_LINUX
+#elif defined(TARGET_LINUX)
 
 struct tuntap_options {
     int txqueuelen;
-- 
2.30.1


