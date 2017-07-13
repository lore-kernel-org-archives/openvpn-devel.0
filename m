From: Antonio Quartulli <a@...2181...>
Date: Thu, 13 Jul 2017 16:05:27 +0800
Message-Id: <20170713080527.13299-2-a@...2181...>
In-Reply-To: <20170713080527.13299-1-a@...2181...>
References: <20170713080527.13299-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 2/2] don't print errno twice
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

when passing the M_ERRNO flag to msg(), the latter will already
print the errno message (in a form of a string and number) for us,
hence there is no need to explicitly print it a second time.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---

- compile tested with travis-ci

 src/openvpn/platform.c |  2 +-
 src/openvpn/tun.c      | 12 +++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 2495523f..d936890e 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -159,7 +159,7 @@ platform_nice(int niceval)
         errno = 0;
         if (nice(niceval) < 0 && errno != 0)
         {
-            msg(M_WARN | M_ERRNO, "WARNING: nice %d failed: %s", niceval, strerror(errno));
+            msg(M_WARN | M_ERRNO, "WARNING: nice %d failed", niceval);
         }
         else
         {
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index c09f9700..68fb4889 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -2563,8 +2563,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 
         if (ioctl(tt->fd, TUNGIFINFO, &info) < 0)
         {
-            msg(M_WARN | M_ERRNO, "Can't get interface info: %s",
-                strerror(errno));
+            msg(M_WARN | M_ERRNO, "Can't get interface info");
         }
 
 #ifdef IFF_MULTICAST /* openbsd 4.x doesn't have this */
@@ -2573,8 +2572,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 
         if (ioctl(tt->fd, TUNSIFINFO, &info) < 0)
         {
-            msg(M_WARN | M_ERRNO, "Can't set interface info: %s",
-                strerror(errno));
+            msg(M_WARN | M_ERRNO, "Can't set interface info");
         }
     }
 }
@@ -2663,7 +2661,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
             i = 1;
             if (ioctl(tt->fd, TUNSIFHEAD, &i) < 0)      /* multi-af mode on */
             {
-                msg(M_WARN | M_ERRNO, "ioctl(TUNSIFHEAD): %s", strerror(errno));
+                msg(M_WARN | M_ERRNO, "ioctl(TUNSIFHEAD)");
             }
         }
     }
@@ -2796,12 +2794,12 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 
         if (ioctl(tt->fd, TUNSIFMODE, &i) < 0)
         {
-            msg(M_WARN | M_ERRNO, "ioctl(TUNSIFMODE): %s", strerror(errno));
+            msg(M_WARN | M_ERRNO, "ioctl(TUNSIFMODE)");
         }
         i = 1;
         if (ioctl(tt->fd, TUNSIFHEAD, &i) < 0)
         {
-            msg(M_WARN | M_ERRNO, "ioctl(TUNSIFHEAD): %s", strerror(errno));
+            msg(M_WARN | M_ERRNO, "ioctl(TUNSIFHEAD)");
         }
     }
 }
-- 
2.13.2


