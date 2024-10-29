From: Antonio Quartulli <a@...2181...>
Date: Tue, 29 Oct 2024 14:38:58 +0100
Message-ID: <20241029133858.22873-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] sitnl: replace NLMSG_TAIL macro with
 nlmsg_tail() function
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
Cc: Antonio Quartulli <antonio@...2726...>

From: Antonio Quartulli <antonio@...2726...>

The NLMSG_TAIL macro never had any reason to exist, because libnl
already provides a function doing exactly the same: nlmsg_tail().

Moreover, this macro was found to confuse gcc when compiling with -O3,
which would result in subsequent warnings like:

networking_sitnl.c:143:9: warning: writing 4 bytes into a region of size 0 [-Wstringop-overflow=]
  143 |         memcpy(RTA_DATA(rta), data, alen);
      |         ^
networking_sitnl.c:101:21: note: at offset [72, 88] into destination object ‘n’ of size 16
  101 |     struct nlmsghdr n;
      |                     ^

(Above warnings are critical on Fedora 40 as they are turned into errors)

Delete the macro, replace it with nlmsg_tail() and get rid of the
warnings.

Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
 src/openvpn/networking_sitnl.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index f53f5ee9..8eeab72a 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -40,6 +40,7 @@
 #include <sys/socket.h>
 #include <linux/netlink.h>
 #include <linux/rtnetlink.h>
+#include <netlink/msg.h>
 
 #define SNDBUF_SIZE (1024 * 2)
 #define RCVBUF_SIZE (1024 * 4)
@@ -52,19 +53,16 @@
         }                                                           \
     }
 
-#define NLMSG_TAIL(nmsg) \
-    ((struct rtattr *)(((uint8_t *)(nmsg)) + NLMSG_ALIGN((nmsg)->nlmsg_len)))
-
 #define SITNL_NEST(_msg, _max_size, _attr)              \
     ({                                                  \
-        struct rtattr *_nest = NLMSG_TAIL(_msg);        \
+        struct rtattr *_nest = nlmsg_tail(_msg);        \
         SITNL_ADDATTR(_msg, _max_size, _attr, NULL, 0); \
         _nest;                                          \
     })
 
 #define SITNL_NEST_END(_msg, _nest)                                 \
     {                                                               \
-        _nest->rta_len = (void *)NLMSG_TAIL(_msg) - (void *)_nest;  \
+        _nest->rta_len = (void *)nlmsg_tail(_msg) - (void *)_nest;  \
     }
 
 /**
@@ -130,7 +128,7 @@ sitnl_addattr(struct nlmsghdr *n, int maxlen, int type, const void *data,
         return -EMSGSIZE;
     }
 
-    rta = NLMSG_TAIL(n);
+    rta = nlmsg_tail(n);
     rta->rta_type = type;
     rta->rta_len = len;
 
-- 
2.45.2


